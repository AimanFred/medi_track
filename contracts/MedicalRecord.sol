// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract MedicalRecord {
    uint public recordId;
    mapping(uint => Record) records;
    struct Record {
        uint recordId;
        uint timestamp;
        string name;
        uint age;
        string gender;
        string diagnosis;
        string treatment;
        string medication;
    }
    // event to write the value in blockchain
    event MedicalRecord__AddRecord(
        uint recordId,
        uint256 timestamp,
        string name,
        uint age,
        string gender,
        string diagnosis,
        string treatment,
        string medication
    );

    // function to add new record
    function addRecord(
        string memory _name,
        uint _age,
        string memory _gender,
        string memory _diagnosis,
        string memory _treatment,
        string memory _medication
    ) public {
        // increase record id by 1 everytime new record is created
        recordId++;
        // add record into records mapping/object
        records[recordId] = Record(
            recordId,
            block.timestamp,
            _name,
            _age,
            _gender,
            _diagnosis,
            _treatment,
            _medication
        );
        // write the record into blockchain
        emit MedicalRecord__AddRecord(
            recordId,
            block.timestamp,
            _name,
            _age,
            _gender,
            _diagnosis,
            _treatment,
            _medication
        );
    }

    // getter functions

    function getRecord(uint _recordId) public view returns (uint, string memory, uint, string memory, string memory,string memory,string memory) {
        Record storage record = records[_recordId];
        return (
            record.timestamp,
            record.name,
            record.age,
            record.gender,
            record.diagnosis,
            record.treatment,
            record.medication
        );
    }
    function getRecordId() public view returns (uint) {
        return recordId;
    }

    function getTimestamp(uint _recordId) public view returns (uint) {
        return records[_recordId].timestamp;
    }

    function getName(uint _recordId) public view returns (string memory) {
        return records[_recordId].name;
    }

    function getAge(uint _recordId) public view returns (uint) {
        return records[_recordId].age;
    }

    function getGender(uint _recordId) public view returns (string memory) {
        return records[_recordId].gender;
    }

    function getDiagnosis(uint _recordId) public view returns (string memory) {
        return records[_recordId].diagnosis;
    }

    function getTreatment(uint _recordId) public view returns (string memory) {
        return records[_recordId].treatment;
    }

    function getMedication(uint _recordId) public view returns (string memory) {
        return records[_recordId].medication;
    }
}