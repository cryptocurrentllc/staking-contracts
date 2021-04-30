pragma solidity ^0.7.3;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SingleStaking is ERC721, Ownable {
  using Counters for Counters.Counter;
  using SafeMath for uint256;

  Counters.Counter private _tokenIds;
  string public tokenURI;

  ERC20 htg;

  address public htgAddress;
  mapping (address => uint256) public htgDeposited;
  mapping (address => uint256) public blocksToRedeem;
  mapping (address => uint256) public lastRedeemed;
  
  constructor (address _htgAddress, string memory _tokenURI) 
    public ERC721("CryptoCurrent NFT", "CRNT") {

    tokenURI = _tokenURI;
    htg = ERC20(_htgAddress);
    htgAddress = _htgAddress;
  }

  function changeTokenURI (string memory _tokenURI) external onlyOwner {
    tokenURI = _tokenURI;
  }

  
  function stake (uint256 _htgAmount) external payable returns (uint256) {
    // add liquidity here
    htg.transferFrom(msg.sender, address(this), _htgAmount);
    htgDeposited[msg.sender] = htgDeposited[msg.sender].add(_htgAmount);

    // Determine blocks to redeem
    blocksToRedeem[msg.sender] = uint256(45000).mul(1 ether).mul(172800)
                                .div(htgDeposited[msg.sender]);
    lastRedeemed[msg.sender] = block.number;
  }

  function unstake () external returns (uint256) {
    require (htgDeposited[msg.sender] > 0, "Some htg tokens must be deposited");
    htg.transfer(msg.sender, htgDeposited[msg.sender]);

    // HTG deposited is now removed
    htgDeposited[msg.sender] = 0;
    // Blocks To Redeem
    blocksToRedeem[msg.sender] = 0;
    // Last Redeemed
    lastRedeemed[msg.sender] = 0;
  }

  function getRedeemBlock (address _staker) external view returns (uint256) {
    return lastRedeemed[_staker].add(blocksToRedeem[_staker]);
  }

  function redeem () external returns (uint256) {
    require (htgDeposited[msg.sender] >= 0, "Redeemer must have deposited HTG");
    require (blocksToRedeem[msg.sender] != 0, "Blocks to Redeem must have some value");
    require (block.number >= lastRedeemed[msg.sender].add(blocksToRedeem[msg.sender]), 
      "Can't Redeem yet");

    lastRedeemed[msg.sender] = block.number;
    return mintNFT(msg.sender);
  }

  function getHTGDeposited (address _staker) external view returns (uint256) {
    return htgDeposited[_staker];
  }

  function mintNFT(address recipient) internal returns (uint256) {
    // Incrementing the token id
    _tokenIds.increment();

    // Retreiving the nftId
    uint256 newItemId = _tokenIds.current();

    // Changed this to be safeMint from Mint
    _safeMint(recipient, newItemId);
    _setTokenURI(newItemId, tokenURI);

    // Returning the token id of the NFT
    return newItemId;
  }

}