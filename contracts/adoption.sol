//pragma solidity ^0.8.19;
pragma solidity ^0.5.0;  //  minimum version of solidity required at the top of contract
//pragma means the additional info. the  compiler only  care about .

// creating 1st contract 
contract Adoption{                  //it is a stactical type language, meaning data types like string integers are added must be defined to address unique value ,stored as 20 byte value  ,used for sending and receiving ethers
    address[16] public adopters;    // adopter is an array contain ETH ADDRESS.    
                                     

//Creating function to fill the address in adopters array 
    function adopt(uint itemId) public returns(uint){ // taking item id and return it also 
        require(itemId >= 0 && itemId <=15);           // checking if item id is in range    of our adopters array // require is condion 

        adopters[itemId]= msg.sender; 
        return itemId;               
    }

    //writing 2nd function 
    // function to retrive the adopters ,,  array getters only a single valye from the given key so,
    // we write this fucntion to return the entire array  

    function getadopters() public view returns (address[16] memory){  
        return adopters;                                             
    }
}

// smart contract part 1 over.



///////////////new own code.///

             //A function to return the number of item that have been adopted:///  
        
function getAdoptionCount() public view returns (uint) {
    uint count = 0;
    for (uint i = 0; i < adopters.length; i++) {
        if (adopters[i] != address(0)) {
            count++;
        }
    }
    return count;
}


////////// A function to check if a item has already been adopted:////////


function isAdopted(uint itemId) public view returns (bool) {
    require(itemId >= 0 && itemId <= 15, "Invalid itemId");      
    return adopters[itemId] != address(0);                      
}


///////   A function to allow the contract owner to add new : items //////


address owner;   //declares a state variable called owner of type address

constructor() public {
    owner = msg.sender;    //the constructor sets the value of owner to the address of the account that deploys the contract, which is obtained using msg.sender.
}

modifier onlyOwner() {
    require(msg.sender == owner, "Only the contract owner can call this function");
    _;
}

function additem() public onlyOwner {
    require(adopters.length < 20, "Maximum number of  items reached");
    adopters.push(address(0));
}


////////////A function to allow item owners to update their products name:///////

// This function adds a new products/item items struct to the contract, which includes fields for the items  Type,Stock , and location. 
// The updateitemName function allows the owner of a item to update the items Type (but not its Stock or Location). 
//The require statement ensures that only the owner of the item can update its name.
   struct item {            
    string Type;
    uint8 Stock;
    string Location;
}

item[] public items;      //This declares a dynamic array called items that stores instances of the item struct, accessable form outside the contract.

function updateitemName(uint itemId, string memory newType) public {          //two arguments: itemId and newType. The function updates the Type property of the item struct at the specified itemId index in the items array with the new value of newType.   //The memory keyword is used to specify that newType should be stored in memory rather than storage. This is because newType is a function argument and is only needed for the duration of the function call, whereas storage variables persist beyond the lifetime of the function.
    require(msg.sender == adopters[itemId], "Only the item owner can update the items name");
    items[itemId].Type = newType;
}


////////A function to allow item owners to delete their item from the contract:////////

/
   function deleteItem(uint itemId) public {
    require(msg.sender == adopters[itemId], "Only the item owner can delete the item");
    delete adopters[itemId];
    delete items[itemId];
    
}
