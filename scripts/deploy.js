const { ethers } = require("hardhat");
async function main() {
    console.log("Deploying smart contract..");
    const Medical = await ethers.getContractFactory("MedicalRecord");
    const accounts = await ethers.getSigners();
    const medical = await Medical.connect(accounts[0]).deploy();
    await medical.waitForDeployment();
    const address = await medical.getAddress();
    console.log("MedicalRecord contract is deployed at " + address);
}
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.log(error);
        process.exit(1);
    });
