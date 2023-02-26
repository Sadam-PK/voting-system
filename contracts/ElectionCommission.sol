// SPDX-License-Identifier:MIT
pragma solidity >= 0.8.16;
import "./Candidate.sol";
import "./Voter.sol";

contract ElectionCommissionContract{

    address ecAdmin;
    CandidateContract candidateContract;
    VoterContract voterContract;

    constructor() {
        ecAdmin = msg.sender;
        candidateContract = new CandidateContract(address (this));
        voterContract = new VoterContract(address(candidateContract));
    }

    modifier is_ecAdmin(){
        require(msg.sender == ecAdmin, "You are not admin of the Election Commission contract");
        _;
    }

    function getCandidateContractAddress() public view returns (address candidateContractAddress){
        return address(candidateContract);
    }


    // function getCandidateContractAddress() public view returns (address){
    //     return (candidateContract);
    // }

    function getVoterContractAddress() public view returns (address voterContractAddress){
        return address(voterContract);
    }


    // function getVoterContractAddress() public view returns (address){
    //     return (voterContract);
    // }

    function insertNewCandidate(string calldata _fname, string calldata _lname,
    string calldata _partyName, string calldata _partySymbol, address _candidateAddress )
    external is_ecAdmin
    {
        candidateContract.setCandidateData(_fname,_lname,_partyName,_partySymbol,_candidateAddress);
    }

}