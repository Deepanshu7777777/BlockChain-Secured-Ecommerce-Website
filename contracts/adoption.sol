//pragma solidity ^0.8.19;
pragma solidity ^0.5.0;  //  minimum version of solidity required at the top of contract
//pragma means the additional info. the  compiler only  care about .

// creating 1st contract 
contract Adoption{                  //That's stactical type language, meaning data types like string integers and added must be defined to
    address[16] public adopters;   // address unique value ,stored as 20 byte value  ,used for sending and receiving ethers     
                                    // adopter is an array contain ETH ADDRESS 

//Creating function to fill the address in adopters array 
    function adopt(uint petId) public returns(uint){ // taking pet id and return it also 
        require(petId >= 0 && petId <=15);           // checking if pet id is in range    of our adopters array // require is condion 

        adopters[petId]= msg.sender; // call address of the person or smart contract who call this fucntion 
        return petId;                // return petid as a confirmation
    }

    //writing 2nd function 
    // function to retrive the adopters ,,  array getters only a single valye from the given key so,
    // we write this fucntion to return the entire array  

    function getadopters() public view returns (address[16] memory){   // here view keyword declare ,that the fucntion will not modify the state of the contract 
        return adopters;                                              // memory give data location for array 
    }
}

// smart contract over 



///////////////new own code.

             //A function to return the number of pets that have been adopted:///  
             //This function iterates over the adopters array and counts the number of non-zero addresses (i.e., the number of pets that have been adopted).
function getAdoptionCount() public view returns (uint) {
    uint count = 0;
    for (uint i = 0; i < adopters.length; i++) {
        if (adopters[i] != address(0)) {
            count++;
        }
    }
    return count;
}


////////// A function to check if a pet has already been adopted:////////

// This function takes a petId as input and returns a boolean indicating whether that pet has already been adopted.
//The function is marked as public, which means it can be called from outside the contract, and it is marked as view, which means it does not modify the state of the contract.

function isAdopted(uint petId) public view returns (bool) {
    require(petId >= 0 && petId <= 15, "Invalid pet ID");      //If the petId is not within this range, the function will revert with an error message "Invalid pet ID"
    return adopters[petId] != address(0);                       // require means function execute if certain condition met.
}


///////A function to allow the contract owner to add new pets://////
//This function adds a new element to the end of the adopters array, allowing for new pets to be added to the contract. 
//However, it can only be called by the contract owner 

address owner;   //declares a state variable called owner of type address

constructor() public {
    owner = msg.sender;    //the constructor sets the value of owner to the address of the account that deploys the contract, which is obtained using msg.sender.
}

modifier onlyOwner() {
    require(msg.sender == owner, "Only the contract owner can call this function");
    _;
}

function addPet() public onlyOwner {
    require(adopters.length < 20, "Maximum number of pets reached");
    adopters.push(address(0));
}


////////////A function to allow pet owners to update their pet's name:///////
// This function adds a new Pet struct to the contract, which includes fields for the pet's Type,Stock , and location. 
// The updatePetName function allows the owner of a pet to update the pet's Type (but not its Stock or Location). 
//The require statement ensures that only the owner of the pet can update its name.
   struct Pet {             //This defines a Pet struct with three properties: Type, Stock, and Location. 
                            //A struct is a composite data type that allows you to group together variables of different types.
    string Type;
    uint8 Stock;
    string Location;
}

Pet[] public pets;      //This declares a dynamic array called pets that stores instances of the Pet struct, accessable form outside the contract.

function updatePetName(uint petId, string memory newType) public {          //two arguments: petId and newType. The function updates the Type property of the Pet struct at the specified petId index in the pets array with the new value of newType.   //The memory keyword is used to specify that newType should be stored in memory rather than storage. This is because newType is a function argument and is only needed for the duration of the function call, whereas storage variables persist beyond the lifetime of the function.
    require(msg.sender == adopters[petId], "Only the pet owner can update the pet's name");
    pets[petId].Type = newType;
}


////////A function to allow pet owners to delete their pet from the contract:////////
// the require statement ensures that only the owner of the pet can delete it. 
// The function deletes the pet's address from the adopters array, 
// deletes the Pet struct from the pets array, 
// Note that deleting an element from an array in Solidity does not actually remove the element from the array,
 //but instead sets its value to the default value for its type(e.g.,, 0 for integers, false for booleans, address(0) for addresses, etc.).
   function deletePet(uint petId) public {
    require(msg.sender == adopters[petId], "Only the pet owner can delete the pet");
    delete adopters[petId];
    delete pets[petId];
    
}
