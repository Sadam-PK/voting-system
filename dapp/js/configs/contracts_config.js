let electionCommissionContractAddress = "0xb5eE36AFe5A22bBB32b47BBC5107582ce6dB29A4";
let candidateContractAddress = "";
let voterContractAddress = "";

let ecContract = null;
let candidateContract;
let voterContract;

const getElectionCommissionContract = async (web3) => {
    const ecData = await $.getJSON("./js/contracts/ElectionCommissionContract.json");
    ecContract = await new web3.eth.Contract(ecData.abi, electionCommissionContractAddress);
    console.log("election commission contract object loaded" + ecContract);
    return ecContract;
}


const getVoterContract = async (web3) => {
    const ecData = await $.getJSON("./js/contracts/VoterContract.json");
    await ecContract.methods.getVoterContractAddress().call( (error, result) => {
        // console.log(result);
        if (result) {
            voterContractAddress = result;
            console.log("Loaded voter contract " + result);
            voterContract = new web3.eth.Contract(ecData.abi, voterContractAddress);
            return voterContract;
        }
    });
}


const getCandidateContract = async (web3) => {
    const ecData = await $.getJSON("./js/contracts/CandidateContract.json");
    await ecContract.methods.getCandidateContractAddress().call((error, result) => {
        // console.log(result);
        if (result) {
            candidateContractAddress = result;
            console.log("loaded candidate contract " + result);
            candidateContract = new web3.eth.Contract(ecData.abi, candidateContractAddress);
            return candidateContract;
        }
    });
}


async function initSetup() {
    web3 = await getWeb3();
    await getElectionCommissionContract(web3);
    await getCandidateContract(web3);
    await getVoterContract(web3);

}

initSetup();

