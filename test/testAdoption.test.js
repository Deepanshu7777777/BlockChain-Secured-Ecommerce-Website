//we start the test by importing adoption by improting artifacts.require 
const Adoption  = artifacts.require("Adoption");

//callback function takes the argument accounts
contract("Adoption",(accounts) =>{     //This provides us with the account available on the network while using the test.
    let adoption;
    let expectedAdopter;

    before(async () =>{                 //we make use of before to provide the initial setup for the following.
        adoption = await Adoption.deployed();

    });

    //here adopt a pet with id 8 & assign it to the first account within the test account on the network
    // later this function used to check wheather the pet id which is 8 is adopted by account with index 0

//    to test the adopt function we call that upon success it returns 
//    a given adopter. We can ensure that the adopter, based on the
//    given pet I.D. was returned and is compared with the expected adopter within the adopter function.
    describe("adoption a pet and retrieving account addresses", async() =>{
        before("adopt a pet using account[0]", async () =>{
            await adoption.adopt(8,{from:accounts[0]});
            expectedAdopter = accounts[0];

        });

        // We call smart contract method adopters to see what address adopted with pet id 8.
        it ("can fetch the address of an owner by pet id", async () =>{   //
            const adopter = await adoption.adopters(8);
            // truffle import chai for user so we can use assert fun.
            // passing actual and expected value and the failer message which gets printed to console ,if test does'nt pass to assert.equal method
            assert.equal(adopter,expertedAdopter,"this owner of the adopter pet should be the first account.");

        });

        //comparing contract address to the expected address we expect to find 
        it("can fetch the collection of all pet owners addresses", async()=>{
            const adopters= await adoption.getAdopters();
            assert.equal(adopters[8],expectedAdopter,"The owner of the adopted petshould be in the collection.")

        });
    });
});
