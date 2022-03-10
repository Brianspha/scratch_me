import "./Initializable.sol";
import "./ScratchMeTokenContract.sol";

/// @title TokenManager
/// @author brianspha
/// @notice Responsible for distributing tokens to users
/// @dev may contain bugs and unoptimised code
contract TokenManager is Initializable {
    /*============================Structs definition====================================*/
    struct Player {
        address id;
        uint256[] tokenIds;
        bool exists;
    }
    /*============================Events definition====================================*/
        event NewTokenMinted(uint256 indexed tokenId);
    /*============================Modfiers definition====================================*/
    modifier onlyOwner() {
        require(msg.sender == _owner, "Only Owner can make this call");
        _;
    }
    /*============================Variable definition====================================*/
    address _owner;
    ScratchMeTokenContract _token;
    mapping(address => Player) players;
    address[] allPlayers;

    /*============================Function definition====================================*/
    constructor() public {
        require(msg.sender != address(0), "Invalid contract owner address");
        _owner = msg.sender;
    }

    function init(address _tokenAddress)
        public
        initializer
        onlyOwner
    {
        require(_tokenAddress != address(0), "Invalid token address");
        _token = ScratchMeTokenContract(_tokenAddress);
    }

    function mintTokenToPlayer(address _user, string memory metaData)
        public
        onlyOwner
    {
        require(_user != address(0), "Invalid user address"); //@dedv we dont check the msg.sender here because users only need to provider their address and we mint the tokens for them
        uint256 tokenId = _token.mintToken(_user, metaData);
        players[_user].id = _user;
        players[_user].exists = true;
        players[_user].tokenIds.push(tokenId);
        emit NewTokenMinted(tokenId);
    }

    function getPlayerTokensIds(address _user) public view returns (uint256  [] memory) {
        //@dev we dont user msg.sender because we sponsor the costs of calling the function
        return players[_user].tokenIds;
    }

    function getTokenURI(uint256 _tokenId) public view returns (string  memory) {
        //@dev we dont user msg.sender because we sponsor the costs of calling the function
        return  _token.tokenURI(_tokenId);
    }
}
 