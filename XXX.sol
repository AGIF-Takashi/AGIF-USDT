// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;


import "openzeppelin-contracts/contracts/utils/math/SafeMath.sol";
import "openzeppelin-contracts/contracts/interfaces/IERC20.sol";
import "./RiskOrder.sol";

contract ADI is RiskOrder{
    using SafeMath for uint256;

    uint private unlocked = 1;

    modifier lock() {
        require(unlocked == 1, 'FDFStaking: LOCKED');
        unlocked = 0;
        _;
        unlocked = 1;
    }

    address public constant defaultRefer = 0x880075B511b0e88D354c197f1f8C1FF44B9C089F;

    uint256 private constant sysDevPercents = 70;
    address public constant sysDev = 0xdB72168d4a200b5aFe04Cf10eBf47Ee93cd08555;

    uint256 private constant insurancePercents = 30;
    address public constant insurance = 0x408416B87Cd4e83BA1Bda5f6f2B4139E43202e6f;

    uint256 private constant foundationPercents = 100;
    address public constant foundation = 0xbd888488df0712491810235F4e8648c8a5EC8608;

    uint256 private constant marketECOPercents = 100;
    address public constant marketECO = 0xe2433b048beB2B078b05e47897dd1314Ff0dd801;

    uint256 private constant minDeposit = 100e6; //usdt

    uint256 private constant timeStep = 1 days;
    uint256 private constant dayPerCycle = 15 * timeStep;
    uint256 private constant maxAddFreeze = 45 * timeStep + dayPerCycle;
    uint256 private constant referDepth = 10;

    uint256 private constant staticPercents = 2250;
    uint256 private constant baseDivider = 10000;

    uint256 private constant realPercents = 70; // / 100
    uint256 private constant splitPercents = 30; // / 100

    uint256 private constant splitTransferPercents = 10; // / 100

    uint256[referDepth] private invitePercents = [500, 100, 200, 300, 100, 200, 200, 200, 100, 100];

    uint256[5] private levelMaxDeposit = [500e6,1000e6,1500e6,2000e6,2500e6];
    uint256[5] private levelMinDeposit = [100e6,500e6,1000e6,1500e6,2500e6];

    uint256[5] private levelTeam = [0, 20, 40, 60, 120];
    uint256[5] private levelInvite = [0, 5000e6, 10_000e6, 15_000e6, 50_000e6];

    struct RewardInfo {
        uint256 freezeCapitals;
        uint256 capitals;
        uint256 riskCapitals;
        bool    isSplitUse;

        uint256 level1;
        uint256 level25;

        uint256 unfreezeLevel610;
        uint256 freezeTotalLevel610;

        uint256 transferSplit;

        uint256 debtWithdraw;
        uint256 debtSplit;
    }


    struct UserRewardInfo {
        uint256 freezeCapitals;
        uint256 totalCapitals;
        uint256 totalStatic;
        uint256 totalLevel1;
        uint256 totalLevel25;
        uint256 totalLevel610;
        uint256 totalFreeze;
        uint256 freezeSplit;
        uint256 totalRevenue;
        uint256 pendingSplit;
        uint256 pendingWithdraw;
    }

    struct UserInfo {
        address referrer;
        uint256 registers;
        address addr;
        uint256 startTime;
        uint256 level;
        uint256 maxDeposit;
        uint256 maxNextDeposit;
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

    struct SysInfo{
        address  usdtAddr;
        uint256  startTime;
        uint256  lastTime;
        uint256  totalStakingUser;
        uint256  totalRegisterUser;
        uint256  balance;
    }

    SysInfo private sysInfo;

    mapping(address => UserInfo) private userInfo;
    address[] public users;

    mapping(address=> OrderInfo[]) private orderInfos;

    mapping(address => RewardInfo) private rewardInfo;

    mapping(address => address[]) private downLevel1Users;

    OrderInfo[] private orders;

    // 手续费扣除账户
    IERC20 private usdt = IERC20(0xc2132D05D31c914a87C6611C10748AEb04B58e8F);

    event Register(address user, address referral);
    event Deposit(address user, uint256 amount);
    event DepositBySplit(address user, uint256 amount);

    struct DebtWithdrawInfo {
        uint256 totalCapitals;
        uint256 totalStatic;
        uint256 totalLevel1;
        uint256 totalLevel25;
        uint256 totalLevel610;
    }

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

    function register(address ref_) external{
        require(msg.sender != defaultRefer &&
        userInfo[msg.sender].referrer == address(0) &&
        (userInfo[ref_].referrer != address(0) || ref_ == defaultRefer) &&
        ref_ != address(0) && msg.sender != ref_,"sender err");

        require(rewardInfo[ref_].freezeCapitals > 0 || ref_ == defaultRefer,"ref freezeCapitals is zero");

        UserInfo storage user = userInfo[msg.sender];
        user.addr = msg.sender;
        user.referrer = ref_;
        users.push(msg.sender);

        address ref = ref_;
        for (uint i =0; i<referDepth; i++) {
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
        require(_amount > 0,"zero amount");
        bool success = usdt.transferFrom(msg.sender, address(this), _amount);
        require(success,"transferFrom failed");

        _deposit(msg.sender, _amount);

        emit Deposit(msg.sender, _amount);
    }

    function depositBySplit(uint256 _amount) external onlyRegister {
        require(userInfo[msg.sender].maxDeposit == 0, "Already placed an order");
        require(!rewardInfo[msg.sender].isSplitUse, "used split");

        rewardInfo[msg.sender].isSplitUse = true;

        require(_amount > 0,"zero amount");

        (uint256 pendingSplit,,) = userPendingAmount(msg.sender);

        require(pendingSplit >= _amount,"insufficient integral");

        rewardInfo[msg.sender].debtSplit = rewardInfo[msg.sender].debtSplit.add(_amount);

        _deposit(msg.sender, _amount);

        emit DepositBySplit(msg.sender, _amount);
    }

    function withdraw() external lock {
        (,uint256 pendingAmount,) = userPendingAmount(msg.sender);
        RewardInfo storage ri = rewardInfo[msg.sender];

        ri.debtWithdraw = ri.debtWithdraw.add(pendingAmount);
        usdt.transfer(msg.sender,pendingAmount);

        UserRewardInfo memory uri = userRewardInfoPrevious(msg.sender);
        debtWithdrawInfos[msg.sender] = DebtWithdrawInfo(
            uri.totalCapitals,uri.totalStatic,uri.totalLevel1,uri.totalLevel25,uri.totalLevel610);
    }

    function transferSplit(address to,uint256 _amount) external lock {
        require(_amount > 0 && _amount % minDeposit == 0,"zero amount");
        require(to != address(0),"addr is zero");

        RewardInfo storage ri = rewardInfo[msg.sender];
        (uint256 pendingSplit,,) = userPendingAmount(msg.sender);
        uint256 newAmount = _amount.add(_amount.mul(splitTransferPercents).div(100));
        require(pendingSplit >= newAmount,"insufficient integral");

        ri.debtSplit = ri.debtSplit.add(newAmount);
        rewardInfo[to].transferSplit = rewardInfo[to].transferSplit.add(_amount);
    }

    function _deposit(address _userAddr, uint256 _amount) private {

        _checkDepositAmount(_amount,_userAddr);

        _distributeAmount(_amount);

        (bool isUnFreeze, uint256 newAmount) = _unfreezeCapitalOrReward(msg.sender,_amount);

        _updateLevelReward(msg.sender,_amount);

        bool isNew = _updateUserInfo(_userAddr,_amount,isUnFreeze);

        _updateTeamInfos(msg.sender,newAmount,isNew);

        super.updateRiskLevel(usdt.balanceOf(address(this)));
    }

    function _checkDepositAmount(uint256 _amount,address _userAddr) private view{
        UserInfo memory user = userInfo[_userAddr];
        require(_amount % minDeposit == 0 && _amount >= user.maxDeposit, "amount less or not mod");
        if (user.maxDeposit == 0) {
            require(_amount <= levelMaxDeposit[0], "amount more than max");
            return;
        }
        uint256 maxAmount;
        for (uint i=0; i<levelMinDeposit.length; i++) {
            if (user.maxDeposit >= levelMinDeposit[i]) {

                maxAmount = levelMaxDeposit[i];
                if (maxAmount == 2000e6) {
                    maxAmount = 2500e6;
                }

            }else {
                break;
            }
        }
        require(_amount <= maxAmount, "amount more than max");
    }

    function _distributeAmount(uint256 _amount) private {
        uint256 sysDevAmount = _amount.mul(sysDevPercents).div(baseDivider);
        uint256 insuranceAmount = _amount.mul(insurancePercents).div(baseDivider);
        uint256 foundationAmount = _amount.mul(foundationPercents).div(baseDivider);
        uint256 marketECOAmount = _amount.mul(marketECOPercents).div(baseDivider);

        usdt.transfer(sysDev,sysDevAmount);
        usdt.transfer(insurance,insuranceAmount);
        usdt.transfer(foundation,foundationAmount);
        usdt.transfer(marketECO,marketECOAmount);
    }

    function _updateUserInfo(address _userAddr,uint256 _amount,bool isUnFreeze) private returns(bool){
        UserInfo storage user = userInfo[_userAddr];
        bool isNew;
        if(user.maxDeposit == 0) {
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

        for (uint256 i = levelMinDeposit.length - 1; i >0; i--) {
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

    function _unfreezeCapitalOrReward(address _userAddr, uint256 _amount) private returns(bool isUnFreeze,uint256 newAmount) {

        RewardInfo storage ri = rewardInfo[_userAddr];
        uint256 addFreeze = dayPerCycle.add(orderInfos[_userAddr].length.mul(timeStep));
        if(addFreeze > maxAddFreeze) {
            addFreeze = maxAddFreeze;
        }
        uint256 unfreezeTime = block.timestamp.add(addFreeze);
        OrderInfo memory orderIn = OrderInfo(_userAddr,_amount, block.timestamp, unfreezeTime, false);
        orderInfos[_userAddr].push(orderIn);
        orders.push(orderIn);
        ri.freezeCapitals = ri.freezeCapitals.add(_amount);

        if (orderInfos[_userAddr].length <= 1) {
            return (false, _amount);
        }

        UserInfo storage user = userInfo[_userAddr];
        OrderInfo storage order = orderInfos[_userAddr][user.unfreezeIndex];

        (,bool isRisk,) = userTotalRevenue(_userAddr);

        if (block.timestamp < order.endTime || order.isUnFreeze) {

            uint256 freeAmount610 = 0;
            if (_amount >= ri.freezeTotalLevel610) {
                freeAmount610 = ri.freezeTotalLevel610;
            }else {
                freeAmount610 = _amount;
            }

            if (!isRisk) {
                ri.unfreezeLevel610 = ri.unfreezeLevel610.add(freeAmount610);
            }
            ri.freezeTotalLevel610 = ri.freezeTotalLevel610.sub(freeAmount610);

            return (false, _amount);
        }

        order.isUnFreeze = true;
        user.unfreezeIndex = user.unfreezeIndex.add(1);

        ri.freezeCapitals = ri.freezeCapitals.sub(order.amount);
        newAmount = _amount.sub(order.amount);

        (,,bool isStaticRisk) = userTotalRevenue(_userAddr);
        if (!isStaticRisk) {
            ri.capitals = ri.capitals.add(order.amount);
        }else{
            ri.riskCapitals = ri.riskCapitals.add(order.amount);
        }

        return (true,newAmount);
    }

    function _updateLevelReward(address _userAddr, uint256 _amount) private {
        address upline = _userAddr;
        for (uint256 i =0; i < referDepth; i++) {
            upline = userInfo[upline].referrer;
            if (upline == address(0)) {
                return;
            }

            if (orderInfos[upline].length == 0) {
                continue;
            }

            uint256 newAmount;
            OrderInfo memory latestUpOrder = orderInfos[upline][orderInfos[upline].length.sub(1)];
            uint256 maxFreezing = latestUpOrder.endTime > block.timestamp ? latestUpOrder.amount : 0;
            if(maxFreezing < _amount){
                newAmount = maxFreezing;
            }else{
                newAmount = _amount;
            }

            if (newAmount == 0) {
                continue;
            }
            _updateReward(upline,i,newAmount);
        }
    }

    function _updateReward(address upline,uint256 i, uint256 newAmount) private {

        UserInfo memory upuser = userInfo[upline];

        (, bool isRisk,) = userTotalRevenue(upline);

        RewardInfo storage ri = rewardInfo[upline];

        uint256 reward = newAmount.mul(invitePercents[i]).div(baseDivider);
        if (i == 0) {
            if (!isRisk) {
                ri.level1 = ri.level1.add(reward);
            }
            return;
        }

        if (upuser.level >= 1 && i == 1) {
            if (!isRisk) {
                ri.level25 = ri.level25.add(reward);
            }
            return;
        }

        if (upuser.level >= 2 && i == 2) {
            if (!isRisk) {
                ri.level25 = ri.level25.add(reward);
            }
            return;
        }

        if (upuser.level >= 3 && i == 3) {
            if (!isRisk) {
                ri.level25 = ri.level25.add(reward);
            }
            return;
        }

        if (upuser.level >= 3 && i == 4) {
            if (!isRisk) {
                ri.level25 = ri.level25.add(reward);
            }
            return;
        }

        if (upuser.level < 4) {
            return;
        }

        ri.freezeTotalLevel610 = ri.freezeTotalLevel610.add(reward);
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

        for(uint256 i = 0; i < referDepth; i++) {
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
            }else {
                upUser.maxTeamDeposit = downTotalTeamDeposit;
            }

            for (uint256 lv = levelMinDeposit.length - 1; lv >0; lv--) {
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

            if(upline == defaultRefer) break;
            downline = upline;
            upline = userInfo[upline].referrer;
        }
    }

    function userPendingAmount(address _user) private view returns (uint256, uint256, uint256) {
        RewardInfo memory ri = rewardInfo[_user];

        (uint256 totalRevenue,,)= userTotalRevenue(_user);

        return (totalRevenue.mul(splitPercents).div(100).add(ri.transferSplit).sub(ri.debtSplit),
        ri.capitals.add(ri.riskCapitals).add(totalRevenue.mul(realPercents).div(100)).sub(ri.debtWithdraw),
        totalRevenue);
    }

    function userTotalRevenue(address _userAddr) private view returns(uint256 totalRevenue,bool isRisk,bool isStaticRisk) {
        RewardInfo memory ri = rewardInfo[_userAddr];

        uint256 staticReward =  ri.capitals.mul(staticPercents).div(baseDivider);

        totalRevenue = staticReward.add(ri.level1).add(ri.level25)
        .add(ri.unfreezeLevel610);

        Risk memory risk = getRisk();

        UserInfo memory user = userInfo[_userAddr];

        if (!risk.riskFreeze || (risk.startTime != 0 && user.startTime > risk.startTime) ||
        totalRevenue < ri.freezeCapitals || (!risk.riskLevelNext && user.riskNum >= risk.riskNum)) {
            isRisk = false;
        }else {
            isRisk = true;
        }

        if (!risk.riskFreeze || (risk.startTime != 0 && user.startTime > risk.startTime) || totalRevenue < ri.freezeCapitals) {
            isStaticRisk = false;
        }else {
            isStaticRisk = true;
        }

        return (totalRevenue, isRisk ,isStaticRisk);
    }

    function userRewardInfo(address _user) external view returns(UserRewardInfo memory) {
        RewardInfo memory ri = rewardInfo[_user];

        uint256 staticExpect = ri.freezeCapitals.mul(staticPercents).div(baseDivider);

        (uint256 pendingSplit,uint256 pendingWithDraw, uint256 totalRevenue) = userPendingAmount(_user);

        UserRewardInfo memory uri = UserRewardInfo(
            ri.freezeCapitals,
            ri.capitals.add(ri.riskCapitals),
            ri.capitals.mul(staticPercents).div(baseDivider).mul(realPercents).div(100),
            ri.level1.mul(realPercents).div(100),
            ri.level25.mul(realPercents).div(100),
            ri.unfreezeLevel610.mul(realPercents).div(100),
            ri.freezeTotalLevel610,
            staticExpect.add(ri.freezeTotalLevel610).mul(splitPercents).div(100),
            totalRevenue,
            pendingSplit,
            pendingWithDraw
        );

        DebtWithdrawInfo memory debtu = debtWithdrawInfos[_user];
        uri.totalCapitals = uri.totalCapitals - debtu.totalCapitals;
        uri.totalStatic = uri.totalStatic - debtu.totalStatic;
        uri.totalLevel1 = uri.totalLevel1 - debtu.totalLevel1;
        uri.totalLevel25 = uri.totalLevel25 - debtu.totalLevel25;
        uri.totalLevel610 = uri.totalLevel610 - debtu.totalLevel610;

        return uri;
    }

    function userRewardInfoPrevious(address _user) public view returns(UserRewardInfo memory) {
        RewardInfo memory ri = rewardInfo[_user];

        uint256 staticExpect = ri.freezeCapitals.mul(staticPercents).div(baseDivider);

        (uint256 pendingSplit,uint256 pendingWithDraw, uint256 totalRevenue) = userPendingAmount(_user);

        UserRewardInfo memory uri = UserRewardInfo(
            ri.freezeCapitals,
            ri.capitals.add(ri.riskCapitals),
            ri.capitals.mul(staticPercents).div(baseDivider).mul(realPercents).div(100),
            ri.level1.mul(realPercents).div(100),
            ri.level25.mul(realPercents).div(100),
            ri.unfreezeLevel610.mul(realPercents).div(100),
            ri.freezeTotalLevel610,
            staticExpect.add(ri.freezeTotalLevel610).mul(splitPercents).div(100),
            totalRevenue,
            pendingSplit,
            pendingWithDraw
        );

        return uri;
    }

    function userOrder(address _user,uint256 index) external view returns(OrderInfo memory) {
        return orderInfos[_user][index];
    }

    function userOrders(address _user) external view returns(OrderInfo[] memory) {
        return orderInfos[_user];
    }

    function userOrderLen(address _user) external view returns(uint256) {
        return orderInfos[_user].length;
    }

    function getOrders() external view returns(OrderInfo[] memory) {
        uint256 size;
        if (orders.length > 10) {
            size = 10;
        }else {
            size = orders.length;
        }

        OrderInfo[] memory ors = new OrderInfo[](size);
        for (uint256 i=0; i<size; i++) {
            ors[i] = orders[orders.length - i - 1];
        }
        return ors;
    }

    function downLevel1UserAddrs(address _user) external view returns(address[] memory) {
        return downLevel1Users[_user];
    }

    function userDownLevel1(address _user,uint256 _start,uint256 _nums) external view returns(UserInfo[] memory)  {
        UserInfo[] memory userIn = new  UserInfo[](_nums);
        for (uint256 i = 0; i < _nums; i++) {
            address addr = downLevel1Users[_user][i+_start];
            userIn[i] = userInfoPer(addr);
        }
        return userIn;
    }

    function userInfoPer(address _user) public view returns(UserInfo memory) {
        UserInfo memory user = userInfo[_user];
        RewardInfo memory ri = rewardInfo[_user];

        user.otherTeamDeposit = user.totalTeamDeposit.sub(user.maxTeamDeposit);
        user.totalTeamDeposit = ri.freezeCapitals.add(user.totalTeamDeposit);
        user.totalHisDeposit = ri.freezeCapitals.add(ri.capitals).add(ri.riskCapitals);

        return user;
    }

    function getSysInfo() external view returns(SysInfo memory) {
        SysInfo memory sys = sysInfo;
        sys.usdtAddr = address(usdt);
        sys.balance = usdt.balanceOf(address(this));
        sys.totalRegisterUser = users.length;
        return sys;
    }

    function getPriSysInfo() external view returns(SysInfo memory) {
        return sysInfo;
    }

    function getConstant() external pure returns(uint256) {
        return splitTransferPercents;
    }

    function getDebtWithdrawInfo(address user) external view returns (DebtWithdrawInfo memory) {
        return debtWithdrawInfos[user];
    }
}