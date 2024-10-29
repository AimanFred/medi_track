// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.24;

contract MedicalRecord {
    uint public recordId;
    mapping(uint => Record) records;
    struct Record {
        uint recordId;
        uint timestamp;
        address patient;
        string recordHash;
    }
    // event to write the value in blockchain
    event MedicalRecord__AddRecord(
        uint recordId,
        uint256 timestamp,
        address patient,
        string recordHash
    );

    // function to add new record
    function addRecord(
        address _patient,
        string memory _recordHash
    ) public {
        // increase record id by 1 everytime new record is created
        recordId++;
        // add record into records mapping/object
        records[recordId] = Record(
            recordId,
            block.timestamp,
            _patient,
            _recordHash
        );
        // write the record into blockchain
        emit MedicalRecord__AddRecord(
            recordId,
            block.timestamp,
            _patient,
            _recordHash
        );
    }

    // getter functions

    function getRecord(
        uint _recordId
    )
        public
        view
        returns (
            uint,
            address,
            string memory
        )
    {
        Record storage record = records[_recordId];
        return (
            record.timestamp,
            record.patient,
            record.recordHash
        );
    }

    function getRecordId() public view returns (uint) {
        return recordId;
    }

    function getTimestamp(uint _recordId) public view returns (uint) {
        return records[_recordId].timestamp;
    }

    function getPatient(uint _recordId) public view returns (address) {
        return records[_recordId].patient;
    }

    function getRecordHash(uint _recordId) public view returns (string memory) {
        return records[_recordId].recordHash;
    }
}
