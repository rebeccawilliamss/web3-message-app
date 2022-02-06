const main = async () => {

    // Compile the contract and generate files
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");

    // Create local ETH network for this contract then destroy once script completes
    const waveContract = await waveContractFactory.deploy();

    // wait unntil contract is deployed to local blockchain
    await waveContract.deployed();

    // Gives us the address of the deployed contract
    console.log("Contract deployed to:", waveContract.address);
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