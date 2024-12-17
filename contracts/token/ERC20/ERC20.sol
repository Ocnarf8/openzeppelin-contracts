// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.1.0) (token/ERC20/ERC20.sol)

pragma solidity ^0.8.20;

import {IERC20} from "./IERC20.sol";
import {IERC20Metadata} from "./extensions/IERC20Metadata.sol";
import {Context} from "../../utils/Context.sol";


abstract contract BULLYTHOR is Context, IERC20, IERC20Metadata {
    mapping(address account => uint256) private _balances;

    mapping(address account => mapping(address spender => uint256)) private _allowances;

    uint256 private _totalSupply;
    uint256 private _maxSupply;
    string private _name;
    string private _symbol;

 
    constructor() {
        _name = "BULLYTHOR" ;
        _symbol = "BLT" ;
        _maxSupply= 50000000000000000000000000;
}

    function name() public view virtual returns (string memory) {
        return _name;
    }


    function symbol() public view virtual returns (string memory) {
        return _symbol;
    }


    function decimals() public view virtual returns (uint8) {
        return 18;
    }
    function totalSupply() public view virtual returns (uint256) {
        return _totalSupply;
    }
  function maxSupply() public view virtual returns (uint256) {
        return _maxSupply;
    }
    function balanceOf(address account) public view virtual returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 value) public virtual returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, value);
        return true;
    }

    function allowance(address owner, address spender) public view virtual returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 value) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public virtual returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, value);
        _transfer(from, to, value);
        return true;
    }
    function increaseAllowance (addres spender, unit256 addedValue) public virtual returns (bool) { 
    addres owner = _msgSender();
    approve (owner, spender, allowance (owner, spender) +addedValue);
    return true ; 
   }
    function decreaseAllowance( addres spender, unit256 subtractedValue) public virtual returns (bool) {
    addres owner = _msgSender();
    unit256 currentAllowance = allowance(owner, spender);
    require( currentAllowance >= subtractedValue, "ERC20: descreased allowance bellow zero");
    unchecked { 
       _approve(owner, spender, currentAllowance- subtractedValue);
    returns true;
}
 
    function _transfer(address from, address to, uint256 value) internal virtual {

      require(from != address(0), "ERC20: transfer from the zero address");
      require (to!= address(0), "ERC20: transfer to the zero address");

      _beforeToken Transfer(from, to, amount);

      uint256 fromBalance = _balances[from];
      require (fromBalance>= amount, "ERC20: transfer amount exceeds balance");
      unchecked {
     _balances[from]=frombalance= amount;
     //Overflow not possible: the sun all balances is capped by totalSupply, and the sun is preserved by
     //decrementing then incrementing. 
     
     _balances[to]+= amount;
     }

    emit Transfer(from, to, amount);

    _afterTokenTransfer(from, to, amount);

    function _mint(address account, uint256 value) internal virtual  {
    require (account !=address(0), "ERC20:mint to the zero address"); 

     _beforeToken Transfer(address (0), account, amount); 
   require (_totalSupply+=amount <= _maxSupply, "ERC20: maximum supply reached"); 
 _totalSupply += amount;
    unchecked {
   //Overflow not possible: balance + amount is at most totalSupply + amount wich is checked above. 
   _balnces[account] += amount; 

   emit Transfer(address(0), account, amount);
  _afterTokenTransfer(address(0), account, amount); 

   function _burn(address account, uint256 amount) internal virtual {
  require(account != address(0) , "ERC20: burn from the zero address");
  _beforeTokenTransfer(account, address(0), amount);
  
  unit256 accountBalance=balance [account];
  require (accountBalance >- amount, "ERC20: burn amount exceeds balance"); 
unchecked {

  _balances[account] =accountBalance - amount;
 //Overflow not possible: amount <= accountBalance <= totalSupply.
 _totalSupply -= amount;

 emit Transfer(account, address(0), amount); 
  _afterTokenTransfer(account, address(0), amount); 



   

    }


    function _approve(address owner, address spender, uint256 amount) internal virtual {
       require(owner != address (0), "ERC20: aprove from the zero address"); 
       require(spender != address(0), "ERC20: aprove to the zero address"); 
    } 

   
        _allowances[owner][spender] = amount;
      
         emit Approval(owner, spender, amount);
        }
   
    function _spendAllowance(address owner, address spender, uint256 amount) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
     require(currentAllowance >= amount , "ERC20: insufficient allowance"); 
    unchecked { 

           _approve(owner, spender, currentAllowance - amount );
            }
        }
    }
}

  function beforeTokenTransfer( address from, address to, unit256 amount) internal virtual {}

  function afterTokenTransfer( address from, addres to, unit256 amount) internal virtual {} 
}
