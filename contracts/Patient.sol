pragma solidity ^0.8.24;

contract Patient {
    mapping(address => address[]) doctors;

    function addDoctor(address _doctor) public {
        // add doctor to the patient
        doctors[msg.sender].push(_doctor);
    }

    function deleteDoctor(address _doctor) public {
        // delete doctor from patient
        for (uint i = 0; i < doctors[msg.sender].length; i++) {
            if (doctors[msg.sender][i] == _doctor) {
                delete doctors[msg.sender][i];
                removeElement(i, msg.sender);
                break;
            }
        }
    }

    function getDoctor() public view returns (address[] memory) {
        return doctors[msg.sender];
    }

    function getOneDoctor(uint index) public view returns (address) {
        return doctors[msg.sender][index];
    }

    function removeElement(uint _index, address _patient) private {
        require(_index < doctors[_patient].length, "index out of bound");

        for (uint i = _index; i < doctors[_patient].length - 1; i++) {
            doctors[_patient][i] = doctors[_patient][i + 1];
        }
        doctors[_patient].pop();
    }
}
