// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.24;

contract Patient {
    mapping(address => address[]) doctors;

    // Reload latest patient data when redeploy contract.

    // Records doctor list into blockchain.
    event UpdateDoctor(address indexed patient, address[] doctors);

    function addDoctor(address _doctor) external {
        // add doctor to the patient
        doctors[msg.sender].push(_doctor);
        emit UpdateDoctor(msg.sender, doctors[msg.sender]);
    }

    function deleteDoctor(address _doctor) external {
        // delete doctor from patient
        for (uint i = 0; i < doctors[msg.sender].length; i++) {
            if (doctors[msg.sender][i] == _doctor) {
                delete doctors[msg.sender][i];
                removeElement(i, msg.sender);
                emit UpdateDoctor(msg.sender, doctors[msg.sender]);
                break;
            }
        }
    }
    // fetch list of doctors of the patient
    function getDoctor() external view returns (address[] memory) {
        return doctors[msg.sender];
    }
    
    function getOneDoctor(uint index) external view returns (address) {
        return doctors[msg.sender][index];
    }
    // rearrange elements in the array and delete the last element.
    function removeElement(uint _index, address _patient) private {
        require(_index < doctors[_patient].length, "index out of bound");

        for (uint i = _index; i < doctors[_patient].length - 1; i++) {
            doctors[_patient][i] = doctors[_patient][i + 1];
        }
        doctors[_patient].pop();
    }
}
