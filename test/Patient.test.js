const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Patient", async () => {
    let patient, user, doctor1, doctor2, doctor3;

    beforeEach(async () => {
        const account = await ethers.getSigners();
        user = account[1];
        doctor1 = account[2];
        doctor2 = account[3];
        doctor3 = account[4];
        const Patient = await ethers.getContractFactory("Patient");
        patient = await Patient.deploy();
    });

    describe("Contract deployed", () => {
        it("Deploy contract successfully", async () => {
            expect(await patient.address).to.not.equal(0);
        });
    });
    describe("Add doctor", () => {
        it("add doctor address to the user", async () => {
            await patient.connect(user).addDoctor(doctor1.address);
            await patient.connect(user).addDoctor(doctor2.address);
            const listDoctor = await patient.connect(user).getDoctor();
            // console.log('listDoctor: ', listDoctor)
            expect(await listDoctor.length).to.equal(2);
        });
    });
    describe("Delete doctor", () => {
        it("remove doctor address from the user", async () => {
            await patient.connect(user).addDoctor(doctor1.address);
            await patient.connect(user).addDoctor(doctor2.address);
            await patient.connect(user).addDoctor(doctor3.address);
            await patient.connect(user).deleteDoctor(doctor2.address);
            const listDoctor = await patient.connect(user).getDoctor();
            expect(await listDoctor.length).to.equal(2);
        });
    });
})