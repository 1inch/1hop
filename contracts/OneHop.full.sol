
// File: @openzeppelin/contracts/token/ERC20/IERC20.sol

pragma solidity ^0.5.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP. Does not include
 * the optional functions; to access them see {ERC20Detailed}.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// File: @openzeppelin/contracts/math/SafeMath.sol

pragma solidity ^0.5.0;

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     *
     * _Available since v2.4.0._
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

// File: @openzeppelin/contracts/utils/Address.sol

pragma solidity ^0.5.5;

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * This test is non-exhaustive, and there may be false-negatives: during the
     * execution of a contract's constructor, its address will be reported as
     * not containing a contract.
     *
     * IMPORTANT: It is unsafe to assume that an address for which this
     * function returns false is an externally-owned account (EOA) and not a
     * contract.
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies in extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly { codehash := extcodehash(account) }
        return (codehash != 0x0 && codehash != accountHash);
    }

    /**
     * @dev Converts an `address` into `address payable`. Note that this is
     * simply a type cast: the actual underlying value is not changed.
     *
     * _Available since v2.4.0._
     */
    function toPayable(address account) internal pure returns (address payable) {
        return address(uint160(account));
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     *
     * _Available since v2.4.0._
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-call-value
        (bool success, ) = recipient.call.value(amount)("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }
}

// File: @openzeppelin/contracts/token/ERC20/SafeERC20.sol

pragma solidity ^0.5.0;




/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for ERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using SafeMath for uint256;
    using Address for address;

    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {
        callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    function safeApprove(IERC20 token, address spender, uint256 value) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        // solhint-disable-next-line max-line-length
        require((value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).add(value);
        callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).sub(value, "SafeERC20: decreased allowance below zero");
        callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves.

        // A Solidity high level call has three parts:
        //  1. The target address is checked to verify it contains contract code
        //  2. The call itself is made, and success asserted
        //  3. The return value is decoded, which in turn checks the size of the returned data.
        // solhint-disable-next-line max-line-length
        require(address(token).isContract(), "SafeERC20: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = address(token).call(data);
        require(success, "SafeERC20: low-level call failed");

        if (returndata.length > 0) { // Return data is optional
            // solhint-disable-next-line max-line-length
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}

// File: @openzeppelin/contracts/GSN/Context.sol

pragma solidity ^0.5.0;

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
contract Context {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, which should be used via inheritance.
    constructor () internal { }
    // solhint-disable-previous-line no-empty-blocks

    function _msgSender() internal view returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

// File: @openzeppelin/contracts/introspection/IERC165.sol

pragma solidity ^0.5.0;

/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

// File: @openzeppelin/contracts/token/ERC721/IERC721.sol

pragma solidity ^0.5.0;


/**
 * @dev Required interface of an ERC721 compliant contract.
 */
contract IERC721 is IERC165 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /**
     * @dev Returns the number of NFTs in `owner`'s account.
     */
    function balanceOf(address owner) public view returns (uint256 balance);

    /**
     * @dev Returns the owner of the NFT specified by `tokenId`.
     */
    function ownerOf(uint256 tokenId) public view returns (address owner);

    /**
     * @dev Transfers a specific NFT (`tokenId`) from one account (`from`) to
     * another (`to`).
     *
     *
     *
     * Requirements:
     * - `from`, `to` cannot be zero.
     * - `tokenId` must be owned by `from`.
     * - If the caller is not `from`, it must be have been allowed to move this
     * NFT by either {approve} or {setApprovalForAll}.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) public;
    /**
     * @dev Transfers a specific NFT (`tokenId`) from one account (`from`) to
     * another (`to`).
     *
     * Requirements:
     * - If the caller is not `from`, it must be approved to move this NFT by
     * either {approve} or {setApprovalForAll}.
     */
    function transferFrom(address from, address to, uint256 tokenId) public;
    function approve(address to, uint256 tokenId) public;
    function getApproved(uint256 tokenId) public view returns (address operator);

    function setApprovalForAll(address operator, bool _approved) public;
    function isApprovedForAll(address owner, address operator) public view returns (bool);


    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public;
}

// File: @openzeppelin/contracts/token/ERC721/IERC721Receiver.sol

pragma solidity ^0.5.0;

/**
 * @title ERC721 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from ERC721 asset contracts.
 */
contract IERC721Receiver {
    /**
     * @notice Handle the receipt of an NFT
     * @dev The ERC721 smart contract calls this function on the recipient
     * after a {IERC721-safeTransferFrom}. This function MUST return the function selector,
     * otherwise the caller will revert the transaction. The selector to be
     * returned can be obtained as `this.onERC721Received.selector`. This
     * function MAY throw to revert and reject the transfer.
     * Note: the ERC721 contract address is always the message sender.
     * @param operator The address which called `safeTransferFrom` function
     * @param from The address which previously owned the token
     * @param tokenId The NFT identifier which is being transferred
     * @param data Additional data with no specified format
     * @return bytes4 `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
     */
    function onERC721Received(address operator, address from, uint256 tokenId, bytes memory data)
    public returns (bytes4);
}

// File: @openzeppelin/contracts/drafts/Counters.sol

pragma solidity ^0.5.0;


/**
 * @title Counters
 * @author Matt Condon (@shrugs)
 * @dev Provides counters that can only be incremented or decremented by one. This can be used e.g. to track the number
 * of elements in a mapping, issuing ERC721 ids, or counting request ids.
 *
 * Include with `using Counters for Counters.Counter;`
 * Since it is not possible to overflow a 256 bit integer with increments of one, `increment` can skip the {SafeMath}
 * overflow check, thereby saving gas. This does assume however correct usage, in that the underlying `_value` is never
 * directly accessed.
 */
library Counters {
    using SafeMath for uint256;

    struct Counter {
        // This variable should never be directly accessed by users of the library: interactions must be restricted to
        // the library's function. As of Solidity v0.5.2, this cannot be enforced, though there is a proposal to add
        // this feature: see https://github.com/ethereum/solidity/issues/4637
        uint256 _value; // default: 0
    }

    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }

    function increment(Counter storage counter) internal {
        counter._value += 1;
    }

    function decrement(Counter storage counter) internal {
        counter._value = counter._value.sub(1);
    }
}

// File: @openzeppelin/contracts/introspection/ERC165.sol

pragma solidity ^0.5.0;


/**
 * @dev Implementation of the {IERC165} interface.
 *
 * Contracts may inherit from this and call {_registerInterface} to declare
 * their support of an interface.
 */
contract ERC165 is IERC165 {
    /*
     * bytes4(keccak256('supportsInterface(bytes4)')) == 0x01ffc9a7
     */
    bytes4 private constant _INTERFACE_ID_ERC165 = 0x01ffc9a7;

    /**
     * @dev Mapping of interface ids to whether or not it's supported.
     */
    mapping(bytes4 => bool) private _supportedInterfaces;

    constructor () internal {
        // Derived contracts need only register support for their own interfaces,
        // we register support for ERC165 itself here
        _registerInterface(_INTERFACE_ID_ERC165);
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     *
     * Time complexity O(1), guaranteed to always use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool) {
        return _supportedInterfaces[interfaceId];
    }

    /**
     * @dev Registers the contract as an implementer of the interface defined by
     * `interfaceId`. Support of the actual ERC165 interface is automatic and
     * registering its interface id is not required.
     *
     * See {IERC165-supportsInterface}.
     *
     * Requirements:
     *
     * - `interfaceId` cannot be the ERC165 invalid interface (`0xffffffff`).
     */
    function _registerInterface(bytes4 interfaceId) internal {
        require(interfaceId != 0xffffffff, "ERC165: invalid interface id");
        _supportedInterfaces[interfaceId] = true;
    }
}

// File: @openzeppelin/contracts/token/ERC721/ERC721.sol

pragma solidity ^0.5.0;








/**
 * @title ERC721 Non-Fungible Token Standard basic implementation
 * @dev see https://eips.ethereum.org/EIPS/eip-721
 */
contract ERC721 is Context, ERC165, IERC721 {
    using SafeMath for uint256;
    using Address for address;
    using Counters for Counters.Counter;

    // Equals to `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
    // which can be also obtained as `IERC721Receiver(0).onERC721Received.selector`
    bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;

    // Mapping from token ID to owner
    mapping (uint256 => address) private _tokenOwner;

    // Mapping from token ID to approved address
    mapping (uint256 => address) private _tokenApprovals;

    // Mapping from owner to number of owned token
    mapping (address => Counters.Counter) private _ownedTokensCount;

    // Mapping from owner to operator approvals
    mapping (address => mapping (address => bool)) private _operatorApprovals;

    /*
     *     bytes4(keccak256('balanceOf(address)')) == 0x70a08231
     *     bytes4(keccak256('ownerOf(uint256)')) == 0x6352211e
     *     bytes4(keccak256('approve(address,uint256)')) == 0x095ea7b3
     *     bytes4(keccak256('getApproved(uint256)')) == 0x081812fc
     *     bytes4(keccak256('setApprovalForAll(address,bool)')) == 0xa22cb465
     *     bytes4(keccak256('isApprovedForAll(address,address)')) == 0xe985e9c5
     *     bytes4(keccak256('transferFrom(address,address,uint256)')) == 0x23b872dd
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256)')) == 0x42842e0e
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256,bytes)')) == 0xb88d4fde
     *
     *     => 0x70a08231 ^ 0x6352211e ^ 0x095ea7b3 ^ 0x081812fc ^
     *        0xa22cb465 ^ 0xe985e9c ^ 0x23b872dd ^ 0x42842e0e ^ 0xb88d4fde == 0x80ac58cd
     */
    bytes4 private constant _INTERFACE_ID_ERC721 = 0x80ac58cd;

    constructor () public {
        // register the supported interfaces to conform to ERC721 via ERC165
        _registerInterface(_INTERFACE_ID_ERC721);
    }

    /**
     * @dev Gets the balance of the specified address.
     * @param owner address to query the balance of
     * @return uint256 representing the amount owned by the passed address
     */
    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0), "ERC721: balance query for the zero address");

        return _ownedTokensCount[owner].current();
    }

    /**
     * @dev Gets the owner of the specified token ID.
     * @param tokenId uint256 ID of the token to query the owner of
     * @return address currently marked as the owner of the given token ID
     */
    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _tokenOwner[tokenId];
        require(owner != address(0), "ERC721: owner query for nonexistent token");

        return owner;
    }

    /**
     * @dev Approves another address to transfer the given token ID
     * The zero address indicates there is no approved address.
     * There can only be one approved address per token at a given time.
     * Can only be called by the token owner or an approved operator.
     * @param to address to be approved for the given token ID
     * @param tokenId uint256 ID of the token to be approved
     */
    function approve(address to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(to != owner, "ERC721: approval to current owner");

        require(_msgSender() == owner || isApprovedForAll(owner, _msgSender()),
            "ERC721: approve caller is not owner nor approved for all"
        );

        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    /**
     * @dev Gets the approved address for a token ID, or zero if no address set
     * Reverts if the token ID does not exist.
     * @param tokenId uint256 ID of the token to query the approval of
     * @return address currently approved for the given token ID
     */
    function getApproved(uint256 tokenId) public view returns (address) {
        require(_exists(tokenId), "ERC721: approved query for nonexistent token");

        return _tokenApprovals[tokenId];
    }

    /**
     * @dev Sets or unsets the approval of a given operator
     * An operator is allowed to transfer all tokens of the sender on their behalf.
     * @param to operator address to set the approval
     * @param approved representing the status of the approval to be set
     */
    function setApprovalForAll(address to, bool approved) public {
        require(to != _msgSender(), "ERC721: approve to caller");

        _operatorApprovals[_msgSender()][to] = approved;
        emit ApprovalForAll(_msgSender(), to, approved);
    }

    /**
     * @dev Tells whether an operator is approved by a given owner.
     * @param owner owner address which you want to query the approval of
     * @param operator operator address which you want to query the approval of
     * @return bool whether the given operator is approved by the given owner
     */
    function isApprovedForAll(address owner, address operator) public view returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    /**
     * @dev Transfers the ownership of a given token ID to another address.
     * Usage of this method is discouraged, use {safeTransferFrom} whenever possible.
     * Requires the msg.sender to be the owner, approved, or operator.
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function transferFrom(address from, address to, uint256 tokenId) public {
        //solhint-disable-next-line max-line-length
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");

        _transferFrom(from, to, tokenId);
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement {IERC721Receiver-onERC721Received},
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the msg.sender to be the owner, approved, or operator
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) public {
        safeTransferFrom(from, to, tokenId, "");
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement {IERC721Receiver-onERC721Received},
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the _msgSender() to be the owner, approved, or operator
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes data to send along with a safe transfer check
     */
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");
        _safeTransferFrom(from, to, tokenId, _data);
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement `onERC721Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the msg.sender to be the owner, approved, or operator
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes data to send along with a safe transfer check
     */
    function _safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) internal {
        _transferFrom(from, to, tokenId);
        require(_checkOnERC721Received(from, to, tokenId, _data), "ERC721: transfer to non ERC721Receiver implementer");
    }

    /**
     * @dev Returns whether the specified token exists.
     * @param tokenId uint256 ID of the token to query the existence of
     * @return bool whether the token exists
     */
    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    /**
     * @dev Returns whether the given spender can transfer a given token ID.
     * @param spender address of the spender to query
     * @param tokenId uint256 ID of the token to be transferred
     * @return bool whether the msg.sender is approved for the given token ID,
     * is an operator of the owner, or is the owner of the token
     */
    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) {
        require(_exists(tokenId), "ERC721: operator query for nonexistent token");
        address owner = ownerOf(tokenId);
        return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));
    }

    /**
     * @dev Internal function to safely mint a new token.
     * Reverts if the given token ID already exists.
     * If the target address is a contract, it must implement `onERC721Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * @param to The address that will own the minted token
     * @param tokenId uint256 ID of the token to be minted
     */
    function _safeMint(address to, uint256 tokenId) internal {
        _safeMint(to, tokenId, "");
    }

    /**
     * @dev Internal function to safely mint a new token.
     * Reverts if the given token ID already exists.
     * If the target address is a contract, it must implement `onERC721Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * @param to The address that will own the minted token
     * @param tokenId uint256 ID of the token to be minted
     * @param _data bytes data to send along with a safe transfer check
     */
    function _safeMint(address to, uint256 tokenId, bytes memory _data) internal {
        _mint(to, tokenId);
        require(_checkOnERC721Received(address(0), to, tokenId, _data), "ERC721: transfer to non ERC721Receiver implementer");
    }

    /**
     * @dev Internal function to mint a new token.
     * Reverts if the given token ID already exists.
     * @param to The address that will own the minted token
     * @param tokenId uint256 ID of the token to be minted
     */
    function _mint(address to, uint256 tokenId) internal {
        require(to != address(0), "ERC721: mint to the zero address");
        require(!_exists(tokenId), "ERC721: token already minted");

        _tokenOwner[tokenId] = to;
        _ownedTokensCount[to].increment();

        emit Transfer(address(0), to, tokenId);
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * Deprecated, use {_burn} instead.
     * @param owner owner of the token to burn
     * @param tokenId uint256 ID of the token being burned
     */
    function _burn(address owner, uint256 tokenId) internal {
        require(ownerOf(tokenId) == owner, "ERC721: burn of token that is not own");

        _clearApproval(tokenId);

        _ownedTokensCount[owner].decrement();
        _tokenOwner[tokenId] = address(0);

        emit Transfer(owner, address(0), tokenId);
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * @param tokenId uint256 ID of the token being burned
     */
    function _burn(uint256 tokenId) internal {
        _burn(ownerOf(tokenId), tokenId);
    }

    /**
     * @dev Internal function to transfer ownership of a given token ID to another address.
     * As opposed to {transferFrom}, this imposes no restrictions on msg.sender.
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function _transferFrom(address from, address to, uint256 tokenId) internal {
        require(ownerOf(tokenId) == from, "ERC721: transfer of token that is not own");
        require(to != address(0), "ERC721: transfer to the zero address");

        _clearApproval(tokenId);

        _ownedTokensCount[from].decrement();
        _ownedTokensCount[to].increment();

        _tokenOwner[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }

    /**
     * @dev Internal function to invoke {IERC721Receiver-onERC721Received} on a target address.
     * The call is not executed if the target address is not a contract.
     *
     * This function is deprecated.
     * @param from address representing the previous owner of the given token ID
     * @param to target address that will receive the tokens
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes optional data to send along with the call
     * @return bool whether the call correctly returned the expected magic value
     */
    function _checkOnERC721Received(address from, address to, uint256 tokenId, bytes memory _data)
        internal returns (bool)
    {
        if (!to.isContract()) {
            return true;
        }

        bytes4 retval = IERC721Receiver(to).onERC721Received(_msgSender(), from, tokenId, _data);
        return (retval == _ERC721_RECEIVED);
    }

    /**
     * @dev Private function to clear current approval of a given token ID.
     * @param tokenId uint256 ID of the token to be transferred
     */
    function _clearApproval(uint256 tokenId) private {
        if (_tokenApprovals[tokenId] != address(0)) {
            _tokenApprovals[tokenId] = address(0);
        }
    }
}

// File: @openzeppelin/contracts/token/ERC721/IERC721Enumerable.sol

pragma solidity ^0.5.0;


/**
 * @title ERC-721 Non-Fungible Token Standard, optional enumeration extension
 * @dev See https://eips.ethereum.org/EIPS/eip-721
 */
contract IERC721Enumerable is IERC721 {
    function totalSupply() public view returns (uint256);
    function tokenOfOwnerByIndex(address owner, uint256 index) public view returns (uint256 tokenId);

    function tokenByIndex(uint256 index) public view returns (uint256);
}

// File: @openzeppelin/contracts/token/ERC721/ERC721Enumerable.sol

pragma solidity ^0.5.0;





/**
 * @title ERC-721 Non-Fungible Token with optional enumeration extension logic
 * @dev See https://eips.ethereum.org/EIPS/eip-721
 */
contract ERC721Enumerable is Context, ERC165, ERC721, IERC721Enumerable {
    // Mapping from owner to list of owned token IDs
    mapping(address => uint256[]) private _ownedTokens;

    // Mapping from token ID to index of the owner tokens list
    mapping(uint256 => uint256) private _ownedTokensIndex;

    // Array with all token ids, used for enumeration
    uint256[] private _allTokens;

    // Mapping from token id to position in the allTokens array
    mapping(uint256 => uint256) private _allTokensIndex;

    /*
     *     bytes4(keccak256('totalSupply()')) == 0x18160ddd
     *     bytes4(keccak256('tokenOfOwnerByIndex(address,uint256)')) == 0x2f745c59
     *     bytes4(keccak256('tokenByIndex(uint256)')) == 0x4f6ccce7
     *
     *     => 0x18160ddd ^ 0x2f745c59 ^ 0x4f6ccce7 == 0x780e9d63
     */
    bytes4 private constant _INTERFACE_ID_ERC721_ENUMERABLE = 0x780e9d63;

    /**
     * @dev Constructor function.
     */
    constructor () public {
        // register the supported interface to conform to ERC721Enumerable via ERC165
        _registerInterface(_INTERFACE_ID_ERC721_ENUMERABLE);
    }

    /**
     * @dev Gets the token ID at a given index of the tokens list of the requested owner.
     * @param owner address owning the tokens list to be accessed
     * @param index uint256 representing the index to be accessed of the requested tokens list
     * @return uint256 token ID at the given index of the tokens list owned by the requested address
     */
    function tokenOfOwnerByIndex(address owner, uint256 index) public view returns (uint256) {
        require(index < balanceOf(owner), "ERC721Enumerable: owner index out of bounds");
        return _ownedTokens[owner][index];
    }

    /**
     * @dev Gets the total amount of tokens stored by the contract.
     * @return uint256 representing the total amount of tokens
     */
    function totalSupply() public view returns (uint256) {
        return _allTokens.length;
    }

    /**
     * @dev Gets the token ID at a given index of all the tokens in this contract
     * Reverts if the index is greater or equal to the total number of tokens.
     * @param index uint256 representing the index to be accessed of the tokens list
     * @return uint256 token ID at the given index of the tokens list
     */
    function tokenByIndex(uint256 index) public view returns (uint256) {
        require(index < totalSupply(), "ERC721Enumerable: global index out of bounds");
        return _allTokens[index];
    }

    /**
     * @dev Internal function to transfer ownership of a given token ID to another address.
     * As opposed to transferFrom, this imposes no restrictions on msg.sender.
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function _transferFrom(address from, address to, uint256 tokenId) internal {
        super._transferFrom(from, to, tokenId);

        _removeTokenFromOwnerEnumeration(from, tokenId);

        _addTokenToOwnerEnumeration(to, tokenId);
    }

    /**
     * @dev Internal function to mint a new token.
     * Reverts if the given token ID already exists.
     * @param to address the beneficiary that will own the minted token
     * @param tokenId uint256 ID of the token to be minted
     */
    function _mint(address to, uint256 tokenId) internal {
        super._mint(to, tokenId);

        _addTokenToOwnerEnumeration(to, tokenId);

        _addTokenToAllTokensEnumeration(tokenId);
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * Deprecated, use {ERC721-_burn} instead.
     * @param owner owner of the token to burn
     * @param tokenId uint256 ID of the token being burned
     */
    function _burn(address owner, uint256 tokenId) internal {
        super._burn(owner, tokenId);

        _removeTokenFromOwnerEnumeration(owner, tokenId);
        // Since tokenId will be deleted, we can clear its slot in _ownedTokensIndex to trigger a gas refund
        _ownedTokensIndex[tokenId] = 0;

        _removeTokenFromAllTokensEnumeration(tokenId);
    }

    /**
     * @dev Gets the list of token IDs of the requested owner.
     * @param owner address owning the tokens
     * @return uint256[] List of token IDs owned by the requested address
     */
    function _tokensOfOwner(address owner) internal view returns (uint256[] storage) {
        return _ownedTokens[owner];
    }

    /**
     * @dev Private function to add a token to this extension's ownership-tracking data structures.
     * @param to address representing the new owner of the given token ID
     * @param tokenId uint256 ID of the token to be added to the tokens list of the given address
     */
    function _addTokenToOwnerEnumeration(address to, uint256 tokenId) private {
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
    }

    /**
     * @dev Private function to add a token to this extension's token tracking data structures.
     * @param tokenId uint256 ID of the token to be added to the tokens list
     */
    function _addTokenToAllTokensEnumeration(uint256 tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    /**
     * @dev Private function to remove a token from this extension's ownership-tracking data structures. Note that
     * while the token is not assigned a new owner, the `_ownedTokensIndex` mapping is _not_ updated: this allows for
     * gas optimizations e.g. when performing a transfer operation (avoiding double writes).
     * This has O(1) time complexity, but alters the order of the _ownedTokens array.
     * @param from address representing the previous owner of the given token ID
     * @param tokenId uint256 ID of the token to be removed from the tokens list of the given address
     */
    function _removeTokenFromOwnerEnumeration(address from, uint256 tokenId) private {
        // To prevent a gap in from's tokens array, we store the last token in the index of the token to delete, and
        // then delete the last slot (swap and pop).

        uint256 lastTokenIndex = _ownedTokens[from].length.sub(1);
        uint256 tokenIndex = _ownedTokensIndex[tokenId];

        // When the token to delete is the last token, the swap operation is unnecessary
        if (tokenIndex != lastTokenIndex) {
            uint256 lastTokenId = _ownedTokens[from][lastTokenIndex];

            _ownedTokens[from][tokenIndex] = lastTokenId; // Move the last token to the slot of the to-delete token
            _ownedTokensIndex[lastTokenId] = tokenIndex; // Update the moved token's index
        }

        // This also deletes the contents at the last position of the array
        _ownedTokens[from].length--;

        // Note that _ownedTokensIndex[tokenId] hasn't been cleared: it still points to the old slot (now occupied by
        // lastTokenId, or just over the end of the array if the token was the last one).
    }

    /**
     * @dev Private function to remove a token from this extension's token tracking data structures.
     * This has O(1) time complexity, but alters the order of the _allTokens array.
     * @param tokenId uint256 ID of the token to be removed from the tokens list
     */
    function _removeTokenFromAllTokensEnumeration(uint256 tokenId) private {
        // To prevent a gap in the tokens array, we store the last token in the index of the token to delete, and
        // then delete the last slot (swap and pop).

        uint256 lastTokenIndex = _allTokens.length.sub(1);
        uint256 tokenIndex = _allTokensIndex[tokenId];

        // When the token to delete is the last token, the swap operation is unnecessary. However, since this occurs so
        // rarely (when the last minted token is burnt) that we still do the swap here to avoid the gas cost of adding
        // an 'if' statement (like in _removeTokenFromOwnerEnumeration)
        uint256 lastTokenId = _allTokens[lastTokenIndex];

        _allTokens[tokenIndex] = lastTokenId; // Move the last token to the slot of the to-delete token
        _allTokensIndex[lastTokenId] = tokenIndex; // Update the moved token's index

        // This also deletes the contents at the last position of the array
        _allTokens.length--;
        _allTokensIndex[tokenId] = 0;
    }
}

// File: @openzeppelin/contracts/token/ERC721/IERC721Metadata.sol

pragma solidity ^0.5.0;


/**
 * @title ERC-721 Non-Fungible Token Standard, optional metadata extension
 * @dev See https://eips.ethereum.org/EIPS/eip-721
 */
contract IERC721Metadata is IERC721 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function tokenURI(uint256 tokenId) external view returns (string memory);
}

// File: @openzeppelin/contracts/token/ERC721/ERC721Metadata.sol

pragma solidity ^0.5.0;





contract ERC721Metadata is Context, ERC165, ERC721, IERC721Metadata {
    // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    // Optional mapping for token URIs
    mapping(uint256 => string) private _tokenURIs;

    /*
     *     bytes4(keccak256('name()')) == 0x06fdde03
     *     bytes4(keccak256('symbol()')) == 0x95d89b41
     *     bytes4(keccak256('tokenURI(uint256)')) == 0xc87b56dd
     *
     *     => 0x06fdde03 ^ 0x95d89b41 ^ 0xc87b56dd == 0x5b5e139f
     */
    bytes4 private constant _INTERFACE_ID_ERC721_METADATA = 0x5b5e139f;

    /**
     * @dev Constructor function
     */
    constructor (string memory name, string memory symbol) public {
        _name = name;
        _symbol = symbol;

        // register the supported interfaces to conform to ERC721 via ERC165
        _registerInterface(_INTERFACE_ID_ERC721_METADATA);
    }

    /**
     * @dev Gets the token name.
     * @return string representing the token name
     */
    function name() external view returns (string memory) {
        return _name;
    }

    /**
     * @dev Gets the token symbol.
     * @return string representing the token symbol
     */
    function symbol() external view returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns an URI for a given token ID.
     * Throws if the token ID does not exist. May return an empty string.
     * @param tokenId uint256 ID of the token to query
     */
    function tokenURI(uint256 tokenId) external view returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return _tokenURIs[tokenId];
    }

    /**
     * @dev Internal function to set the token URI for a given token.
     * Reverts if the token ID does not exist.
     * @param tokenId uint256 ID of the token to set its URI
     * @param uri string URI to assign
     */
    function _setTokenURI(uint256 tokenId, string memory uri) internal {
        require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");
        _tokenURIs[tokenId] = uri;
    }

    /**
     * @dev Internal function to burn a specific token.
     * Reverts if the token does not exist.
     * Deprecated, use _burn(uint256) instead.
     * @param owner owner of the token to burn
     * @param tokenId uint256 ID of the token being burned by the msg.sender
     */
    function _burn(address owner, uint256 tokenId) internal {
        super._burn(owner, tokenId);

        // Clear metadata (if any)
        if (bytes(_tokenURIs[tokenId]).length != 0) {
            delete _tokenURIs[tokenId];
        }
    }
}

// File: contracts/IHolder.sol

pragma solidity ^0.5.0;



interface IFlashLoan {
    function flashLoan(IERC20 asset, uint256 amount, bytes calldata data) external;
    function repayFlashLoan(IERC20 token, uint256 amount) external;
}


interface IExchange {
    function exchangeExpectedReturn(
        IERC20 fromToken,
        IERC20 toToken,
        uint256 amount
    ) external returns(uint256);

    function exchange(
        IERC20 fromToken,
        IERC20 toToken,
        uint256 amount,
        uint256 minReturn,
        uint256[] calldata distribution,
        uint256 disableFlags
    ) external payable returns(uint256);
}


interface IOracle {
    function getPrice(IERC20 token) external view returns(uint256);
}


interface IProtocol {
    function collateralAmount(IERC20 token, address who) external returns(uint256);
    function borrowAmount(IERC20 token, address who) external returns(uint256);

    function deposit(IERC20 token, uint256 amount) external;
    function redeem(IERC20 token, uint256 amount) external;
    function redeemAll(IERC20 token) external;
    function borrow(IERC20 token, uint256 amount) external;
    function repay(IERC20 token, address who, uint256 amount) external;
}


contract IHolder {
    address public owner = msg.sender;
    address public delegate;

    modifier onlyOwner {
        require(msg.sender == owner, "IHolder: access denied");
        _;
    }

    function moveIn(
        IFlashLoan flashLoaner,
        IProtocol protocol,
        IERC20 collateral,
        IERC20 debt
    ) external {}
}

// File: contracts/HolderProxy.sol

pragma solidity ^0.5.0;



contract HolderProxy is IHolder {
    constructor(address newDelegate) public {
        delegate = newDelegate;
    }

    function upgradeDelegate(address newDelegate) public onlyOwner {
        if (delegate != newDelegate && newDelegate != address(0)) {
            delegate = newDelegate;
        }
    }

    function transferOwnership(address to) external onlyOwner {
        owner = to;
    }

    function() external payable {
        require(delegate != address(0), "HolderProxy: Delegate not initialized");

        (bool success, bytes memory data) = delegate.delegatecall(msg.data);
        require(success, string(abi.encodePacked("HolderProxy: delegate call failed (", data, ")")));
        assembly {
            return(add(data, 32), returndatasize)
        }
    }
}

// File: @openzeppelin/contracts/token/ERC20/ERC20Detailed.sol

pragma solidity ^0.5.0;


/**
 * @dev Optional functions from the ERC20 standard.
 */
contract ERC20Detailed is IERC20 {
    string private _name;
    string private _symbol;
    uint8 private _decimals;

    /**
     * @dev Sets the values for `name`, `symbol`, and `decimals`. All three of
     * these values are immutable: they can only be set once during
     * construction.
     */
    constructor (string memory name, string memory symbol, uint8 decimals) public {
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5,05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei.
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view returns (uint8) {
        return _decimals;
    }
}

// File: contracts/lib/UniversalERC20.sol

pragma solidity ^0.5.0;






library UniversalERC20 {

    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    IERC20 private constant ZERO_ADDRESS = IERC20(0x0000000000000000000000000000000000000000);
    IERC20 private constant ETH_ADDRESS = IERC20(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE);

    function universalTransfer(IERC20 token, address to, uint256 amount) internal returns(bool) {
        if (amount == 0) {
            return true;
        }

        if (isETH(token)) {
            address(uint160(to)).transfer(amount);
        } else {
            token.safeTransfer(to, amount);
            return true;
        }
    }

    function universalTransferFrom(IERC20 token, address from, address to, uint256 amount) internal {
        if (amount == 0) {
            return;
        }

        if (isETH(token)) {
            require(from == msg.sender && msg.value >= amount, "msg.value is zero");
            if (to != address(this)) {
                address(uint160(to)).transfer(amount);
            }
            if (msg.value > amount) {
                msg.sender.transfer(msg.value.sub(amount));
            }
        } else {
            token.safeTransferFrom(from, to, amount);
        }
    }

    function universalApprove(IERC20 token, address to, uint256 amount) internal {
        if (!isETH(token)) {
            if (amount > 0 && token.allowance(address(this), to) > 0) {
                token.safeApprove(to, 0);
            }
            token.safeApprove(to, amount);
        }
    }

    function universalInfiniteApproveIfNeeded(IERC20 token, address to) internal {
        if (!isETH(token)) {
            if ((token.allowance(address(this), to) >> 255) == 0) {
                token.safeApprove(to, uint256(-1));
            }
        }
    }

    function universalBalanceOf(IERC20 token, address who) internal view returns(uint256) {
        if (isETH(token)) {
            return who.balance;
        } else {
            return token.balanceOf(who);
        }
    }

    function universalSymbol(IERC20 token) internal view returns(string memory) {
        if (isETH(token)) {
            return "ETH";
        } else {
            return ERC20Detailed(address(token)).symbol();
        }
    }

    function universalDecimals(IERC20 token) internal view returns(uint256) {

        if (isETH(token)) {
            return 18;
        }

        (bool success, bytes memory data) = address(token).staticcall.gas(5000)(
            abi.encodeWithSignature("decimals()")
        );
        if (!success) {
            (success, data) = address(token).staticcall.gas(5000)(
                abi.encodeWithSignature("DECIMALS()")
            );
        }

        return success ? abi.decode(data, (uint256)) : 18;
    }

    function isETH(IERC20 token) internal pure returns(bool) {
        return (address(token) == address(ZERO_ADDRESS) || address(token) == address(ETH_ADDRESS));
    }
}

// File: contracts/HolderBase.sol

pragma solidity ^0.5.0;







contract HolderBase is IHolder {

    using SafeMath for uint256;
    using UniversalERC20 for IERC20;

    modifier onlyCallback {
        require(msg.sender == address(this), "HolderBase: access denied");
        _;
    }

    function() external payable {
        require(msg.sender != tx.origin);
    }

    // function closePosition(
    //     IERC20 collateral,
    //     IERC20 debt,
    //     address user,
    //     uint256 minReturn
    // )
    //     external
    //     onlyOwner
    // {
    //     uint256 borrowedAmount = borrowAmount(debt);

    //     _flashLoan(
    //         debt,
    //         borrowedAmount,
    //         abi.encodeWithSelector(
    //             this.closePositionCallback.selector,
    //             collateral,
    //             debt,
    //             user,
    //             minReturn,
    //             borrowedAmount
    //             // repayAmount added dynamically in executeOperation
    //         )
    //     );
    // }

    // function closePositionCallback(
    //     IERC20 collateral,
    //     IERC20 debt,
    //     address user,
    //     uint256 minReturn,
    //     uint256 borrowedAmount,
    //     uint256 repayAmount
    // )
    //     external
    //     onlyCallback
    // {
    //     _repay(debt, borrowedAmount);
    //     _redeemAll(collateral);
    //     uint256 returnedAmount = _exchange(collateral, debt, collateral.universalBalanceOf(address(this)), minReturn);
    //     _repayFlashLoan(debt, repayAmount);
    //     debt.universalTransfer(user, returnedAmount.sub(repayAmount));
    // }

    // IFlashLoan

    function _flashLoan(IFlashLoan flashLoaner, IERC20 asset, uint256 amount, bytes memory data) internal {
        (bool success, bytes memory res) = address(flashLoaner).delegatecall(
            abi.encodeWithSelector(
                flashLoaner.flashLoan.selector,
                asset,
                amount,
                data
            )
        );
        require(success, string(abi.encodePacked("IHolder: failed in _flashLoan():", res)));
    }

    function _repayFlashLoan(IFlashLoan flashLoaner, IERC20 token, uint256 amount) internal {
        (bool success, bytes memory res) = address(flashLoaner).delegatecall(
            abi.encodeWithSelector(
                flashLoaner.repayFlashLoan.selector,
                token,
                amount
            )
        );
        require(success, string(abi.encodePacked("IHolder: failed in _repayFlashLoan():", res)));
    }

    // IExchange

    function _exchangeExpectedReturn(
        IExchange exchange,
        IERC20 fromToken,
        IERC20 toToken,
        uint256 amount
    ) internal returns(uint256) {
        (bool success, bytes memory res) = address(exchange).delegatecall(
            abi.encodeWithSelector(
                exchange.exchangeExpectedReturn.selector,
                fromToken,
                toToken,
                amount
            )
        );
        require(success, string(abi.encodePacked("IHolder: failed in _exchangeExpectedReturn():", res)));
        return abi.decode(res, (uint256));
    }

    function _exchange(
        IExchange exchange,
        IERC20 fromToken,
        IERC20 toToken,
        uint256 amount,
        uint256 minReturn,
        uint256[] memory distribution,
        uint256 disableFlags
    ) internal returns(uint256) {
        (bool success, bytes memory res) = address(exchange).delegatecall(
            abi.encodeWithSelector(
                exchange.exchange.selector,
                fromToken,
                toToken,
                amount,
                minReturn,
                distribution,
                disableFlags
            )
        );
        require(success, string(abi.encodePacked("IHolder: failed in _exchange():", res)));
        return abi.decode(res, (uint256));
    }

    // IOracle

    function _getPrice(IOracle oracle, IERC20 token) internal returns(uint256) {
        (bool success, bytes memory res) = address(oracle).delegatecall(
            abi.encodeWithSelector(
                oracle.getPrice.selector,
                token
            )
        );
        require(success, string(abi.encodePacked("IHolder: failed in _getPrice():", res)));
        return abi.decode(res, (uint256));
    }

    // IProtocol

    function _collateralAmount(IProtocol protocol, IERC20 token, address who) internal returns(uint256) {
        (bool success, bytes memory res) = address(protocol).delegatecall(
            abi.encodeWithSelector(
                protocol.collateralAmount.selector,
                token,
                who
            )
        );
        require(success, string(abi.encodePacked("IHolder: failed in _collateralAmount():", res)));
        return abi.decode(res, (uint256));
    }

    function _borrowAmount(IProtocol protocol, IERC20 token, address who) internal returns(uint256) {
        (bool success, bytes memory res) = address(protocol).delegatecall(
            abi.encodeWithSelector(
                protocol.borrowAmount.selector,
                token,
                who
            )
        );
        require(success, string(abi.encodePacked("IHolder: failed in _borrowAmount():", res)));
        return abi.decode(res, (uint256));
    }

    function _deposit(IProtocol protocol, IERC20 token, uint256 amount) internal {
        (bool success, bytes memory res) = address(protocol).delegatecall(
            abi.encodeWithSelector(
                protocol.deposit.selector,
                token,
                amount
            )
        );
        require(success, string(abi.encodePacked("IHolder: failed in _deposit():", res)));
    }

    function _redeem(IProtocol protocol, IERC20 token, uint256 amount) internal {
        (bool success, bytes memory res) = address(protocol).delegatecall(
            abi.encodeWithSelector(
                protocol.redeem.selector,
                token,
                amount
            )
        );
        require(success, string(abi.encodePacked("IHolder: failed in _redeem():", res)));
    }

    function _redeemAll(IProtocol protocol, IERC20 token) internal {
        (bool success, bytes memory res) = address(protocol).delegatecall(
            abi.encodeWithSelector(
                protocol.redeemAll.selector,
                token
            )
        );
        require(success, string(abi.encodePacked("IHolder: failed in _redeemAll():", res)));
    }

    function _borrow(IProtocol protocol, IERC20 token, uint256 amount) internal {
        (bool success, bytes memory res) = address(protocol).delegatecall(
            abi.encodeWithSelector(
                protocol.borrow.selector,
                token,
                amount
            )
        );
        require(success, string(abi.encodePacked("IHolder: failed in _borrow():", res)));
    }

    function _repay(IProtocol protocol, IERC20 token, address who, uint256 amount) internal {
        (bool success, bytes memory res) = address(protocol).delegatecall(
            abi.encodeWithSelector(
                protocol.repay.selector,
                token,
                who,
                amount
            )
        );
        require(success, string(abi.encodePacked("IHolder: failed in _repay():", res)));
    }
}

// File: contracts/interface/aave/IFlashLoanReceiver.sol

pragma solidity ^0.5.0;

interface IFlashLoanReceiver {
    function executeOperation(address _reserve, uint256 _amount, uint256 _fee, bytes calldata _params) external;
}

// File: contracts/interface/aave/ILendingPool.sol

pragma solidity ^0.5.0;

interface ILendingPool {
    function deposit(address _reserve, uint256 _amount, uint16 _referralCode) external payable;
    function borrow(address _reserve, uint256 _amount, uint256 _interestRateMode, uint16 _referralCode) external;
    function repay(address _reserve, uint256 _amount, address payable _onBehalfOf) external payable;
    function flashLoan(address _receiver, address _reserve, uint256 _amount, bytes calldata _params) external;
}

// File: contracts/mixins/FlashLoanAave.sol

pragma solidity ^0.5.0;








contract FlashLoanAave is IFlashLoan {

    using SafeMath for uint256;
    using UniversalERC20 for IERC20;

    ILendingPool public constant POOL = ILendingPool(0x398eC7346DcD622eDc5ae82352F02bE94C62d119);
    address public constant CORE = 0x3dfd23A6c5E8BbcFc9581d2E864a68feb6a076d3;

    function flashLoan(IERC20 token, uint256 amount, bytes calldata data) external {
        POOL.flashLoan(
            address(this),
            token.isETH() ? 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE : address(token),
            amount,
            data
        );
    }

    function repayFlashLoan(IERC20 token, uint256 amount) external {
        token.universalTransfer(CORE, amount);
    }

    // Callback for Aave flashLoan
    function executeOperation(
        address /*reserve*/,
        uint256 amount,
        uint256 fee,
        bytes calldata params
    ) external {
        require(msg.sender == address(POOL), "Access denied, only pool alowed");
        (bool success, bytes memory data) = address(this).call(abi.encodePacked(params, amount.add(fee)));
        require(success, string(abi.encodePacked("External call failed: ", data)));
    }
}

// File: contracts/interface/IOneSplit.sol

pragma solidity ^0.5.0;



contract IOneSplit {

    // disableFlags = FLAG_UNISWAP + FLAG_KYBER + ...
    uint256 constant public FLAG_UNISWAP = 0x01;
    uint256 constant public FLAG_KYBER = 0x02;
    uint256 constant public FLAG_KYBER_UNISWAP_RESERVE = 0x100000000; // Turned off by default
    uint256 constant public FLAG_KYBER_OASIS_RESERVE = 0x200000000; // Turned off by default
    uint256 constant public FLAG_KYBER_BANCOR_RESERVE = 0x400000000; // Turned off by default
    uint256 constant public FLAG_BANCOR = 0x04;
    uint256 constant public FLAG_OASIS = 0x08;
    uint256 constant public FLAG_COMPOUND = 0x10;
    uint256 constant public FLAG_FULCRUM = 0x20;
    uint256 constant public FLAG_CHAI = 0x40;
    uint256 constant public FLAG_AAVE = 0x80;
    uint256 constant public FLAG_SMART_TOKEN = 0x100;
    uint256 constant public FLAG_MULTI_PATH_ETH = 0x200; // Turned off by default

    function getExpectedReturn(
        IERC20 fromToken,
        IERC20 toToken,
        uint256 amount,
        uint256 parts,
        uint256 disableFlags // 1 - Uniswap, 2 - Kyber, 4 - Bancor, 8 - Oasis, 16 - Compound, 32 - Fulcrum, 64 - Chai, 128 - Aave, 256 - SmartToken
    )
        public
        view
        returns(
            uint256 returnAmount,
            uint256[] memory distribution // [Uniswap, Kyber, Bancor, Oasis]
        );

    function swap(
        IERC20 fromToken,
        IERC20 toToken,
        uint256 amount,
        uint256 minReturn,
        uint256[] memory distribution, // [Uniswap, Kyber, Bancor, Oasis]
        uint256 disableFlags // 16 - Compound, 32 - Fulcrum, 64 - Chai, 128 - Aave, 256 - SmartToken
    )
        public
        payable;

    function goodSwap(
        IERC20 fromToken,
        IERC20 toToken,
        uint256 amount,
        uint256 minReturn,
        uint256 parts,
        uint256 disableFlags // 1 - Uniswap, 2 - Kyber, 4 - Bancor, 8 - Oasis, 16 - Compound, 32 - Fulcrum, 64 - Chai, 128 - Aave, 256 - SmartToken
    )
        public
        payable;
}

// File: contracts/mixins/ExchangeOneSplit.sol

pragma solidity ^0.5.0;







contract ExchangeOneSplit is IExchange {

    using SafeMath for uint256;
    using UniversalERC20 for IERC20;

    IOneSplit public constant ONE_SPLIT = IOneSplit(0xDFf2AA5689FCBc7F479d8c84aC857563798436DD);

    function exchangeExpectedReturn(
        IERC20 fromToken,
        IERC20 toToken,
        uint256 amount,
        uint256 parts,
        uint256 disableFlags
    ) external view returns(uint256, uint256[] memory) {
        return ONE_SPLIT.getExpectedReturn(
            fromToken,
            toToken,
            amount,
            parts,
            disableFlags
        );
    }

    function exchange(
        IERC20 fromToken,
        IERC20 toToken,
        uint256 amount,
        uint256 minReturn,
        uint256[] calldata distribution,
        uint256 disableFlags
    ) external payable returns(uint256) {
        fromToken.universalApprove(address(ONE_SPLIT), amount);

        uint256 beforeBalance = toToken.universalBalanceOf(address(this));
        ONE_SPLIT.swap.value(fromToken.isETH() ? amount : 0)(
            fromToken,
            toToken,
            amount,
            minReturn,
            distribution,
            disableFlags
        );

        return toToken.universalBalanceOf(address(this)).sub(beforeBalance);
    }
}

// File: contracts/interface/compound/IPriceOracle.sol

pragma solidity ^0.5.0;

interface IPriceOracle {
    /**
      * @notice Get the underlying price of a cToken asset
      * @param cToken The cToken to get the underlying price of
      * @return The underlying asset price mantissa (scaled by 1e18).
      *  Zero means the price is unavailable.
      */
    function getUnderlyingPrice(address cToken) external view returns(uint256);
}

// File: contracts/interface/compound/ICompoundController.sol

pragma solidity ^0.5.0;



interface ICompoundController {
    function oracle() external view returns(IPriceOracle);
    function enterMarkets(address[] calldata cTokens) external returns(uint256[] memory);
    function checkMembership(address account, address cToken) external view returns(bool);
}

// File: contracts/interface/compound/ICERC20.sol

pragma solidity ^0.5.0;




contract ICERC20 is IERC20 {
    function comptroller() external view returns(ICompoundController);
    function balanceOfUnderlying(address account) external returns(uint256);
    function borrowBalanceCurrent(address account) external returns(uint256);

    function mint() external payable;
    function mint(uint256 amount) external returns(uint256);
    function redeem(uint256 amount) external returns(uint256);
    function borrow(uint256 amount) external returns(uint256);
    function repayBorrow() external payable returns(uint256);
    function repayBorrow(uint256 repayAmount) external returns(uint256);
    function repayBorrowBehalf(address who) external payable returns(uint256);
    function repayBorrowBehalf(address who, uint256 repayAmount) external returns(uint256);

}

// File: contracts/mixins/CompoundUtils.sol

pragma solidity ^0.5.0;





contract CompoundUtils {
    using UniversalERC20 for IERC20;

    function _getCToken(IERC20 token) internal pure returns(ICERC20) {
        if (token.isETH()) {                                                // ETH
            return ICERC20(0x4Ddc2D193948926D02f9B1fE9e1daa0718270ED5);
        }
        if (token == IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F)) {  // DAI
            return ICERC20(0x5d3a536E4D6DbD6114cc1Ead35777bAB948E3643);
        }
        if (token == IERC20(0x0D8775F648430679A709E98d2b0Cb6250d2887EF)) {  // BAT
            return ICERC20(0x6C8c6b02E7b2BE14d4fA6022Dfd6d75921D90E4E);
        }
        if (token == IERC20(0x1985365e9f78359a9B6AD760e32412f4a445E862)) {  // REP
            return ICERC20(0x158079Ee67Fce2f58472A96584A73C7Ab9AC95c1);
        }
        if (token == IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48)) {  // USDC
            return ICERC20(0x39AA39c021dfbaE8faC545936693aC917d5E7563);
        }
        if (token == IERC20(0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599)) {  // WBTC
            return ICERC20(0xC11b1268C1A384e55C48c2391d8d480264A3A7F4);
        }
        if (token == IERC20(0xE41d2489571d322189246DaFA5ebDe1F4699F498)) {  // ZRX
            return ICERC20(0xB3319f5D18Bc0D84dD1b4825Dcde5d5f7266d407);
        }

        revert("Unsupported token");
    }
}

// File: contracts/mixins/ProtocolCompound.sol

pragma solidity ^0.5.0;









contract ProtocolCompound is IProtocol, IOracle, CompoundUtils {
    using SafeMath for uint256;
    using UniversalERC20 for IERC20;

    function collateralAmount(IERC20 token, address who) public returns(uint256) {
        return _getCToken(token).balanceOfUnderlying(who);
    }

    function borrowAmount(IERC20 token, address who) public returns(uint256) {
        return _getCToken(token).borrowBalanceCurrent(who);
    }

    function deposit(IERC20 token, uint256 amount) public {
        ICERC20 cToken = _getCToken(token);
        if (!cToken.comptroller().checkMembership(address(this), address(cToken))) {
            _enterMarket(cToken);
        }

        if (token.isETH()) {
            // cToken.mint.value(amount)();
            // TypeError: Member "mint" not unique after argument-dependent lookup in contract ICERC20.
            (bool success,) = address(cToken).call.value(amount)(abi.encodeWithSignature("mint()"));
            require(success);
        } else {
            token.universalApprove(address(cToken), amount);
            cToken.mint(amount);
        }
    }

    function redeem(IERC20 token, uint256 amount) public {
        ICERC20 cToken = _getCToken(token);
        cToken.redeem(amount);
    }

    function redeemAll(IERC20 token) public {
        ICERC20 cToken = _getCToken(token);
        redeem(token, IERC20(cToken).universalBalanceOf(address(this)));
    }

    function borrow(IERC20 token, uint256 amount) public {
        ICERC20 cToken = _getCToken(token);
        if (!cToken.comptroller().checkMembership(address(this), address(cToken))) {
            _enterMarket(cToken);
        }

        cToken.borrow(amount);
    }

    function repay(IERC20 token, address who, uint256 amount) public {
        if (who == address(this)) {
            _repaySelf(token, amount);
        } else {
            _repayOnBehalf(token, who, amount);
        }
    }

    // Private

    function _repaySelf(IERC20 token, uint256 amount) private {
        ICERC20 cToken = _getCToken(token);
        if (token.isETH()) {
            // cToken.repayBorrow.value(amount)();
            // TypeError: Member "repayBorrow" not unique after argument-dependent lookup in contract ICERC20.
            (bool success, bytes memory res) = address(cToken).call.value(amount)(abi.encodeWithSignature("repayBorrow()"));
            require(success, string(abi.encodePacked("_repaySelf: ", res)));
        } else {
            token.universalApprove(address(cToken), amount);
            cToken.repayBorrow(amount);
        }
    }

    function _repayOnBehalf(IERC20 token, address who, uint256 amount) private {
        ICERC20 cToken = _getCToken(token);
        if (token.isETH()) {
            // cToken.repayBorrowBehalf.value(amount)();
            // TypeError: Member "repayBorrow" not unique after argument-dependent lookup in contract ICERC20.
            (bool success, bytes memory res) = address(cToken).call.value(amount)(abi.encodeWithSignature("repayBorrowBehalf()", who));
            require(success, string(abi.encodePacked("_repaySelf: ", res)));
        } else {
            token.universalApprove(address(cToken), amount);
            cToken.repayBorrowBehalf(who, amount);
        }
    }

    function _enterMarket(ICERC20 cToken) private {
        address[] memory tokens = new address[](1);
        tokens[0] = address(cToken);
        cToken.comptroller().enterMarkets(tokens);
    }
}

// File: contracts/interface/chainlink/IAggregator.sol

pragma solidity ^0.5.0;


interface IAggregator {
  function latestAnswer() external view returns(int256);
}

// File: contracts/mixins/OracleChainLink.sol

pragma solidity ^0.5.0;






contract OracleChainLink is IOracle {

    using UniversalERC20 for IERC20;

    function getPrice(IERC20 token) external view returns(uint256) {
        if (token.isETH()) {
            return 1e18;
        }

        return uint256(_getChainLinkOracleByToken(token).latestAnswer());
    }

    function _getChainLinkOracleByToken(IERC20 token) private pure returns(IAggregator) {
        if (token == IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F)) {  // DAI
            return IAggregator(0x037E8F2125bF532F3e228991e051c8A7253B642c);
        }
        if (token == IERC20(0x0D8775F648430679A709E98d2b0Cb6250d2887EF)) {  // BAT
            return IAggregator(0x9b4e2579895efa2b4765063310Dc4109a7641129);
        }
        if (token == IERC20(0x1985365e9f78359a9B6AD760e32412f4a445E862)) {  // REP
            return IAggregator(0xb8b513d9cf440C1b6f5C7142120d611C94fC220c);
        }
        if (token == IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48)) {  // USDC
            return IAggregator(0xdE54467873c3BCAA76421061036053e371721708);
        }
        if (token == IERC20(0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599)) {  // WBTC
            return IAggregator(0x0133Aa47B6197D0BA090Bf2CD96626Eb71fFd13c);
        }
        if (token == IERC20(0xE41d2489571d322189246DaFA5ebDe1F4699F498)) {  // ZRX
            return IAggregator(0xA0F9D94f060836756FFC84Db4C78d097cA8C23E8);
        }

        revert("Unsupported token");
    }
}

// File: contracts/Holder.sol

pragma solidity ^0.5.0;





//import "./mixins/OracleCompound.sol";


contract Holder is HolderBase {
    function moveIn(
        IFlashLoan flashLoaner,
        IProtocol protocol,
        IERC20 collateral,
        IERC20 debt
    ) external onlyOwner {
        address user = IERC721(owner).ownerOf(uint256(address(this)));
        uint256 borrowedAmount = _borrowAmount(protocol, debt, user);

        _flashLoan(
            flashLoaner,
            debt,
            borrowedAmount,
            abi.encodeWithSelector(
                this.moveInCallback.selector,
                collateral,
                debt,
                user,
                borrowedAmount
                // repayAmount added dynamically in executeOperation
            )
        );
    }

    function moveInCallback(
        IFlashLoan flashLoaner,
        IProtocol protocol,
        IERC20 collateral,
        IERC20 debt,
        address user,
        uint256 borrowedAmount,
        uint256 repayAmount
    ) external onlyCallback {
        _repay(protocol, debt, user, borrowedAmount);
        collateral.universalTransferFrom(user, address(this), collateral.balanceOf(user));
        _borrow(protocol, debt, repayAmount);
        _repayFlashLoan(flashLoaner, debt, repayAmount);
    }

    function migrate(
        IFlashLoan flashLoaner,
        IProtocol fromProtocol,
        IProtocol toProtocol,
        IERC20 collateral,
        IERC20 debt
    ) external onlyOwner {
        uint256 borrowedAmount = _borrowAmount(fromProtocol, debt, address(this));

        _flashLoan(
            flashLoaner,
            debt,
            borrowedAmount,
            abi.encodeWithSelector(
                this.migrateCallback.selector,
                flashLoaner,
                fromProtocol,
                toProtocol,
                collateral,
                debt,
                borrowedAmount
                // repayAmount added dynamically in executeOperation
            )
        );
    }

    function migrateCallback(
        IFlashLoan flashLoaner,
        IProtocol fromProtocol,
        IProtocol toProtocol,
        IERC20 collateral,
        IERC20 debt,
        uint256 borrowedAmount,
        uint256 repayAmount
    ) external onlyCallback {
        _repay(fromProtocol, debt, address(this), borrowedAmount);
        _redeemAll(fromProtocol, collateral);
        _deposit(toProtocol, collateral, collateral.universalBalanceOf(address(this)));
        _borrow(toProtocol, debt, repayAmount);
        _repayFlashLoan(flashLoaner, debt, repayAmount);
    }

    function convertCollateral(
        IFlashLoan flashLoaner,
        IProtocol protocol,
        IExchange exchange,
        IERC20 fromCollateral,
        IERC20 toCollateral,
        IERC20 debt,
        uint256 minReturn,
        uint256[] calldata dist,
        uint256 disableFlags
    ) external onlyOwner {
        uint256 borrowedAmount = _borrowAmount(protocol, debt, address(this));

        _flashLoan(
            flashLoaner,
            debt,
            borrowedAmount,
            abi.encodeWithSelector(
                this.convertCollateralCallback.selector,
                flashLoaner,
                protocol,
                exchange,
                fromCollateral,
                toCollateral,
                debt,
                minReturn,
                dist,
                disableFlags,
                borrowedAmount
                // repayAmount added dynamically in executeOperation
            )
        );
    }

    function convertCollateralCallback(
        IFlashLoan flashLoaner,
        IProtocol protocol,
        IExchange exchange,
        IERC20 fromCollateral,
        IERC20 toCollateral,
        IERC20 debt,
        uint256 minReturn,
        uint256[] calldata dist,
        uint256 disableFlags,
        uint256 borrowedAmount,
        uint256 repayAmount
    ) external onlyCallback {
        _repay(protocol, debt, address(this), borrowedAmount);
        _redeemAll(protocol, fromCollateral);
        _exchange(exchange, fromCollateral, toCollateral, fromCollateral.universalBalanceOf(address(this)), minReturn, dist, disableFlags);
        _deposit(protocol, toCollateral, toCollateral.universalBalanceOf(address(this)));
        _borrow(protocol, debt, repayAmount);
        _repayFlashLoan(flashLoaner, debt, repayAmount);
    }

    // function convertDebt(
    //     IFlashLoan flashLoaner,
    //     IProtocol protocol,
    //     IExchange exchange,
    //     IERC20 collateral,
    //     IERC20 fromDebt,
    //     IERC20 toDebt,
    //     uint256 minReturn,
    //     uint256[] calldata dist,
    //     uint256 disableFlags
    // ) external onlyOwner {
    //     uint256 borrowedAmount = _borrowAmount(protocol, fromDebt, address(this));

    //     _flashLoan(
    //         flashLoaner,
    //         debt,
    //         borrowedAmount,
    //         abi.encodeWithSelector(
    //             this.convertDebtCallback.selector,
    //             flashLoaner,
    //             protocol,
    //             exchange,
    //             collateral,
    //             fromDebt,
    //             toDebt,
    //             minReturn,
    //             dist,
    //             disableFlags,
    //             borrowedAmount
    //             // repayAmount added dynamically in executeOperation
    //         )
    //     );
    // }

    // function convertDebtCallback(
    //     IFlashLoan flashLoaner,
    //     IProtocol protocol,
    //     IExchange exchange,
    //     IERC20 collateral,
    //     IERC20 fromDebt,
    //     IERC20 toDebt,
    //     uint256 minReturn,
    //     uint256[] calldata dist,
    //     uint256 disableFlags,
    //     uint256 borrowedAmount,
    //     uint256 repayAmount
    // ) external onlyCallback {
    //     _repay(protocol, fromDebt, address(this), borrowedAmount);
    //     _borrow(protocol, toDebt, repayAmount);
    //     _exchange(exchange, fromDebt, toDebt, fromDebt.universalBalanceOf(address(this)), minReturn, dist, disableFlags);
    //     _repayFlashLoan(flashLoaner, fromDebt, repayAmount);
    //     // _repay(protocol, toDebt, who, amount);
    // }
}

// File: contracts/OneHop.sol

pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;









contract OneHop is
    ERC721,
    ERC721Enumerable,
    ERC721Metadata("1hop.io Collaterized Debt Position", "1HOP")
{
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    address payable private _sender;

    function _getSender() private view returns(address payable) {
        if (_sender != address(0)) {
            return _sender;
        }
        return msg.sender;
    }

    modifier onlyTokenOwner(uint256 tokenId) {
        require(_getSender() == ownerOf(tokenId), "OneHop: access denied");
        _;
    }

    //

    function multiAction(bytes[] memory data) public {
        require(_sender == address(0), "OneHop: reentrancy protection");
        _sender = msg.sender;
        for (uint i = 0; i < data.length; i++) {
            (bool success, bytes memory res) = address(this).call(data[i]);
            require(success, string(abi.encodePacked("OneHop: failed in multiAction():", res)));
        }
        _sender = address(0);
    }

    function newPosition(address delegate) public {
        Holder holder = Holder(address(new HolderProxy(delegate)));
        _mint(_getSender(), uint256(address(holder)));
    }

    function burn(uint256 tokenId) public onlyTokenOwner(tokenId) {
        Holder holder = Holder(address(tokenId));
        HolderProxy proxy = HolderProxy(address(uint160(address(holder))));
        proxy.transferOwnership(_getSender());
        _burn(tokenId);
    }

    function upgradeHolder(uint256 tokenId, address delegate) public onlyTokenOwner(tokenId) {
        Holder holder = Holder(address(tokenId));
        HolderProxy proxy = HolderProxy(address(uint160(address(holder))));
        proxy.upgradeDelegate(delegate);
    }

    function moveIn(
        IFlashLoan flashLoaner,
        IProtocol protocol,
        IERC20 collateral,
        IERC20 debt,
        uint256 tokenId
    ) public onlyTokenOwner(tokenId) {
        Holder holder = Holder(address(tokenId));
        holder.moveIn(flashLoaner, protocol, collateral, debt);
    }

    function migrate(
        IFlashLoan flashLoaner,
        IProtocol fromProtocol,
        IProtocol toProtocol,
        IERC20 collateral,
        IERC20 debt,
        uint256 tokenId
    ) public onlyTokenOwner(tokenId) {
        Holder holder = Holder(address(tokenId));
        holder.migrate(flashLoaner, fromProtocol, toProtocol, collateral, debt);
    }

    function convertCollateral(
        IFlashLoan flashLoaner,
        IProtocol protocol,
        IExchange exchange,
        IERC20 fromCollateral,
        IERC20 toCollateral,
        IERC20 debt,
        uint256 minReturn,
        uint256[] memory dist,
        uint256 disableFlags,
        uint256 tokenId
    ) public onlyTokenOwner(tokenId) {
        Holder holder = Holder(address(tokenId));
        holder.convertCollateral(
            flashLoaner,
            protocol,
            exchange,
            fromCollateral,
            toCollateral,
            debt,
            minReturn,
            dist,
            disableFlags
        );
    }

    // function convertDebt(
    //     IFlashLoan flashLoaner,
    //     IProtocol protocol,
    //     IExchange exchange,
    //     IERC20 collateral,
    //     IERC20 fromDebt,
    //     IERC20 toDebt,
    //     uint256 minReturn,
    //     uint256[] memory dist,
    //     uint256 disableFlags,
    //     uint256 tokenId
    // ) public onlyTokenOwner(tokenId) {
    //     Holder holder = Holder(address(tokenId));
    //     holder.convertDebt(
    //         flashLoaner,
    //         protocol,
    //         exchange,
    //         collateral,
    //         fromDebt,
    //         toDebt,
    //         minReturn,
    //         dist,
    //         disableFlags
    //     );
    // }
}
