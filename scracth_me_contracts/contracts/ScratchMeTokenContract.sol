pragma solidity >=0.6.2;
//"SPDX-License-Identifier: UNLICENSED"

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Initializable.sol";



//@dev contract definition
contract ScratchMeTokenContract is ERC721, Ownable, Initializable {
using Counters for Counters.Counter;
  Counters.Counter private tokenIds;

//@dev modifier
modifier onlyTokenManager (){
  require(msg.sender ==_tokenManagerAddress, "Only TokenManager contract can make this call");
  _;
}
//@dev contract variables

address public _tokenManagerAddress;
//@dev function definitions
 constructor(string memory name, string memory symbol)
    public
     initializer
    ERC721(name, symbol)
  {

  }

  /**
    *@dev init contract variables
   
     */

  function setContractTokenManagerAddress(address tokenManagerAddress) onlyOwner  public{
    require(tokenManagerAddress != address(0), "invalid tokenManagerAddress address");
    _tokenManagerAddress=tokenManagerAddress;
  }
  function mintToken(address tokenOwner, string memory tokenURI)
    public onlyTokenManager
    returns (uint256)
  {
    tokenIds.increment();
    _mint(tokenOwner, tokenIds.current());
    _setTokenURI(tokenIds.current(), tokenURI);
    return tokenIds.current();
  }


  function tokenExists (uint256 tokenId) public view returns(bool){
    return _exists(tokenId);
  }

   function totalSupply() public view override returns (uint256) {
        // _tokenOwners are indexed by tokenIds, so .length() returns the number of tokenIds
        return tokenIds.current();
    }
    function burnToken(uint256 tokenId)  public onlyTokenManager returns (bool) {
      _burn(tokenId);
      return tokenExists(tokenId);
    }
}