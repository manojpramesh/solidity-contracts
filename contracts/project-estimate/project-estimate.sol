contract ProjectEstimate {
    
    address owner;
    function ProjectEstimate() {
        owner = msg.sender;
    }
    
    struct project {
        uint id;
        string name;
        uint totalHours;
    }
    
    struct resource {
        string name;
        uint roleId;
        uint[] projectId;
    }
    
    mapping(address => resource) public ResourceList;
    mapping(uint => project) public ProjectList;
    
    function addResource(address _address, string _name, uint _role ) {
        if(msg.sender != owner || ResourceList[msg.sender].roleId != 1) return;
        ResourceList[_address].name = _name;
        ResourceList[_address].roleId= _role;
    }
    
    function addProject(uint _id, string _name, uint _hour) {
        if(msg.sender != owner || ResourceList[msg.sender].roleId != 1) return;
        ProjectList[_id].id = _id;
        ProjectList[_id].name = _name;
        ProjectList[_id].totalHours = _hour;
    }
    
    function assignProject(address _userAddress, uint _ProjectId) {
        if(msg.sender != owner || ResourceList[msg.sender].roleId != 1) return;
        ResourceList[_userAddress].projectId.push(_ProjectId);
    }
    
    function kill() {
        
    }
}