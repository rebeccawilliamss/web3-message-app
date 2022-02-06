const main = async () => {

    // Get wallet address of contract owner and random address
    const [owner, randomPerson] = await hre.ethers.getSigners();

    // Compile the contract and generate files
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");

    // Create local ETH network for this contract then destroy once script completes
    const waveContract = await waveContractFactory.deploy();

    // wait unntil contract is deployed to local blockchain
    await waveContract.deployed();

    // Gives us the address of the deployed contract
    console.log("Contract deployed to:", waveContract.address);

    // View the address of the person deploying the contract
    console.log("Contract deployed by:", owner.address);

    // Call the functions
    let msgCount;
    msgCount = await waveContract.getTotalMessages();

    let msgTxn = await waveContract.message();
    await msgTxn.wait();

    msgCount = await waveContract.getTotalMessages();
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