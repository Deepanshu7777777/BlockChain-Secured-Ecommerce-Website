App = {
  web3Provider: null,   // web3 lib interact with ethereum prog. and process and retive transction info.
  contracts: {},

  init: async function() {
    // Load pets.
    $.getJSON('../pets.json', function(data) {
      var petsRow = $('#petsRow');
      var petTemplate = $('#petTemplate');
      
      
      
      for (i = 0; i < data.length; i ++) {
        petTemplate.find('.panel-title').text(data[i].name);
        petTemplate.find('img').attr('src', data[i].picture);
        petTemplate.find('.pet-breed').text(data[i].breed);
        petTemplate.find('.pet-age').text(data[i].age);
        petTemplate.find('.pet-location').text(data[i].location);
        petTemplate.find('.btn-adopt').attr('data-id', data[i].id);

        petsRow.append(petTemplate.html());
      }
    });

    return await App.initWeb3();
  },

  //code defines an asynchronous function called initWeb3() which initializes the web3 object 
  //that is used to interact with an Ethereum blockchain network. [talking about async function.]
  initWeb3: async function() {
   if(window.etherium){                   
    App.web3Provider = window.ethereum;    
    try{
      await window.ethereum.request({method:"eth_requestAccounts "}); //This code block requests the user to grant permission for the dApp to access the user's Ethereum account. 
    } catch (error ) {                                            
      console.log("user denied account access");

    }
   } 
   else if(window.web3){         
    App.web3Provider = window.web3.currentProvider;  
   else{
    App.web3Provider = new Web3.provider.HttpProvider('http://localhost:7545');  //sets connects to a local Ethereum network running on localhost:7545

   }
   web3 = new Web3(App.web3Provider);   
    return App.initContract();            

  //keep information of the contract and migrations .
  initContract: function() {
    $.getJSON('adoption.json',function(data){
      var AdoptionArtifact = data;            
      App.contracts.Adoption = TruffleContract(AdoptionArtifact); 
      App.Contracts.Adoption.setProvider(App.Web3Provider);
      return App.markAdopted();     //call this markadp function in case any pet mark adobted already.
    });

    return App.bindEvents();
  },

  bindEvents: function() {
    $(document).on('click', '.btn-adopt', App.handleAdopt);
  },

//defines a function called markAdopted() that interacts with a deployed Ethereum smart contract
 
  markAdopted: function() {
   var adoptionInstance;      
   App.contracts.Adoption.deployed().then(function(isntance){   
    adoptionInstance = instance;                           
    return adoptionInstance.getAdopters.call();

   }).then(function(adopters){           
    for(i=0; i<adopters.length ; i++){    
      if(adopters[i] !== '0x0000000000000000000000000000000000000000'){     //checks if the "i"th element of the "adopters" array is not equal to default  address value. If this is true, then the pet has been adopted.
        $('.panel-pet').eq(i).find('button').text('success').attr('disabled',true);  //This finds the i-th element with a class panel-pet and disables the button in it by setting its text to "success" and disabling the button.

      }
    }
   }).catch(function(err){    //This function is executed if the promise chain encounters an error.
    console.log(err.message); //This logs the error message to the console.
   });
  },

  handleAdopt: function(event) {  
    event.preventDefault();       
                                  

    var petId = parseInt($(event.target).data('id')); 
    var adoptionInstance;
    web3.eth.getAccounts(function(error,accounts){  // use web3 to get the user account in callback after error check,
      if(error){                                  
        console.log(error);                   
      }

      // we are going to send a transaction instead of a call , it has an account & assocaited cost.
      var account = account[0];
      App.contracts.Adoption.deployed().then(function(instance){   
        adoptionInstance = instance;                                
        return adoptionInstance.adopt(petId,{from: account});   
        // if no error occurs then we proceed to mark adopted function to sink the ui with newly stored data.
      }).then(function(result){
        return App.markAdopted();    // calls the markAdopted function from the App object to update the UI to reflect the updated adoption status.

      }).catch(function(err){
        console.log(err.message);
      });
    });
  }

};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
