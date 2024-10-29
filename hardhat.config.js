require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
    solidity: "0.8.24",
    networks: {
        cardona: {
            url: "https://rpc.cardona.zkevm-rpc.com",
            accounts: ["2e5676f83ad672518b53d624b372b2a37abb8ad4e16ecea9f46db34997049694"]
        }
    }
};
