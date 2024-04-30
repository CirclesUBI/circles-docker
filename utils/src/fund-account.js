import {getAddress, JsonRpcProvider, Wallet} from 'ethers';

const toAddress = process.argv[2];

if (!toAddress || !getAddress(toAddress)) {
    // Show usage instructions
    console.log(`Usage:`)
    console.log(`   node fund-account.js 0x...`)
}

const jsonRpc = new JsonRpcProvider("http://localhost:8545");
const wallet = Wallet.fromPhrase(
    "myth like bonus scare over problem client lizard pioneer submit female collect",
    jsonRpc);

const tx = await wallet.sendTransaction({
    to: toAddress,
    value: BigInt(100000000000000000)
});

const receipt = await tx.wait();
console.log(receipt);
