#!/bin/bash

set -e
docker exec  circles-db psql -U postgres -d api -c "insert into news (message_en, date, \"iconId\", \"isActive\") values
('News 1', '2022-01-01', 12131232, true),
('News 2', '2022-02-02', 12131232, false),
('News 3', '2022-03-03', 12131232, true),
('News 4', '2022-04-10', 12131232, false),
('News 5', '2022-05-11', 12131232, true),
('News 6', '2022-06-12', 12131232, false),
('News 7', '2022-07-20', 12131232, true),
('News 8', '2022-08-21', 12131232, false),
('News 9', '2022-09-22', 12131232, true),
('News 10', '2022-09-30', 12131232, true);"
