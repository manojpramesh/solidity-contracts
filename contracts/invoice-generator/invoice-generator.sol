pragma solidity ^0.4.0;
contract InvoicePayment {
    
    // Summary: Global varibales 
    address owner; // Contract creator 
    string tokenName; // Name of the token used to pay the bill
    uint256 totalSupply; // Total supply of tokens
    uint256 unitCharge; // Charge per unit hour in tokens

    mapping(address => uint256) public balance;
    
    // Summary: Constructor function
    function InvoicePayment(uint256 _initialSupply, string _tokenName, uint256 _unitHourCharge) {
        owner = msg.sender; // Assigns owner
        tokenName = _tokenName; // Assigns token name
        totalSupply = _initialSupply; // Assigns initial supply
        balance[msg.sender] = _initialSupply; // Assigns initial supply to the contract creator
        unitCharge = _unitHourCharge; // Defines token price per unit
    }
    
    // Summary: Structure of project item
    struct project {
        string name;
        uint billedHours;
        uint amount;
        uint amountPaid;
    }
    
    mapping (uint256 => project) public InvoiceList;
    
    // Summary: To create an invoice
    function createInvoice(uint256 _id, string _name, uint _billedHours) {
        InvoiceList[_id].name = _name;
        InvoiceList[_id].billedHours = _billedHours;
        InvoiceList[_id].amount = _billedHours * unitCharge;
    }
    
    // Summary: Settle an invoice
    function PayInvoice(uint256 _amount, uint256 _id) {
        if(_amount > InvoiceList[_id].amount) return;
        InvoiceList[_id].amountPaid += _amount;
    }
}