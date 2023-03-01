function onSubmitForm() {
    var fname = $("#fname").val();
    var lname = $("#lname").val();
    var party = $("#party").val();
    var symbol = $("#symbol").val();
    var ec_address = $("#ec_address").val();

    console.log("fname = " + fname + " " + "lname = " + lname + " "
        + "party = " + party + " " + "symbol = " + symbol + " " + "address = " + ec_address);

    // ecContract is the object of contract called from contracts_config file
    // this object helps front and back end interaction

    // the parameters should be above, but their sequence should match the Candidate.sol file
    // corrosponding function parameters becaue we are using that method
    // the (send) function means it is sending data on blockchain 
    // the (send) function has myaccount[0], means it is an admin, since admin is in control of
    // deployment -  it also have gasPrice and callback functions
    // (myaccount) object comes from web3_config.js file for metamask communication
    // web3.utils.toWei() is a function for adding gas price and coin unit

    ecContract.methods.insertNewCandidate(fname, lname, party, symbol, ec_address)
        .send({ from: myaccount[0], gasPrice: web3.utils.toWei("4.1", "Gwei") },
            (error, result) => {
                if (result) {
                    console.log(result); //result will have transaction hash
                    $("#resultdiv").text(result);
                }
                else {
                    console.log(error); // it will have error message in case of some error
                    $("#resultdiv").text(error);
                }

            });

}