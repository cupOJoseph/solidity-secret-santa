pragma solidity ^0.4.20;

contract Secretsanta{
    
    address public owner;
    string[] private participants_data;
    address[] public participants_address; //kept seperate to make it slightly more secret
    bool public signups_open = true;
    
    event Joined(address participant, string data);
    event Assigned(address santa, address to, string data);
    
    constructor() public{
        owner = msg.sender;
    }
    
    /*
    Join the secret santa event.
    We will keep track of your ethereum address of choice, the one you called this function with.
    Please also include:
    - Name
    - Email
    - address
    - anything the person should know about you to get you the best gift ever 
    
    Please keep gifts 
    
    You can call this function multiple times using the same address, to update the info you put in.
    
    MAKE SURE IT HAS AN EMAIL
    */
    
    function join(string _data) public{
        require(signups_open); //make sure signups are open
        
        participants_data.push(_data);
        participants_address.push(msg.sender);
        
        emit Joined(msg.sender, _data);
    }
    
    /*allow owner to close signups 
    * emit events for who has who.
    * we will watch contract for events and parse out your email.
    * then
    */ 
    function announce() public {
        require(msg.sender == owner);
        require(participants_address.length >= 1);
        require(signups_open);
        signups_open = false; // turn it off.
        
        uint size = participants_address.length;
        
        //person who signed up first (0) gets last person to sign up. Kept seperate from loop for edges.
        emit Assigned(participants_address[0], participants_address[size - 1], participants_data[size - 1]);
        
        //annouce who has who.
        //If you search for your own name, you will only find the address of the person sending you things.
        for(uint i = 1; i < size; i++){
            //person at i, gets person before them
            emit Assigned(participants_address[i], participants_address[i - 1], participants_data[i - 1]);
        }
        
        //just incase any eth is sent here by accident, send it to me.
        owner.transfer(address(this).balance);
    }
    
    
    //allow owner to reopen for any reason
    function reopen() public{
        require(msg.sender == owner);
        signups_open = true;
    }
}
