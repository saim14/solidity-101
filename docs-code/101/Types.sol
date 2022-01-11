// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Value type
contract ValueTypes {
    // Boolean types
    bool isOkay;

    // Integers types
    int x = type(int).min;
    uint y = type(uint).max;
    int x1 = type(int).max;
    uint y1 = type(uint).min;
    uint n1=90;
    uint n2=10;

    // Address types
    address sender;
    address payable sender2 = payable(msg.sender);

    // String types
    string str = "No unicode supported";
    string str2 = unicode"Unicode supported 😆";

    // Enums types example start #########################################
    enum ActionChoices { GoLeft, GoRight, GoStraight, SitStill }
    ActionChoices choice;
    ActionChoices constant defaultChoice = ActionChoices.GoStraight;

    function setGoStraight() private{
        choice = defaultChoice;
    }
    function GoRight() private{
        choice = ActionChoices.GoRight;
    }
    function getChoice() view internal returns(ActionChoices){
        return choice;
    }
    function getDefaultChoice() pure internal returns(uint){
        return uint(defaultChoice);
    }
    // Enums types example end #########################################

    // Function Types Function types come in two flavours: 
    // internal and external functions






    // Operations
    uint sum=n1+n2;
    uint sub=n1-n2;
    uint mul=n1*n2;
    uint div=n1/n2;
    uint mod=10%3;
    bool boolResult = ((n1%n2) == 0);
    int exp2 = 4**2;
    int frac = 0.5 * 8;
    bool compAddr = sender != sender2;

}

// Reference Types [Arrays, Structs]

    // Array type
contract ArrayContract {
    uint[2**20] m_aLotOfIntegers;
    bool[2][] m_pairsOfFlags;

    function setAllFlagPairs(bool[2][] memory newPairs) public {
        m_pairsOfFlags = newPairs;
    }

    struct StructType {
        uint[] contents;
        uint moreInfo; 
    }

    StructType s;

    function f(uint[] memory c) public {
        StructType storage g = s;
        g.moreInfo = 2;
        g.contents = c;
    }

    function setFlagPair(uint index, bool flagA, bool flagB) public {
        m_pairsOfFlags[index][0] = flagA;
        m_pairsOfFlags[index][1] = flagB;
    }

    function changeFlagArraySize(uint newSize) public {
        if (newSize < m_pairsOfFlags.length){
            while (m_pairsOfFlags.length > newSize){
                m_pairsOfFlags.pop();
            }
        } else if (newSize > m_pairsOfFlags.length) {
            while(newSize > m_pairsOfFlags.length){
                m_pairsOfFlags.push();
            }
        }
    }

    function clear() public{
        delete m_pairsOfFlags;
        delete m_aLotOfIntegers;
        m_pairsOfFlags = new bool[2][](0);
    }

    bytes m_byteData; 
    function byteArrays(bytes memory data) public{
        m_byteData = data;
        for (uint i =0; i<7; i++){
            m_byteData.push();
        }
        m_byteData[3] = 0x08;
        delete m_byteData[2];
    }

    function addFlag(bool[2] memory flag) public returns(uint){
        m_pairsOfFlags.push(flag);
        return m_pairsOfFlags.length;
    }

    function createMemoryArray(uint size) public pure returns(bytes memory){
        uint[2][] memory arrayOfPairs = new uint[2][](size);
        arrayOfPairs[0] = [uint(1), 2];

        bytes memory b = new bytes(200);
        for (uint i = 0; i < b.length; i++ ){
            b[i] = bytes1(uint8(i));
        }
        return b;
    }

}

    // Struct type
struct Funder{
    address addr;
    uint amount;
}

contract CrowdFunding {

    struct Campaign {
        address payable beneficiery;
        uint fundingGoal;
        uint numFunders;
        uint amount;
        mapping(uint => Funder) funders;
    }

    uint numCampaigns;
    mapping(uint => Campaign) campaigns;

    function newCampaign(address payable beneficiery, uint goal) public returns(uint campaignId){
        campaignId = numCampaigns++;
        Campaign storage c = campaigns[campaignId];
        c.beneficiery = beneficiery;
        c.fundingGoal = goal; 
    }

    function contribute(uint campaignId) public payable {
        Campaign storage c = campaigns[campaignId];
        c.funders[c.numFunders++] = Funder({
            addr: msg.sender, 
            amount: msg.value
        });
        c.amount += msg.value;
    }

    function checkGoalReached(uint campaignId) public returns(bool reached){
        Campaign storage c = campaigns[campaignId];

        if(c.amount<c.fundingGoal) return false;
        uint amount = c.amount;
        c.amount = 0;
        c.beneficiery.transfer(amount);
        return true;
    }
}

// Mapping type
contract MappingExample {
    mapping(address => uint) private _balances;
    mapping (address => mapping(address => uint)) private _allowances;

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    function allowance(address owner, address spender) public view returns(uint){
        return _allowances[owner][spender];
    }
    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        _transfer(sender, recipient, amount);
        approve(sender, msg.sender, amount);
        return true;
    }
    function approve(address owner, address spender, uint256 amount) public returns (bool) {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
        return true;
    }

    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _balances[sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
    }
}
