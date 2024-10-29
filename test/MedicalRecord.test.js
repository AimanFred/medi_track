const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("MedicalRecord", () => {
    let medical, user, patientAdd, transactionResponse, transactionReceipt;
    beforeEach(async () => {
        const account = await ethers.getSigners();
        user = account[1];
        patientAdd = account[2];
        const Medical = await ethers.getContractFactory("MedicalRecord");
        medical = await Medical.deploy();
    });
    describe("Contract deployed", () => {
        it("Deploy contract successfully", async () => {
            expect(await medical.address).to.not.equal(0);
        });
    });
    describe("Add record", async () => {
        beforeEach(async () => {
            transactionResponse = await medical
                .connect(user)
                .addRecord(
                    patientAdd,
                    "bafkreibm6jg3ux5qumhcn2b3flc3tyu6dmlb4xa7u5bf44yegnrjhc4yeq"
                );

            transactionReceipt = await transactionResponse.wait();
        });
        it("Emits add record event", async () => {
            const event = await transactionReceipt.logs[0];
            expect(event.fragment.name).to.equal("MedicalRecord__AddRecord");
            const args = event.args;
            expect(args.timestamp).to.not.equal(0);
            expect(args.patient).to.equal(patientAdd);
            expect(args.recordHash).to.equal("bafkreibm6jg3ux5qumhcn2b3flc3tyu6dmlb4xa7u5bf44yegnrjhc4yeq");
        });
        it("The getRecord function is working", async () => {
            const [
                timestamp,
                patient,
                recordHash,
            ] = await medical.getRecord(await medical.getRecordId());
            expect(await medical.getRecordId()).to.equal(1);
            expect(timestamp).to.not.equal(0);
            expect(patient).to.equal(patientAdd);
            expect(recordHash).to.equal("bafkreibm6jg3ux5qumhcn2b3flc3tyu6dmlb4xa7u5bf44yegnrjhc4yeq");
        });
    });
});
