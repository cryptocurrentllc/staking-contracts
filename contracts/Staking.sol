pragma solidity ^0.7.3;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}



interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}



interface IUniswapV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}



// pragma solidity >=0.6.2;

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}


contract Staking is ERC721, Ownable {
  using Counters for Counters.Counter;
  using SafeMath for uint256;

  Counters.Counter private _tokenIds;
  string public tokenURI;


  IUniswapV2Router02 public uniswapV2Router;

  ERC20 htg;
  ERC20 lp;

  address public htgAddress;
  address public lpAddress;
  mapping (address => uint256) public htgDeposited;
  mapping (address => uint256) public lpHeld;
  mapping (address => uint256) public blocksToRedeem;
  mapping (address => uint256) public lastRedeemed;

  event SwapAndLiquify(
    uint256 tokensSwapped,
    uint256 ethReceived,
    uint256 tokensIntoLiqudity
  );

  
  constructor (address _htgAddress, address _lpAddress, 
    address _uniswapV2RouterAddress, string memory _tokenURI) 
    public ERC721("CryptoCurrent NFT", "CRNT") {

    tokenURI = _tokenURI;
    htg = ERC20(_htgAddress);
    htgAddress = _htgAddress;
    lp = ERC20(_lpAddress);
    lpAddress = _lpAddress;
    uniswapV2Router = IUniswapV2Router02(_uniswapV2RouterAddress);

    htg.approve(address(uniswapV2Router), 1000000 ether);
    htg.approve(lpAddress, 1000000 ether);
  }

  function changeTokenURI (string memory _tokenURI) external onlyOwner {
    tokenURI = _tokenURI;
  }

  function swapTokensForEth(uint256 tokenAmount) internal  {
    // generate the uniswap pair path of token -> weth
    address[] memory path = new address[](2);
    path[0] = htgAddress;
    path[1] = uniswapV2Router.WETH();
    
    // htg.approve(address(this), address(uniswapV2Router), tokenAmount);

    // make the swap
    uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(
      tokenAmount,
      0, // accept any amount of ETH
      path,
      address(this),
      block.timestamp
    );
  }

  function addLiquidity(uint256 tokenAmount, uint256 ethAmount, address lpAdder) internal {
    // approve token transfer to cover all possible scenarios
    // _approve(address(this), address(uniswapV2Router), tokenAmount);

    // add the liquidity
    (uint256 tokenA, uint256 tokenB, uint256 liquidity) = uniswapV2Router.addLiquidityETH{value: ethAmount}(
      htgAddress,
      tokenAmount,
      0, // slippage is unavoidable
      0, // slippage is unavoidable
      address(this),
      block.timestamp
    );

    lpHeld[lpAdder] = liquidity;
  }
  
  function swapAndLiquify(uint256 contractTokenBalance, address lpAdder) internal {
    // split the contract balance into halves
    uint256 half = contractTokenBalance.div(2);
    uint256 otherHalf = contractTokenBalance.sub(half);

    // capture the contract's current BNB balance.
    // this is so that we can capture exactly the amount of BNB that the
    // swap creates, and not make the liquidity event include any BNB that
    // has been manually sent to the contract
    uint256 initialBalance = address(this).balance;

    // swap tokens for ETH
    swapTokensForEth(half); // <- this breaks the ETH -> HATE swap when swap+liquify is triggered

    // how much ETH did we just swap into?
    uint256 newBalance = address(this).balance.sub(initialBalance);

    // add liquidity to uniswap
    addLiquidity(otherHalf, newBalance, lpAdder);
    
    emit SwapAndLiquify(half, newBalance, otherHalf);
  }

  function stake (uint256 _htgAmount) external payable returns (uint256) {
    // add liquidity here
    htg.transferFrom(msg.sender, address(this), _htgAmount);
    htgDeposited[msg.sender] = htgDeposited[msg.sender].add(_htgAmount);

    // Determine blocks to redeem
    blocksToRedeem[msg.sender] = htgDeposited[msg.sender].div(45000)
                                  .div(1 ether).mul(864000);
    lastRedeemed[msg.sender] = block.number;

    swapAndLiquify(_htgAmount, msg.sender);
  }

  function unstake () external returns (uint256) {
    require (lpHeld[msg.sender] > 0, "Some lp tokens must be there");
    lp.transfer(msg.sender, lpHeld[msg.sender]);

    // No liquidity is now held
    lpHeld[msg.sender] = 0;
    // HTG deposited is now removed
    htgDeposited[msg.sender] = 0;
    // Blocks To Redeem
    blocksToRedeem[msg.sender] = 0;
    // Last Redeemed
    lastRedeemed[msg.sender] = 0;
  }

  function getBlocksToRedeem () external view returns (uint256) {
    return blocksToRedeem[msg.sender];
  }

  function redeem () external returns (uint256) {
    require (htgDeposited[msg.sender] >= 0, "Redeemer must have deposited HTG");
    require (blocksToRedeem[msg.sender] != 0, "Blocks to Redeem must have some value");
    require (block.number >= lastRedeemed[msg.sender].add(blocksToRedeem[msg.sender]), 
      "Can't Redeem yet");

    lastRedeemed[msg.sender] = block.number;
    return mintNFT(msg.sender);
  }

  function getHTGDeposited () external view returns (uint256) {
    return htgDeposited[msg.sender];
  }
  
  function getLPHeld () external view returns (uint256) {
    return lpHeld[msg.sender];
  }
  
  // important to receive ETH
  receive() payable external {}

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