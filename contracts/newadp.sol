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

function isAdopted(uint petId) public view returns (bool) {
    require(petId >= 0 && petId <= 15, "Invalid pet ID");
    return adopters[petId] != address(0);
}


///////A function to allow the contract owner to add new pets://////
//This function adds a new element to the end of the adopters array, allowing for new pets to be added to the contract. 
//However, it can only be called by the contract owner 

address owner;

constructor() public {
    owner = msg.sender;
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
// This function adds a new Pet struct to the contract, which includes fields for the pet's name, age, and breed. 
// The updatePetName function allows the owner of a pet to update the pet's name (but not its age or breed). 
// The require statement ensures that only the owner of the pet can update its name.
   struct Pet {
    string name;
    uint8 age;
    string breed;
}

Pet[] public pets;

function updatePetName(uint petId, string memory newName) public {
    require(msg.sender == adopters[petId], "Only the pet owner can update the pet's name");
    pets[petId].name = newName;
}


////////A function to allow pet owners to delete their pet from the contract:////////
// the require statement ensures that only the owner of the pet can delete it. 
// The function deletes the pet's address from the adopters array, 
// deletes the Pet struct from the pets array, 
// Note that deleting an element from an array in Solidity does not actually remove the element from the array,
 //but instead sets its value to the default value for its type (e.g., 0 for integers, false for booleans, address(0) for addresses, etc.).
   function deletePet(uint petId) public {
    require(msg.sender == adopters[petId], "Only the pet owner can delete the pet");
    delete adopters[petId];
    delete pets[petId];
    
}
