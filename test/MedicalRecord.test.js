const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("MedicalRecord", () => {
    let medical, user, transactionResponse, transactionReceipt;
    beforeEach(async () => {
        const account = await ethers.getSigners();
        user = account[1];
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
                    "fred",
                    20,
                    "male",
                    "coughing, mild fever",
                    "consume medication, rest",
                    "cough syrup, antibiotic"
                );

            transactionReceipt = await transactionResponse.wait();
        });
        it("Emits add record event", async () => {
            const event = await transactionReceipt.logs[0];
            expect(event.fragment.name).to.equal("MedicalRecord__AddRecord");
            const args = event.args;
            expect(args.timestamp).to.not.equal(0);
            expect(args.name).to.equal("fred");
            expect(args.age).to.equal(20);
            expect(args.gender).to.equal("male");
            expect(args.diagnosis).to.equal("coughing, mild fever");
            expect(args.treatment).to.equal("consume medication, rest");
            expect(args.medication).to.equal("cough syrup, antibiotic");
        });
        it("The getRecord function is working", async () => {
            const [
                timestamp,
                name,
                age,
                gender,
                diagnosis,
                treatment,
                medication,
            ] = await medical.getRecord(await medical.getRecordId());
            expect(await medical.getRecordId()).to.equal(1);
            expect(timestamp).to.not.equal(0);
            expect(name).to.equal("fred");
            expect(age).to.equal(20);
            expect(gender).to.equal("male");
            expect(diagnosis).to.equal("coughing, mild fever");
            expect(treatment).to.equal("consume medication, rest");
            expect(medication).to.equal("cough syrup, antibiotic");
        });
    });
});
