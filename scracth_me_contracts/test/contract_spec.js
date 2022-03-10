/*global artifacts, contract, it*/
/**/
const ScratchMeTokenContract = artifacts.require("ScratchMeTokenContract");
const TokenManager = artifacts.require("TokenManager");
const utils = require("web3-utils");
var etherConverter = require("ether-converter");
const bigNumber = require("bignumber.js");
let accounts, toCollect, adminBalance, adminBalanceAfter;

var tokenId;

//@notice  we only testing for positive test cases
// For documentation please see https://framework.embarklabs.io/docs/contracts_testing.html
config(
  {
    //deployment: {
    //  accounts: [
    //    // you can configure custom accounts with a custom balance
    //    // see https://framework.embarklabs.io/docs/contracts_testing.html#Configuring-accounts
    //  ]
    //},
    contracts: {
      deploy: {
        ScratchMeTokenContract: {
          args: ["Scratch Me Token", "SMT"],
          gas: "6000000",
          gasPrice: "250",
        },
        TokenManager: {
          args: [],
          gas: "6000000",
          gasPrice: "250",
        },
        ERC721: {
          args: ["ScratchMe", "ScratchMe"],
          gas: "6000000",
          gasPrice: "250",
        },
      },
      afterDeploy: async ({ contracts, web3, logger }) => {
        await contracts.TokenManager.methods
          .init(contracts.ScratchMeTokenContract.options.address)
          .send({ from: web3.eth.defaultAccount });
        await contracts.ScratchMeTokenContract.methods
          .setContractTokenManagerAddress(
            contracts.TokenManager.options.address
          )
          .send({ from: web3.eth.defaultAccount });
      },
    },
  },
  (_err, web3_accounts) => {
    accounts = web3_accounts;
    console.log("accounts: ", accounts);
  }
); /**/
contract("ScratchMeTokenContract", function() {
  it("should set the TokenManager contract address ", async function() {
    let receipt = await ScratchMeTokenContract.methods
      .setContractTokenManagerAddress(TokenManager.options.address)
      .send({
        from: accounts[0],
        gas: 6000000,
      });
    console.log("receipt: ", receipt); //@dev should add some event to check if the address was indeed set
  });
});

contract("TokenManager", function() {
  it("should set the ScratchMeTokenContract token address", async () => {
    var receipt = await TokenManager.methods
      .init(ScratchMeTokenContract.options.address)
      .send({
        from: accounts[0],
        gas: 5000000,
      });
  });
  it("should mint a new token", async () => {
    var receipt = await TokenManager.methods
      .mintTokenToPlayer(
        accounts[1],
        JSON.stringify({
          item: "Hey I am  a very special item",
          value: Math.round(Math.random() * 1000),
        })
      )
      .send({
        from: accounts[0],
        gas: 5000000,
      });
    console.log(
      "newTokenMinted: ",
      receipt.events
    );
    assert.eventEmitted(receipt, "NewTokenMinted");
  });
  it("should check the owner of the token minted ", async () => {
    var owner = await ScratchMeTokenContract.methods
      .ownerOf(1)
      .call({ gas: 6000000 });
    console.log("owner: ", owner, " minter: ", accounts[0]);
    assert.strictEqual(
      accounts[1] == owner,
      true,
      "Token not minted to account[1]"
    );
  });

  it("should get all players token ids ", async () => {
    var tokenIds = await TokenManager.methods
      .getPlayerTokensIds(accounts[1])
      .call({ gas: 6000000 });
    assert.strictEqual(
      tokenIds.length === 1,
      true,
      "Player doesnt own any tokens"
    );
  });
});
