#!/usr/bin/python

import os
import subprocess
import sys
from datetime import datetime

BACKUP_DIR = os.environ["BACKUP_DIR"]
S3_PATH = os.environ["S3_PATH"]
DB_NAMES = os.environ["DB_NAMES"].split(',')
DB_PASS = os.environ["DB_PASS"]
DB_USER = os.environ["DB_USER"]
DB_HOST = os.environ["DB_HOST"]
MAIL_TO = os.environ.get("MAIL_TO")
MAIL_FROM = os.environ.get("MAIL_FROM")
WEBHOOK = os.environ.get("WEBHOOK")
WEBHOOK_METHOD = os.environ.get("WEBHOOK_METHOD") or "GET"
KEEP_BACKUP_DAYS = int(os.environ.get("KEEP_BACKUP_DAYS", 7))

dt = datetime.now()
file_names = [DB_NAME + "_" + dt.strftime("%Y-%m-%d") for DB_NAME in DB_NAMES]
backup_files = [os.path.join(BACKUP_DIR, file_name) for file_name in file_names]

if not S3_PATH.endswith("/"):
    S3_PATH = S3_PATH + "/"

def cmd(command):
    try:
        subprocess.check_output([command], shell=True, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        sys.stderr.write("\n".join([
            "Command execution failed. Output:",
            "-"*80,
            e.output.decode("utf-8"),
            "-"*80,
            ""
        ]))
        raise

def take_backup():
    for index, backup_file in enumerate(backup_files):
        # trigger postgres-backup
        cmd("env PGPASSWORD=%s pg_dump -Fc -h %s -U %s %s > %s" % (DB_PASS, DB_HOST, DB_USER, DB_NAMES[index], backup_file))

def upload_backup():
    for backup_file in backup_files:
        cmd("aws s3 cp --storage-class=STANDARD_IA %s %s" % (backup_file, S3_PATH))

def prune_local_backup_files():
    cmd("find %s -type f -prune -mtime +%i -exec rm -f {} \;" % (BACKUP_DIR, KEEP_BACKUP_DAYS))

def send_email(to_address, from_address, subject, body):
    """
    Super simple, doesn't do any escaping
    """
    cmd("""aws --region us-east-1 ses send-email --from %(from)s --destination '{"ToAddresses":["%(to)s"]}' --message '{"Subject":{"Data":"%(subject)s","Charset":"UTF-8"},"Body":{"Text":{"Data":"%(body)s","Charset":"UTF-8"}}}'""" % {
        "to": to_address,
        "from": from_address,
        "subject": subject,
        "body": body,
    })

def log(msg):
    print("[%s]: %s" % (datetime.now().strftime("%Y-%m-%d %H:%M:%S"), msg))

def main():
    start_time = datetime.now()
    log("Dumping database")
    take_backup()
    log("Uploading to S3")
    upload_backup()
    log("Pruning local backup copies")
    prune_local_backup_files()

    if MAIL_TO and MAIL_FROM:
        log("Sending mail to %s" % MAIL_TO)
        send_email(
            MAIL_TO,
            MAIL_FROM,
            "Backup complete: %s" % DB_NAME,
            "Took %.2f seconds" % (datetime.now() - start_time).total_seconds(),
        )

    if WEBHOOK:
        log("Making HTTP %s request to webhook: %s" % (WEBHOOK_METHOD, WEBHOOK))
        cmd("curl -X %s %s" % (WEBHOOK_METHOD, WEBHOOK))

    log("Backup complete, took %.2f seconds" % (datetime.now() - start_time).total_seconds())


if __name__ == "__main__":
    main()
