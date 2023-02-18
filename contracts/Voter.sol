// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.16;

import './Candidate.sol';

contract VoterContract{
    
    struct VoterData{
        string nicop;
        address ethereumAddress;
    }

    mapping (address => VoterData[]) public voters;

    CandidateContract candidateContract;

    constructor(address _candidateAddress){
        candidateContract = CandidateContract(_candidateAddress);
    }

    function insertVoteByParty(string memory _nicop, string memory _partyName) public{
        address ethereum_candidate_address = candidateContract.getCandidateAddressByPartyName(_partyName);    
        require (ethereum_candidate_address!=address(0), "there is no candidate for this party in contracts");

        VoterData memory vData;
        vData.nicop = _nicop;
        vData.ethereumAddress = msg.sender;
        voters[ethereum_candidate_address].push(vData);
    }

    function getVotesByParty(string calldata _partyName) public view returns (uint totatVotes)
    {
        address ethereum_candidate_address = candidateContract.getCandidateAddressByPartyName(_partyName);    
        require (ethereum_candidate_address!=address(0), "candidate not found!");
        return voters[ethereum_candidate_address].length;
    }

    function verifyMyVote(string calldata _partyName) public view returns(string memory nicop, uint voterIndex){
         address ethereum_candidate_address = candidateContract.getCandidateAddressByPartyName(_partyName);    
        require (ethereum_candidate_address!=address(0), "no such party exists");
        for(uint i = 0; i < voters[ethereum_candidate_address].length; i++)
        {
            if(voters[ethereum_candidate_address][i].ethereumAddress == msg.sender){
                return (voters[ethereum_candidate_address][i].nicop, i);
            }
        }
    }
}