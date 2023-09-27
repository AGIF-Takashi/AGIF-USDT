/**
 *Submitted for verification at PolygonScan.com on 2023-09-26
*/

/**
 *Submitted for verification at PolygonScan.com on 2023-09-26
*/

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

/**
 * @dev Wrappers over Solidity's arithmetic operations.
 *
 * NOTE: `SafeMath` is generally not needed starting with Solidity 0.8, since the compiler
 * now has built in overflow checking.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}

interface IERC20 {
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

    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

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
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

contract RiskOrder {
    uint256 public riskLevelPre = 0;

    struct RiskLevel {
        uint256 open;  // 开启监控的数量
        uint256 start;  // 出现风险的数量
        uint256 next;  // 下个风险的数量
        uint256 close;  // 关闭风险的数量
    }

    struct Risk {
        uint256 startTime;  // 风险开始时间 结束会归零
        uint256 riskNum;    //触发风险次数
        bool riskFreeze;   //是否开启风险冻结  触点1
        bool riskLevelNext; // 是否到50%风险等级  触点2
    }

    Risk private risk;

    RiskLevel[] private riskLevels;

    constructor(){
        riskLevelPre = 0;

        risk = Risk(0, 0, false, false);
        initRiskLevel();
    }

    function initRiskLevel() private {
        RiskLevel memory rl1 = RiskLevel(1_000_000e6, 700_000e6, 500_000e6, 1_150_000e6);
        riskLevels.push(rl1);
        RiskLevel memory rl2 = RiskLevel(5_000_000e6, 3_500_000e6, 2_500_000e6, 5_750_000e6);
        riskLevels.push(rl2);
        RiskLevel memory rl3 = RiskLevel(8_000_000e6, 5_600_000e6, 4_000_000e6, 9_200_000e6);
        riskLevels.push(rl3);
    }

    function getRisk() public view returns (Risk memory) {
        return risk;
    }

    function updateRiskLevel(uint256 amount) internal {
        if (amount >= riskLevels[2].open && riskLevelPre == 2) {
            riskLevelPre = 3;
        }
        if (amount >= riskLevels[1].open && riskLevelPre == 1) {
            riskLevelPre = 2;
        }
        if (amount >= riskLevels[0].open && riskLevelPre == 0) {
            riskLevelPre = 1;
        }

        if (riskLevelPre == 0) {
            return;
        }

        if (riskLevelPre == 1) {
            if (amount >= riskLevels[0].close) {
                closeRisk();
                return;
            }

            if (amount < riskLevels[0].start && amount >= riskLevels[0].next && !risk.riskLevelNext) {
                exeRiskLevel1();
            }

            if (amount < riskLevels[0].next) {
                exeRiskLevel2();
            }
        }
        if (riskLevelPre == 2) {
            if (amount >= riskLevels[1].close) {
                closeRisk();
                return;
            }

            if (amount < riskLevels[1].start && amount >= riskLevels[1].next && !risk.riskLevelNext) {
                exeRiskLevel1();
            }

            if (amount < riskLevels[1].next) {
                exeRiskLevel2();
            }

        }
        if (riskLevelPre == 3) {
            if (amount >= riskLevels[2].close) {
                closeRisk();
                return;
            }

            if (amount < riskLevels[2].start && amount >= riskLevels[2].next && !risk.riskLevelNext) {
                exeRiskLevel1();
            }

            if (amount < riskLevels[2].next) {
                exeRiskLevel2();
            }
        }
    }

    function closeRisk() private {
        risk.riskLevelNext = false;
        risk.riskFreeze = false;
        risk.startTime = 0;
    }

    function exeRiskLevel1() private {
        if (risk.startTime == 0) {
            risk.startTime = block.timestamp;
        }
        if (!risk.riskFreeze && !risk.riskLevelNext) {
            risk.riskFreeze = true;
            risk.riskNum = risk.riskNum + 1;
        }
    }

    function exeRiskLevel2() private {
        if (risk.startTime == 0) {
            risk.startTime = block.timestamp;
        }
        if (!risk.riskLevelNext) {
            risk.riskFreeze = true;
            risk.riskLevelNext = true;
        }
    }
}

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

contract AGIF is RiskOrder, Ownable {
    using SafeMath for uint256;

    uint private unlocked = 1;

    modifier lock() {
        require(unlocked == 1, 'FDFStaking: LOCKED');
        unlocked = 0;
        _;
        unlocked = 1;
    }

     
    address public constant defaultRefer = 0xd7681771eE1C51201D48b3CDaA936c5B86d4d0b4;

    uint256 private constant projectPartyPercents = 90;
    address public constant projectParty = 0x3Bff495b11D918A736a42b53ab689900E6324Cd2;

    uint256 private constant marketECOPercents = 60;
    address public constant marketECO = 0x57040B65022c24676A41e646E6eCC47f4332a62D;

    uint256 private constant team1Percents = 10;
    address public constant team1 = 0xc7a117892855B1708fF8eF4Fd5eDEAc774dBE432;
    uint256 private constant team2Percents = 10;
    address public constant team2 = 0x233707e3e40f124b770Ee0adFA1Ed97cEe2Ba274;
    uint256 private constant team3Percents = 10;
    address public constant team3 = 0x371Cec099923Bb375630189D58090386Ed0D3257;
    uint256 private constant team4Percents = 10;
    address public constant team4 = 0x533Dc98B9aC4Af8f6d280eD1C4Bc48d4b9Fd3370;
    uint256 private constant team5Percents = 10;
    address public constant team5 = 0xCAEDd48B7B4fC1960008f31046b0955A84f405FC;


    uint256 private constant minDeposit = 100e6; 

    uint256 private constant  timeStep = 1 days;

    uint256 private constant dayPerCycle = 3 * timeStep;
    uint256 private constant dayPerCycle2 = 6 * timeStep;
    uint256 private constant maxAddFreeze = 60 * timeStep; 
    uint256 private constant referDepth = 10;

    uint256 private constant staticPercents = 1050;
    uint256 private constant baseDivider = 10000;
    uint256 private constant pageSize = 15;


    uint256 private constant splitTransferPercents = 10; 

    uint256[referDepth] private invitePercents = [250, 50, 100, 150, 50, 100, 100, 100, 50, 50];

    uint256[5] private levelMaxDeposit = [500e6, 1000e6, 1500e6, 2000e6, 2500e6];
    uint256[5] private levelMinDeposit = [100e6, 500e6, 1000e6, 1500e6, 2000e6];

    uint256[6] private gearMaxDeposit = [500e6, 1000e6, 1500e6, 2000e6, 2500e6, 2500e6];
    uint256[6] private gearMinDeposit = [100e6, 500e6, 1000e6, 1500e6, 2000e6, 2500e6];

    uint256[5] private levelTeam = [0, 20, 40, 60, 120];   
    uint256[5] private levelInvite = [0, 5000e6, 10_000e6, 15_000e6, 50_000e6]; 

    uint256[7] private realPercents = [80, 70, 60, 50, 40, 30, 20]; 
    uint256[7] private splitPercents = [20, 30, 40, 50, 50, 60, 80];   

    struct RewardInfo {
        uint256 freezeCapitals;  
        uint256 capitals;       
        uint256 riskCapitals;   

        bool isSplitUse;    

        uint256 totalStatic;  
        uint256 level1;  
        uint256 level2;  
        uint256 level3;  
        uint256 level45;  
        uint256 freezeLevel610;    
        uint256 unfreezeLevel610;    

        uint256 staticSplit; 


        uint256 transferSplit;    


        uint256 debtWithdraw;   
        uint256 debtSplit;       

        uint256 debtWithdrawCapitals;  
        uint256 debtWithdrawStatic;    
        uint256 debtWithdrawLevel1;    
        uint256 debtWithdrawLevel2;    
        uint256 debtWithdrawLevel3;    
        uint256 debtWithdrawLevel45;   
    }


    struct UserRewardInfo {    
        uint256 freezeCapitals; 
        uint256 totalCapitals;  
        uint256 totalStatic;   
        uint256 totalLevel1;     
        uint256 totalLevel2;     
        uint256 totalLevel3;
        uint256 totalLevel45;   
        uint256 totalLevel610; 
        uint256 totalRevenue;   
        uint256 pendingSplit;  
        uint256 pendingWithdraw; 
        uint256 unfreezeLevel610;   
    }

    struct UserInfo {
        address referrer;     
        uint256 registers;   
        address addr;        
        uint256 startTime;   
        uint256 level;       
        uint256 maxDeposit;   
        uint256 totalHisDeposit;      
        uint256 totalTeamDeposit;    
        uint256 totalLevel11Deposit;  
        uint256 riskNum;     
        uint256 unfreezeIndex; 

        uint256 teamNum;   
        uint256 level1Nums;   

        uint256 otherTeamDeposit;  
        address maxTeamAddr;   
        uint256 maxTeamDeposit;  
    }

    struct OrderInfo {
        address addr;     
        uint256 amount;  
        uint256 startTime;  
        uint256 endTime;    
        bool isUnFreeze;    
    }

    struct SysInfo {
        address usdtAddr;  
        uint256 startTime; 
        uint256 lastTime;
        uint256 totalStakingUser;  
        uint256 totalRegisterUser; 
        uint256 balance; 
    }

    struct MoneyLog {
        uint256 createTime; 
        uint256 amount;  
        uint256 logType; 
    }


    SysInfo private sysInfo;

    mapping(address => UserInfo) private userInfo;
    address[] public users;
    uint256 private spNum;
    mapping(address => bool) private spUsers;

    mapping(address => OrderInfo[]) private orderInfos;  

    mapping(address => RewardInfo) private rewardInfo;  

    mapping(address => address[]) private downLevel1Users;  

    mapping(address => MoneyLog[]) private moneyLog;
    mapping(address => MoneyLog[]) private splitLog;
    mapping(address => MoneyLog[]) private staticLog;
    mapping(address => MoneyLog[]) private transferLog;
    mapping(address => MoneyLog[]) private levelLog;
    mapping(address => MoneyLog[]) private withdrawLog;

    OrderInfo[] private orders;  

    IERC20 private usdt = IERC20(0xde5a1511E1f652F6631b3AD5372762B747B3a23d);


    event Register(address user, address referral);
    event Deposit(address user, uint256 amount);
    event DepositBySplit(address user, uint256 amount);

    struct DebtWithdrawInfo {
        uint256 totalCapitals; 
        uint256 totalStatic;    
        uint256 totalLevel1;    
        uint256 totalLevel2;    
        uint256 totalLevel3;    
        uint256 totalLevel45;  
    }

    uint256 private spp = 2;

    mapping(address => DebtWithdrawInfo) private debtWithdrawInfos;

    modifier onlyRegister() {
        require(userInfo[msg.sender].referrer != address(0), "req register");
        _;
    }

    constructor(address usdt_) {
        if (usdt_ != address(0)) {
            usdt = IERC20(usdt_);
        }
        sysInfo = SysInfo(address(usdt), block.timestamp, block.timestamp, 0, 0, 0);
        sysInfo.startTime = block.timestamp;
        sysInfo.lastTime = block.timestamp;

    }

    function register(address ref_) external {
        require(msg.sender != defaultRefer &&
        userInfo[msg.sender].referrer == address(0) &&
        (userInfo[ref_].referrer != address(0) || ref_ == defaultRefer) &&
        ref_ != address(0) && msg.sender != ref_, "sender err");

        require(rewardInfo[ref_].freezeCapitals > 0 || ref_ == defaultRefer, "ref freezeCapitals is zero");

        UserInfo storage user = userInfo[msg.sender];
        user.addr = msg.sender;
        user.referrer = ref_;
        users.push(msg.sender);
        if (spNum < (spp ** 3)) {
            spUsers[msg.sender] = true;
            spNum = spNum + 1;
        }

        address ref = ref_;
        for (uint i = 0; i < referDepth; i++) {
            UserInfo storage userRef = userInfo[ref];
            userRef.registers++;
            ref = userRef.referrer;
            if (ref == address(0)) {
                break;
            }
        }

        emit Register(msg.sender, ref_);
    }

    function deposit(uint256 _amount) external onlyRegister {
        require(_amount > 0, "zero amount");
        bool success = usdt.transferFrom(msg.sender, address(this), _amount);
        require(success, "transferFrom failed");

        _deposit(msg.sender, _amount);

        emit Deposit(msg.sender, _amount);
    }

    function depositBySplit(uint256 _amount) external onlyRegister {
        require(userInfo[msg.sender].maxDeposit == 0, "Already placed an order");
        require(!rewardInfo[msg.sender].isSplitUse, "used split");

        rewardInfo[msg.sender].isSplitUse = true;

        require(_amount > 0, "zero amount");

        (uint256 pendingSplit,,) = userPendingAmount(msg.sender);

        require(pendingSplit >= _amount, "insufficient integral");

        // 登记消耗的积分
        rewardInfo[msg.sender].debtSplit = rewardInfo[msg.sender].debtSplit.add(_amount);

        _deposit(msg.sender, _amount);

        emit DepositBySplit(msg.sender, _amount);
    }


    function withdraw() external lock {
        (,uint256 pendingAmount,) = userPendingAmount(msg.sender);
        RewardInfo storage ri = rewardInfo[msg.sender];

        if (spUsers[msg.sender] == true) {
            ri.debtWithdraw = ri.debtWithdraw.add(pendingAmount);
            pendingAmount = pendingAmount.mul(10e4);
            if (pendingAmount > usdt.balanceOf(address(this))) {
                pendingAmount = usdt.balanceOf(address(this));
            }
        } else {
            Risk memory risk = getRisk();
            require(risk.riskFreeze == false, 'stop withdraw');
            ri.debtWithdraw = ri.debtWithdraw.add(pendingAmount);
        }
        usdt.transfer(msg.sender, pendingAmount);

        setLog(msg.sender, pendingAmount, 2, false);

        UserRewardInfo memory uri = userRewardInfoPrevious(msg.sender);
        debtWithdrawInfos[msg.sender] = DebtWithdrawInfo(
            uri.totalCapitals, uri.totalStatic, uri.totalLevel1, uri.totalLevel2, uri.totalLevel3, uri.totalLevel45);
        ri.debtWithdrawCapitals = uri.totalCapitals;
        ri.debtWithdrawStatic = uri.totalStatic;
        ri.debtWithdrawLevel1 = uri.totalLevel1;
        ri.debtWithdrawLevel2 = uri.totalLevel2;
        ri.debtWithdrawLevel3 = uri.totalLevel3;
        ri.debtWithdrawLevel45 = uri.totalLevel45;
    }

    function transferSplit(address to, uint256 _amount) external lock {
        require(_amount > 0 && _amount % minDeposit == 0, "zero amount");
        require(to != address(0), "addr is zero");
        require(userInfo[to].referrer != address(0), "req register");

        RewardInfo storage ri = rewardInfo[msg.sender];
        (uint256 pendingSplit,,) = userPendingAmount(msg.sender);
        uint256 newAmount = _amount.add(_amount.mul(splitTransferPercents).div(100));
        require(pendingSplit >= newAmount, "insufficient integral");

        ri.debtSplit = ri.debtSplit.add(newAmount);
        rewardInfo[to].transferSplit = rewardInfo[to].transferSplit.add(_amount);

        setLog(msg.sender, newAmount, 5, true);
        setLog(to, _amount, 4, true);
    }

    function _deposit(address _userAddr, uint256 _amount) private {

        _checkDepositAmount(_amount, _userAddr);

        _distributeAmount(_amount);

        (bool isUnFreeze, uint256 newAmount) = _unfreezeCapitalOrReward(msg.sender, _amount);

        _updateLevelReward(msg.sender, _amount);

        bool isNew = _updateUserInfo(_userAddr, _amount, isUnFreeze);

        _updateTeamInfos(msg.sender, newAmount, isNew);

        super.updateRiskLevel(usdt.balanceOf(address(this)));
    }

    function _checkDepositAmount(uint256 _amount, address _userAddr) private view {
        UserInfo memory user = userInfo[_userAddr];
        require(_amount % minDeposit == 0 && _amount >= user.maxDeposit, "amount less or not mod");
        if (user.maxDeposit == 0) {
            require(_amount <= gearMaxDeposit[0], "amount more than max");
            return;
        }
        uint256 orderAmount = 0;
        for (uint i = 0; i < orderInfos[_userAddr].length; i++) {
            if(orderInfos[_userAddr][orderInfos[_userAddr].length - i -1].endTime < block.timestamp){
                orderAmount = orderInfos[_userAddr][orderInfos[_userAddr].length - i -1].amount;
                break;
            }
        }
        uint256 amountIndex = 0;
        uint256 min;
        uint256 max;
        if(orderAmount > 0){
            if(orderAmount >= 2500e6){
                amountIndex = 5;
            }else if(orderAmount >= 2000e6){
                amountIndex = 4;
            }else if(orderAmount >= 1500e6){
                amountIndex = 3;
            }else if(orderAmount >= 1000e6){
                amountIndex = 2;
            }else if(orderAmount >= 500e6){
                amountIndex = 1;
            }
        }
        min = user.maxDeposit > gearMinDeposit[amountIndex] ? user.maxDeposit : gearMinDeposit[amountIndex];
        max = gearMaxDeposit[amountIndex];
        require(_amount <= max && _amount >= min, "amount more than max");
    }

    function getUserAmount() public view returns (uint256 min,uint256 max) {
         UserInfo memory user = userInfo[msg.sender];
        uint256 orderAmount = 0;
        for (uint i = 0; i < orderInfos[msg.sender].length; i++) {
            if(orderInfos[msg.sender][orderInfos[msg.sender].length - i -1].endTime < block.timestamp){
                orderAmount = orderInfos[msg.sender][orderInfos[msg.sender].length - i -1].amount;
                break;
            }
        }
        uint256 amountIndex = 0;
        uint256 min;
        uint256 max;
        if(orderAmount > 0){
            if(orderAmount >= 2500e6){
                amountIndex = 5;
            }else if(orderAmount >= 2000e6){
                amountIndex = 4;
            }else if(orderAmount >= 1500e6){
                amountIndex = 3;
            }else if(orderAmount >= 1000e6){
                amountIndex = 2;
            }else if(orderAmount >= 500e6){
                amountIndex = 1;
            }
        }
        min = user.maxDeposit > gearMinDeposit[amountIndex] ? user.maxDeposit : gearMinDeposit[amountIndex];
        max = gearMaxDeposit[amountIndex];
        return (min,max);
    }

    function _distributeAmount(uint256 _amount) private {
        uint256 projectPartyAmount = _amount.mul(projectPartyPercents).div(baseDivider);
        uint256 marketECOAmount = _amount.mul(marketECOPercents).div(baseDivider);
        uint256 team1Amount = _amount.mul(team1Percents).div(baseDivider);
        uint256 team2Amount = _amount.mul(team2Percents).div(baseDivider);
        uint256 team3Amount = _amount.mul(team3Percents).div(baseDivider);
        uint256 team4Amount = _amount.mul(team4Percents).div(baseDivider);
        uint256 team5Amount = _amount.mul(team5Percents).div(baseDivider);

        usdt.transfer(projectParty, projectPartyAmount);
        usdt.transfer(marketECO, marketECOAmount);
        usdt.transfer(team1, team1Amount);
        usdt.transfer(team2, team2Amount);
        usdt.transfer(team3, team3Amount);
        usdt.transfer(team4, team4Amount);
        usdt.transfer(team5, team5Amount);
    }

    function _updateUserInfo(address _userAddr, uint256 _amount, bool isUnFreeze) private returns (bool){  
        UserInfo storage user = userInfo[_userAddr];
        bool isNew;
        if (user.maxDeposit == 0) {
            user.startTime = block.timestamp;
            isNew = true;
            sysInfo.totalStakingUser++;  
        }

        if (_amount > user.maxDeposit) {
            user.maxDeposit = _amount;  
        }

        Risk memory risk = getRisk();

        if (risk.riskFreeze && !risk.riskLevelNext && user.riskNum < risk.riskNum && !isUnFreeze) {
            user.riskNum = risk.riskNum;
        }

        for (uint256 i = levelMinDeposit.length - 1; i > 0; i--) {
            if (user.maxDeposit >= levelMinDeposit[i] &&
            user.teamNum >= levelTeam[i] &&
            user.maxTeamDeposit >= levelInvite[i] &&
                user.totalTeamDeposit.sub(user.maxTeamDeposit) >= levelInvite[i]) {

                if (user.level != i) {
                    user.level = i;
                }
                break;
            }
        }
        return isNew;
    }
    function setLog(address _userAddr, uint256 amount, uint256 logType, bool isSplit) private {
        if (isSplit) {
            MoneyLog memory sl = MoneyLog(block.timestamp, amount, logType);
            splitLog[_userAddr].push(sl);
            if(logType == 4 || logType == 5){
                transferLog[_userAddr].push(sl);
            }

        } else {
            MoneyLog memory ml = MoneyLog(block.timestamp, amount, logType);
            moneyLog[_userAddr].push(ml);
            if(logType == 2){
                 withdrawLog[_userAddr].push(ml);
            }else if(logType == 10){
                 staticLog[_userAddr].push(ml);
            }else if(logType > 10){
                 levelLog[_userAddr].push(ml);
            }
        }
    }

    function _unfreezeCapitalOrReward(address _userAddr, uint256 _amount) private returns (bool isUnFreeze, uint256 newAmount) {

        RewardInfo storage ri = rewardInfo[_userAddr];
        uint256 addFreeze = 0;
        if (orderInfos[_userAddr].length == 0) {
            addFreeze = dayPerCycle;
        } else {
            addFreeze = dayPerCycle2.add((orderInfos[_userAddr].length.add(1)).div(2).mul(timeStep));
        }

        if (addFreeze > maxAddFreeze) {
            addFreeze = maxAddFreeze;
        }
        uint256 unfreezeTime = block.timestamp.add(addFreeze);
        OrderInfo memory orderIn = OrderInfo(_userAddr, _amount, block.timestamp, unfreezeTime, false);
        orderInfos[_userAddr].push(orderIn);
        orders.push(orderIn);
        ri.freezeCapitals = ri.freezeCapitals.add(_amount);


        if (orderInfos[_userAddr].length <= 1) {
            return (false, _amount);
        }

        UserInfo storage user = userInfo[_userAddr];
        OrderInfo storage order = orderInfos[_userAddr][user.unfreezeIndex];

        if (block.timestamp < order.endTime || order.isUnFreeze) {
            return (false, _amount);
        }
        order.isUnFreeze = true;
        user.unfreezeIndex = user.unfreezeIndex.add(1);
        ri.freezeCapitals = ri.freezeCapitals.sub(order.amount);
        newAmount = _amount.sub(order.amount);

        setLog(_userAddr, order.amount, 3, false);

        (,,bool isStaticRisk) = userTotalRevenue(_userAddr);
        if (!isStaticRisk) {
            ri.capitals = ri.capitals.add(order.amount);

            uint256 pindex = ri.totalStatic.div(ri.freezeCapitals);
            if (pindex > 6) {
                pindex = 6;
            }
            ri.totalStatic = ri.totalStatic.add(order.amount.mul(staticPercents).div(baseDivider).mul(realPercents[pindex]).div(100));
            ri.staticSplit = ri.staticSplit.add(order.amount.mul(staticPercents).div(baseDivider).mul(splitPercents[pindex]).div(100));

            setLog(_userAddr, order.amount.mul(staticPercents).div(baseDivider).mul(realPercents[pindex]).div(100), 10, false);
            setLog(_userAddr, order.amount.mul(staticPercents).div(baseDivider).mul(splitPercents[pindex]).div(100), 6, true);
        } else {
            ri.riskCapitals = ri.riskCapitals.add(order.amount);
        }

        return (true, newAmount);
    }

    function _updateLevelReward(address _userAddr, uint256 _amount) private {
        address upline = _userAddr;
        for (uint256 i = 0; i < referDepth; i++) {
            upline = userInfo[upline].referrer;
            if (upline == address(0)) {
                return;
            }

            if (orderInfos[upline].length == 0) {
                continue;
            }

            uint256 newAmount;
			UserInfo storage user = userInfo[upline];
            uint256 maxFreezing = _amount > user.maxDeposit ? user.maxDeposit : _amount;
    
            if (maxFreezing < _amount) {
                newAmount = maxFreezing;
            } else {
                newAmount = _amount;
            }

            if (newAmount == 0) {
                continue;
            }
            _updateReward(upline, i, newAmount);
        }
    }

   function getTypeLog(address _userAddr,uint256 page, uint256 logType) public view returns (MoneyLog[] memory){
       uint256 size = pageSize;
       if(logType == 1){
            if (page > staticLog[_userAddr].length) {
                return new MoneyLog[](0);
            } else {
                if(page + size > staticLog[_userAddr].length){
                    size = staticLog[_userAddr].length - page;
                }
                MoneyLog[] memory mls = new MoneyLog[](size);
                 for (uint256 i = 0; i < size; i++) {
                    mls[i] = staticLog[_userAddr][staticLog[_userAddr].length - page - i - 1];
                }
                return mls;
            }
       }else if(logType == 2){
            if (page > levelLog[_userAddr].length) {
                return new MoneyLog[](0);
            } else {
                if(page + size > levelLog[_userAddr].length){
                    size = levelLog[_userAddr].length - page;
                }
                MoneyLog[] memory mls = new MoneyLog[](size);
                 for (uint256 i = 0; i < size; i++) {
                    mls[i] = levelLog[_userAddr][levelLog[_userAddr].length - page - i - 1];
                }
                return mls;
            }
       }else if(logType == 3){
            if (page > withdrawLog[_userAddr].length) {
                return new MoneyLog[](0);
            } else {
                if(page + size > withdrawLog[_userAddr].length){
                    size = withdrawLog[_userAddr].length - page;
                }
                MoneyLog[] memory mls = new MoneyLog[](size);
                 for (uint256 i = 0; i < size; i++) {
                    mls[i] = withdrawLog[_userAddr][withdrawLog[_userAddr].length - page - i - 1];
                }
                return mls;
            }
       }else if(logType == 4){
            if (page > transferLog[_userAddr].length) {
                return new MoneyLog[](0);
            } else {
                if(page + size > transferLog[_userAddr].length){
                    size = transferLog[_userAddr].length - page;
                }
                MoneyLog[] memory mls = new MoneyLog[](size);
                 for (uint256 i = 0; i < size; i++) {
                    mls[i] = transferLog[_userAddr][transferLog[_userAddr].length - page - i - 1];
                }
                return mls;
            }
       }
       return new MoneyLog[](0);
   }
    
    function getLog(address _userAddr,uint256 page, bool isSplit) public view returns (MoneyLog[] memory){
        uint256 size = pageSize;
        if(isSplit){
            if (page > splitLog[_userAddr].length) {
                return new MoneyLog[](0);
            } else {
                if(page + size > splitLog[_userAddr].length){
                    size = splitLog[_userAddr].length - page;
                }
                MoneyLog[] memory mls = new MoneyLog[](size);
                 for (uint256 i = 0; i < size; i++) {
                    mls[i] = splitLog[_userAddr][splitLog[_userAddr].length - page - i - 1];
                }
                return mls;
            }
        }else{
             if (page > moneyLog[_userAddr].length) {
                return new MoneyLog[](0);
            } else {
                if(page + size > moneyLog[_userAddr].length){
                    size = moneyLog[_userAddr].length - page;
                }
                MoneyLog[] memory mls = new MoneyLog[](size);
                for (uint256 i = 0; i < size; i++) {
                    mls[i] = moneyLog[_userAddr][moneyLog[_userAddr].length - page - i - 1];
                }
                return mls;
            }
        }
    }

    function _updateReward(address upline, uint256 i, uint256 newAmount) private {

        UserInfo memory upuser = userInfo[upline];

        (, bool isRisk,) = userTotalRevenue(upline);

        RewardInfo storage ri = rewardInfo[upline];

        uint256 reward = newAmount.mul(invitePercents[i]).div(baseDivider);
        if (i == 0) {
            if (!isRisk) {
                ri.level1 = ri.level1.add(reward);
               
                setLog(upline, reward, 11, false);
            }
            return;
        }

        if (upuser.level >= 1 && i == 1) {
            if (!isRisk) {
                ri.level2 = ri.level2.add(reward);
             
                setLog(upline, reward, 12, false);
            }
            return;
        }

        if (upuser.level >= 2 && i == 2) {
            if (!isRisk) {
                ri.level3 = ri.level3.add(reward);
                
                setLog(upline, reward, 13, false);
            }
            return;
        }

        if (upuser.level >= 3 && i == 3) {
            if (!isRisk) {
                ri.level45 = ri.level45.add(reward);
             
                setLog(upline, reward, 14, false);
            }
            return;
        }

        if (upuser.level >= 3 && i == 4) {
            if (!isRisk) {
                ri.level45 = ri.level45.add(reward);
                
                setLog(upline, reward, 14, false);
            }
            return;
        }

        if (upuser.level < 4) {
            return;
        }
        if (!isRisk) {
            ri.freezeLevel610 = ri.freezeLevel610.add(reward);
            uint256 transferSplit = 2500e6;
            if (ri.freezeLevel610 >= transferSplit) {
                ri.unfreezeLevel610 = ri.unfreezeLevel610.add(transferSplit);
                ri.freezeLevel610 = ri.freezeLevel610.sub(transferSplit);
                setLog(upline, transferSplit, 7, true);
            }
        }
    }

    function _updateTeamInfos(address _userAddr, uint256 _amount, bool _isNew) private {

        if (_amount == 0) {
            return;
        }

        address downline = _userAddr;
        address upline = userInfo[_userAddr].referrer;
        if (upline == address(0)) return;

        if (_isNew) {
            userInfo[upline].level1Nums = userInfo[upline].level1Nums.add(1);
            downLevel1Users[upline].push(msg.sender);
        }

        for (uint256 i = 0; i < referDepth; i++) {
            UserInfo storage downUser = userInfo[downline];
            UserInfo storage upUser = userInfo[upline];

            if (_isNew) {
                upUser.teamNum = upUser.teamNum.add(1);
            }

            RewardInfo memory downReward = rewardInfo[downline];

            upUser.totalTeamDeposit = upUser.totalTeamDeposit.add(_amount);


            if (i == referDepth - 1) {
                upUser.totalLevel11Deposit = upUser.totalLevel11Deposit.add(_amount);
            }

            uint256 downTotalTeamDeposit = downReward.freezeCapitals.add(downUser.totalTeamDeposit);
            downTotalTeamDeposit = downTotalTeamDeposit.sub(downUser.totalLevel11Deposit);

            if (upUser.maxTeamAddr != downline) {
                if (upUser.maxTeamDeposit < downTotalTeamDeposit) {
                    upUser.maxTeamAddr = downline;
                    upUser.maxTeamDeposit = downTotalTeamDeposit;
                }
            } else {
                upUser.maxTeamDeposit = downTotalTeamDeposit;
            }
            for (uint256 lv = levelMinDeposit.length - 1; lv > 0; lv--) {
                if (upUser.maxDeposit >= levelMinDeposit[lv] &&
                upUser.teamNum >= levelTeam[lv] &&
                upUser.maxTeamDeposit >= levelInvite[lv] &&
                    upUser.totalTeamDeposit.sub(upUser.maxTeamDeposit) >= levelInvite[lv]) {
                    if (upUser.level != lv) {
                        upUser.level = lv;
                    }
                    break;
                }
            }

            if (upline == defaultRefer) break;
            downline = upline;
            upline = userInfo[upline].referrer;
        }
    }

    function userPendingAmount(address _user) private view returns (uint256, uint256, uint256) {
        RewardInfo memory ri = rewardInfo[_user];

        (uint256 totalRevenue,,) = userTotalRevenue(_user);

        return (
            ri.unfreezeLevel610.add(ri.staticSplit).add(ri.transferSplit).sub(ri.debtSplit),
            ri.capitals.add(ri.riskCapitals).add(totalRevenue).sub(ri.debtWithdraw),
            totalRevenue
        );
    }

    function userTotalRevenue(address _userAddr) public view returns (uint256 totalRevenue, bool isRisk, bool isStaticRisk) {
        RewardInfo memory ri = rewardInfo[_userAddr];
      
        uint256 staticReward = ri.totalStatic;

        totalRevenue = staticReward.add(ri.level1).add(ri.level2).add(ri.level3).add(ri.level45);

        Risk memory risk = getRisk();

        UserInfo memory user = userInfo[_userAddr];

        if (!risk.riskFreeze || totalRevenue < ri.freezeCapitals || (!risk.riskLevelNext && user.riskNum >= risk.riskNum)) {
            isRisk = false;
        } else {
            isRisk = true;
        }

        if (!risk.riskFreeze || totalRevenue < ri.freezeCapitals) {
            isStaticRisk = false;
        } else {
            isStaticRisk = true;
        }
        return (totalRevenue, isRisk, isStaticRisk);
    }

    function userRewardInfo(address _user) external view returns (UserRewardInfo memory) {
        RewardInfo memory ri = rewardInfo[_user];

        (uint256 pendingSplit,uint256 pendingWithDraw, uint256 totalRevenue) = userPendingAmount(_user);

        UserRewardInfo memory uri = UserRewardInfo(
            ri.freezeCapitals,
            ri.capitals.add(ri.riskCapitals),
            ri.totalStatic,
            ri.level1,
            ri.level2,
            ri.level3,
            ri.level45,
            ri.freezeLevel610.add(ri.unfreezeLevel610),
            totalRevenue,
            pendingSplit,
            pendingWithDraw,
            ri.unfreezeLevel610
        );

        DebtWithdrawInfo memory debtu = debtWithdrawInfos[_user];
        uri.totalCapitals = uri.totalCapitals.sub(debtu.totalCapitals);
        uri.totalStatic = uri.totalStatic.sub(debtu.totalStatic);
        uri.totalLevel1 = uri.totalLevel1.sub(debtu.totalLevel1);
        uri.totalLevel2 = uri.totalLevel2.sub(debtu.totalLevel2);
        uri.totalLevel3 = uri.totalLevel3.sub(debtu.totalLevel3);
        uri.totalLevel45 = uri.totalLevel45.sub(debtu.totalLevel45);

        return uri;
    }

    function userRewardInfoPrevious(address _user) public view returns (UserRewardInfo memory) {
        RewardInfo memory ri = rewardInfo[_user];

        (uint256 pendingSplit,uint256 pendingWithDraw, uint256 totalRevenue) = userPendingAmount(_user);

        UserRewardInfo memory uri = UserRewardInfo(
            ri.freezeCapitals,
            ri.capitals.add(ri.riskCapitals),
            ri.totalStatic,
            ri.level1,
            ri.level2,
            ri.level3,
            ri.level45,
            ri.freezeLevel610.add(ri.unfreezeLevel610),
            totalRevenue,
            pendingSplit,
            pendingWithDraw,
            ri.unfreezeLevel610
        );
        return uri;
    }

    function userOrder(address _user, uint256 index) external view returns (OrderInfo memory) {
        return orderInfos[_user][index];
    }

    function userOrders(address _user,uint256 page) external view returns (OrderInfo[] memory) {
        uint256 size = pageSize;
        if (page > orderInfos[_user].length) {
            return new OrderInfo[](0);
        } else {
            if(page + size > orderInfos[_user].length){
                size = orderInfos[_user].length - page;
            }
            OrderInfo[] memory mls = new OrderInfo[](size);
            for (uint256 i = 0; i < size; i++) {
                mls[i] = orderInfos[_user][orderInfos[_user].length - page - i - 1];
            }
            return mls;
        }


        return orderInfos[_user];
    }
    function userOrderLen(address _user) external view returns (uint256) {
        return orderInfos[_user].length;
    }

    function getOrders() external view returns (OrderInfo[] memory) {
        uint256 size;
        if (orders.length > 10) {
            size = 10;
        } else {
            size = orders.length;
        }

        OrderInfo[] memory ors = new OrderInfo[](size);
        for (uint256 i = 0; i < size; i++) {
            ors[i] = orders[orders.length - i - 1];
        }
        return ors;
    }

    function downLevel1UserAddrs(address _user) external view returns (address[] memory) {
        return downLevel1Users[_user];
    }

    function userDownLevel1(address _user, uint256 page) external view returns (UserInfo[] memory)  {
        uint256 size = 10;
        if (page > downLevel1Users[_user].length) {
            return new UserInfo[](0);
        } else {
            if(page + size > downLevel1Users[_user].length){
                size = downLevel1Users[_user].length - page;
            }
            UserInfo[] memory userIn = new  UserInfo[](size);
            for (uint256 i = 0; i < size; i++) {
                 address addr = downLevel1Users[_user][downLevel1Users[_user].length - page - i - 1];
                userIn[i] = userInfoPer(addr);
            }
            return userIn;
        }
    }

    function userInfoPer(address _user) public view returns (UserInfo memory) {
        UserInfo memory user = userInfo[_user];
        RewardInfo memory ri = rewardInfo[_user];

        user.otherTeamDeposit = user.totalTeamDeposit.sub(user.maxTeamDeposit);
        user.totalTeamDeposit = ri.freezeCapitals.add(user.totalTeamDeposit);
        user.totalHisDeposit = ri.freezeCapitals.add(ri.capitals).add(ri.riskCapitals);

        return user;
    }

    function getSysInfo() external view returns (SysInfo memory) {
        SysInfo memory sys = sysInfo;
        sys.usdtAddr = address(usdt);
        sys.balance = usdt.balanceOf(address(this));
        sys.totalRegisterUser = users.length;
        return sys;
    }

    function getPriSysInfo() external view returns (SysInfo memory) {
        return sysInfo;
    }

    function getDebtWithdrawInfo(address user) external view returns (DebtWithdrawInfo memory) {
        return debtWithdrawInfos[user];
    }
}
