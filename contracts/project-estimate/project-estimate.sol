pragma solidity ^0.4.0;
contract ProjectEstimate {
    
    // Summary: Owner variable to store address of contract creator.
    address owner;
    
    // Summary: Constructor function
    function ProjectEstimate() {
        owner = msg.sender; // Assign owner
    }
    
    // Summary: Structure of a project
    struct project {
        uint id; // Project Id
        string name; // Project Name
        uint totalHours; // Total allocated project hours
        uint usedHours; // Used project hours
        mapping(address => bool) AllocationList; // List of resources allocated
    }
    
    // Summary: Structure of a resource
    struct resource {
        string name; // Resource Name
        uint roleId; // Manager - 1, Resource - 2
    }
    
    // Summary: Mapping array that stores list of resources
    mapping(address => resource) public ResourceList;
    
    // Summary: Mapping array that stores list of projects
    mapping(uint => project) public ProjectList;
    
    
    // Summary: Add a resource to the resources list
    function addResource(address _address, string _name, uint _role ) {
        if(msg.sender != owner || ResourceList[msg.sender].roleId != 1) return; // Return if not a owner or manager
        ResourceList[_address].name = _name;
        ResourceList[_address].roleId= _role;
    }
    
    // Summary: Add a project to the projects list
    function addProject(uint _id, string _name, uint _hour) {
        if(msg.sender != owner || ResourceList[msg.sender].roleId != 1) return; // Return if not a owner or manager
        ProjectList[_id].id = _id;
        ProjectList[_id].name = _name;
        ProjectList[_id].totalHours = _hour;
        ProjectList[_id].usedHours = 0;
    }
    
    // Summary: Assign a project to a resource
    function assignProject(address _userAddress, uint _ProjectId) {
        if(msg.sender != owner || ResourceList[msg.sender].roleId != 1) return;
        ProjectList[_ProjectId].AllocationList[_userAddress] = true;
    }
    
    // Summary: To record and update resource hours against the project
    function UpdateHours(uint _ProjectId, uint _usedHours) {
        if(msg.sender != owner || ResourceList[msg.sender].roleId != 1 || ProjectList[_ProjectId].AllocationList[msg.sender] == false) return;
        if(_usedHours + ProjectList[_ProjectId].usedHours > ProjectList[_ProjectId].totalHours) return;
        ProjectList[_ProjectId].usedHours += _usedHours;
    }
    
    // Summary: Kill function to destroy the contract
    function kill()
    { 
        if (msg.sender == owner)
            suicide(owner);
    }
}