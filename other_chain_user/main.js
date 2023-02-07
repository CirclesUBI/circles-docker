const Web3 = require('web3');

const web3 = new Web3(process.env.RPC_URL);

const send = async () => {
    const account = web3.eth.accounts.privateKeyToAccount(process.env.PRIVATE_KEY);
    const nonce = await web3.eth.getTransactionCount(account.address);
    const createTransaction = await account.signTransaction(
        {
            nonce: nonce,
            gas: 23000,
            gasPrice: 2000000000,
            to: process.env.TO_ADDRESS,
            value: web3.utils.toWei('0.0001', 'ether'),
            from: account.address,
            data: '0x'
        }
    );

    const createReceipt = await web3.eth.sendSignedTransaction(createTransaction.rawTransaction);
    console.log(`Transaction successful with hash: ${createReceipt.transactionHash}`);
};

// 6. Call send function
setInterval(async () => {
    await send();
}, 5000);
