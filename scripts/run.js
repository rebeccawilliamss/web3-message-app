const main = async () => {

    // Compile the contract and generate files
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");

    // Create local ETH network for this contract then destroy once script completes
    const waveContract = await waveContractFactory.deploy({
        value: hre.ethers.utils.parseEther("0.1"),
    });

    // wait unntil contract is deployed to local blockchain
    await waveContract.deployed();

    // Gives us the address of the deployed contract
    console.log("Contract address", waveContract.address);

    let contractBalance = await hre.ethers.provider.getBalance(
        waveContract.address
    );
    console.log(
        "Contract balance:",
        hre.ethers.utils.formatEther(contractBalance)
    );

    // Call the functions
    let msgCount;
    msgCount = await waveContract.getTotalMessages();
    console.log(msgCount.toNumber());

    // send some messages
    let msgTxn = await waveContract.message("A message!");
    await msgTxn.wait(); // wait for the transaction to be mined

    // send some messages
    let msgTxn2 = await waveContract.message("Another message!");
    await msgTxn2.wait(); // wait for the transaction to be mined

    contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log(
      "Contract balance:",
      hre.ethers.utils.formatEther(contractBalance)
    );

    // // Get wallet address of contract owner and random address
    // const [_, randomPerson] = await hre.ethers.getSigners();
    // msgTxn = await waveContract.connect(randomPerson).message('Another message');
    // await msgTxn.wait(); // wait for transaction to be mined

    let allMsgs = await waveContract.getAllMsg();
    console.log(allMsgs);

};


const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();