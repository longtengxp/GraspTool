--[[钻石活动]]
local TaskBase = require("resources.luaScript.task.base.TaskBase")
local TaskDiamond = class("TaskDiamond", TaskBase)
local GET = TaskBase.GET
local POST = TaskBase.POST

function TaskDiamond:ctor()
	self.CUR_TASK_TITLE = "钻石活动"  --当前任务标题
	self.FIND_STRING_HOST = "hbz.qrmkt.cn"  --域名，方便查找token
	self.FILE_SAVE_NAME = "task_diamond_token.lua" -- 保存本地token文件名字
	self.RECORD_SAVE_FILE_NAME = "task_diamond_record.lua" --交互记录文件
	self.DATA_TO_FIND_ARRAY = {"token"}      --需要查找的taken 或者cookie
	self.IS_OPEN_RECORD = false 	  --是否抓取接口保存到本地
	self._taskList = {}
	self:loadTask()
end

--开始执行下一个任务
function TaskDiamond:onNextTask(curHttpTaskObj, preHttpTaskObj)
	local curTaskName = curHttpTaskObj and curHttpTaskObj:getTaskName() or "empty"
	local preTaskName = preHttpTaskObj and preHttpTaskObj:getTaskName() or "empty"
	-- print("hcc>>TaskDiamond>>onTaskStart>> curTaskName: " .. curTaskName .. " ,preTaskName: " .. preTaskName)
	-- if preTaskName == "请求活动码" then
	-- 	print("findddd>>>>>>>>>>>")
	-- end
end 

--切换下一个token执行任务
function TaskDiamond:onNextToken(curHttpTaskObj, preHttpTaskObj)
	local curTaskName = curHttpTaskObj and curHttpTaskObj:getTaskName() or "empty"
	local preTaskName = preHttpTaskObj and preHttpTaskObj:getTaskName() or "empty"
	-- print("hcc>>TaskDiamond>>onNextToken>> " .. curHttpTaskObj:getTaskName() .. "   ,preTaskName: " .. preTaskName)
end

--额外的请求头,也可以不用配置
TaskDiamond.ERQ_HEADER_EXT = {
	-- ["token"] = "hcctoken",
}

--任务列表
TaskDiamond.TASK_LIST_URL_CONFIG = {
	{
		curTaskName = "请求活动码啊", 
		url = "https://hbz.qrmkt.cn/hbact/hyr/home/queryActCode",
		method = POST, 
		reqCount = 1,
		urlBody = "", 
		postBody = "actType=2", 
		delay = 0,
	},
	{
		curTaskName = "签到", 
		url = "hbz.qrmkt.cn/hbact/hyr/sign/doit",
		method = POST, 
		reqCount = 5,
		urlBody = "", 
		postBody = "shareCode=null", 
		delay = 0,
	},
	-- {
	-- 	curTaskName = "签到列表", 
	-- 	url = "hbz.qrmkt.cn/hbact/hyr/sign/list",
	-- 	method = POST, 
	-- 	reqCount = 1, 
	-- 	urlBody = "", 
	-- 	postBody = "", 
	-- 	delay = 0,
	-- },
	{
		curTaskName = "开始学习啊", 
		url = "hbz.qrmkt.cn/hbact/school/study/start",
		method = POST, 
		reqCount = 1,
		delay = 0,
	},	
	{
		curTaskName = "结束学习", 
		url = "hbz.qrmkt.cn/hbact/school/study/end",
		method = POST, 
		postBody = "shareCode=null",
		reqCount = 1,
		delay = 0,
		delay = 20,
		-- delay = 0,
	},
	{
		curTaskName = "检测考试机会", 
		url = "hbz.qrmkt.cn/hbact/exam/chance",
		method = GET,
		reqCount = 1,
		delay = 0,
	},
	{
		curTaskName = "兑换8.88鼓励金红包啊", 
		url = "https://hbz.qrmkt.cn/hbact/commucard/exchange",
		method = GET, 
		reqCount = 1, 
		urlBody = "id=42",
		postBody = "", 
		delay = 0,
	},
	{
		curTaskName = "兑换18.8鼓励金红包啊", 
		url = "https://hbz.qrmkt.cn/hbact/commucard/exchange",
		method = GET, 
		reqCount = 1, 
		urlBody = "id=43", 
		postBody = "", 
		delay = 0,
	},
	{
		curTaskName = "兑换88.8鼓励金红包啊", 
		url = "https://hbz.qrmkt.cn/hbact/commucard/exchange",
		method = GET, 
		reqCount = 1, 
		urlBody = "id=51", 
		postBody = "", 
		delay = 0,
	},
	--[[
	{
		curTaskName = "兑换188.0荷石璧啊", 
		url = "https://hbz.qrmkt.cn/hbact/commucard/exchange",
		method = GET, 
		reqCount = 1, 
		urlBody = "id=45", 
		postBody = "", 
		delay = 0,
	},
	{
		curTaskName = "兑换588.0荷石璧啊", 
		url = "https://hbz.qrmkt.cn/hbact/commucard/exchange",
		method = GET, 
		reqCount = 1, 
		urlBody = "id=46", 
		postBody = "", 
		delay = 0,
	},
	{
		curTaskName = "兑换888.0荷石璧啊", 
		url = "https://hbz.qrmkt.cn/hbact/commucard/exchange",
		method = GET, 
		reqCount = 1, 
		urlBody = "id=47", 
		postBody = "", 
		delay = 0,
	},
	{
		curTaskName = "兑换1888.0荷石璧啊", 
		url = "https://hbz.qrmkt.cn/hbact/commucard/exchange",
		method = GET, 
		reqCount = 1, 
		urlBody = "id=49", 
		postBody = "", 
		delay = 0,
	},
	{
		curTaskName = "兑换988.0荷石璧啊", 
		url = "https://hbz.qrmkt.cn/hbact/commucard/exchange",
		method = GET, 
		reqCount = 1, 
		urlBody = "id=50", 
		postBody = "", 
		delay = 0,
	},
	{
		curTaskName = "兑换钻石品鉴福利一份啊", 
		url = "https://hbz.qrmkt.cn/hbact/commucard/exchange",
		method = GET, 
		reqCount = 1, 
		urlBody = "id=52", 
		postBody = "", 
		delay = 0,
	},
	]]
	--[[
	{
		curTaskName = "开始考试", 
		url = "hbz.qrmkt.cn/hbact/exam/random",
		method = GET,
		reqCount = 1,
		delay = 0,
	},
	{
		curTaskName = "提交考试", 
		url = "hbz.qrmkt.cn/hbact/exam/finish",
		method = POST,
		urlBody ="shareCode=null",
		postBody = "",
		reqCount = 1,
		delay = 0,
	},
	{
		curTaskName = "检测挖矿机会啊", 
		url = "hbz.qrmkt.cn/hbact/hyr/mine/check",
		method = POST,
		urlBody ="",
		postBody = "",
		reqCount = 1,
		delay = 0,
	},
	{
		curTaskName = "分享码啊", 
		url = "hbz.qrmkt.cn/hbact/hyr/home/hasAwd",
		method = GET,
		reqCount = 1,
		delay = 0,
	},
	]]
}

return TaskDiamond