//pragma solidity ^0.8.19;
pragma solidity ^0.5.0;  //  minimum version of solidity required at the top of contract
//pragma means the additional info. the  compiler only  care about .

// creating 1st contract 
contract Adoption{                  //That's stactical type language, meaning data types like string integers and added must be defined to
    address[16] public adopters;   // addres unique value ,stored as 20 byte value  ,used for sending and receiving ethers     
                                    // adopter is an array contain ETH ADDRESS 

//Creating function to fill the address in adopters array 
    function adopt(uint petId) public returns(uint){ // taking pet id and return it also 
        require(petId >= 0 && petId <=15);           // checking if pet id is in range    of our adopters array // require is condion 

        adopters[petId]= msg.sender; // call address of the person or smart contract who call this fucntion 
        return petId;                // return pedid as a confirmation
    }

    //writing 2nd function 
    // function to retrive the adopters ,,  array getters only a single valye from the given key so,
    // we write this fucntion to return the entire array  

    function getadopters() public view returns (address[16] memory){   // here view keyword declare ,that the fucntion will not modify the state of the contract 
        return adopters;                                              // memory give data location for array 
    }
}

// smart contract over 
