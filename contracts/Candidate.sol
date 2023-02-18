// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.16;

contract CandidateContract{

    struct CandidateData{
        string fname;
        string lname;
        string partyName;
        string partySymbol;
        address ethereumAddress;
    }

    CandidateData [] candidatesData;
    address electionCommissionAddress;
    constructor(address _electionCommissionAddress) {
        electionCommissionAddress = _electionCommissionAddress;
    }

    function setCandidateData(string calldata _fname, string calldata _lname, 
    string calldata _partyName, string calldata _partySymbol, 
    address _candidateAddress) external 
    {    
        require(msg.sender == electionCommissionAddress, "Only election-commission can call this contract.");
        CandidateData memory obj;

        obj.fname = _fname;
        obj.lname = _lname;
        obj.partyName = _partyName;
        obj.partySymbol = _partySymbol;
        obj.ethereumAddress = _candidateAddress;   

        candidatesData.push(obj);
    }

    function getCandidateByPartyName(string calldata _partyName) public view returns (CandidateData memory _candidate)
    {
        for (uint i = 0; i < candidatesData.length; i++)
        {
            if(keccak256(bytes(candidatesData[i].partyName))==keccak256(bytes(_partyName)))
            {
                return candidatesData[i];
            }
        }
    } 

    function getCandidateAddressByPartyName(string calldata _partyName) public view returns(address _candidateAddress)
    {
        for(uint i = 0; i < candidatesData.length; i++)
        {
            if(keccak256(bytes(candidatesData[i].partyName))== keccak256(bytes(_partyName)))
            {
                return candidatesData[i].ethereumAddress;
            }
        }
    }

    function getPartiesList() external view returns (string [] memory parties)
    {
        parties = new string [] (candidatesData.length);
        for(uint i = 0; i < candidatesData.length;i++)
        {
            parties[i] = candidatesData[i].partyName;
        }
    }

}