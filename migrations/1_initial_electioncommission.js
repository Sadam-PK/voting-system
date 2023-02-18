const ec = artifacts.require("ElectionCommissionContract");

module.exports = function (deployer) {
    deployer.deploy(ec);
}