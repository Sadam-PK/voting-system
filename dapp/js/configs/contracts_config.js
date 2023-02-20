let electionCommissionContractAddress = "0xd61b935a90bec400207b5a38beF9760f390421B7";
let candidateContractAddress = "";
let voterContractAddress = "";

let ecContract = null;
let candidateContract;
let voterContract;

const initializeMainContract = async (web3) => {
    const ecData = await $.getJSON("./js/contracts/ElectionCommissionContract.json");
    ecContract = await new web3.eth.Contract(ecData.abi, electionCommissionContractAddress);
    console.log("Election Commission Contract is loaded" + electionCommissionContractAddress);
    return ecContract;
}

const getVoterContract = async(web3)=>{
    const ecData = await $.getJSON("./js/contracts/VoterContract.json");
}


const getCandidateContract = async(web3)=>{
    const ecData = await $.getJSON("./js/contracts/CandidateContract.json");
    await ecContract.methods.getCandidateContractAddress().call((error, result)=>{
        console.log(result);
    });
}

async function initSetup(){
    web3 = await getWeb3();
    initializeMainContract(web3);
    getCandidateContract(web3);
}

initSetup();