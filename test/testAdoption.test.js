const Adoption  = artifacts.require("Adoption");

//we using Mocha testing framework for the "Adoption" smart contract.
contract("Adoption",(accounts) =>{     
    let adoption;                       
    let expectedAdopter;

    before(async () =>{                .
        adoption = await Adoption.deployed();   
    });

    //here adopt a item/pet with id 8 & assign it to the first account within the test account on the network
   
    describe("adoption a pet and retrieving account addresses", async() =>{    //async allow the fucntion to return a promise 
        before("adopt a pet using account[0]", async () =>{
            await adoption.adopt(8,{from:accounts[0]});
            expectedAdopter = accounts[0];

        });

        // We call smart contract method adopters to see what address adopted with pet id 8.
        it ("can fetch the address of an owner by pet id", async () =>{   //
            const adopter = await adoption.adopters(8);
          
            assert.equal(adopter,expertedAdopter,"this owner of the adopter pet should be the first account.");

        });

        //comparing contract address to the expected address we expect to find 
        it("can fetch the collection of all pet owners addresses", async()=>{
            const adopters= await adoption.getAdopters();
            assert.equal(adopters[8],expectedAdopter,"The owner of the adopted petshould be in the collection.")

        });
    });
});





                        /// other Testcases.//// 


           /// Not implemented Till now , only for cheking till date.///
/*
This test suite includes two test cases for the buyToken function:
should increase total supply by 1: 

*/

/*
// Smart contract
pragma solidity ^0.8.0;

contract Token {
    uint public totalSupply;

    constructor(uint _initialSupply) {
        totalSupply = _initialSupply;
    }

    function buyToken() public {
        totalSupply++;
    }
}

// Test suite
const Token = artifacts.require("Token");

contract("Token", (accounts) => {
    let token;

    beforeEach(async () => {
        token = await Token.new(100);
    });

    describe("buyToken", () => {
        it("should increase total supply by 1", async () => {
            const initialSupply = await token.totalSupply();
            await token.buyToken({ from: accounts[0] });
            const newSupply = await token.totalSupply();
            assert.equal(newSupply, initialSupply + 1, "Total supply did not increase by 1");
        });

        it("should not allow non-owners to buy tokens", async () => {
            try {
                await token.buyToken({ from: accounts[1] });
                assert.fail("Transaction did not throw");
            } catch (error) {
                assert.include(error.message, "revert", "Transaction did not revert");
            }
        });
    });
});

*/
