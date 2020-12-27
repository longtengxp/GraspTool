--[[任务配置类，其他任务可由本任务配置继承拓展]]

local TaskBase = class("TaskBase")
local Define = require("resources.luaScript.config.Define")
local CSFun = require("resources.luaScript.util.CSFun")

TaskBase.GET = Define.Method.GET
TaskBase.POST = Define.Method.POST
--任务列表，例子
TaskBase.TASK_LIST_URL_CONFIG = {
--[[
	{
		taskName = "签到",  --任务名
		url = "hbz.qrmkt.cn/hbact/hyr/sign/doit",--任务URL
		method = TaskBase.GET, --请求方法
		preTaskName = "",  --前置任务名
		reqCount = 3, --请求次数
		urlBody = "",  --URL参数
		postBody = "",  --post参数
		delay = 0.2, --延迟
		isRedPacket = false, --当前任务是否需要卡包，是的话会执行多次当前任务，进行卡包
	},
	{
		taskName = "开始学习", 
		url = "hbz.qrmkt.cn/hbact/school/study/start",
		method = TaskBase.POST, 
		preTaskName = "签到", 
		reqCount = 3,
		urlBody = "", 
		postBody = "", 
		delay = 0.2,
		isRedPacket = false,
	},
	]]
}

function TaskBase:ctor()
	self.FIND_STRING_HOST 		= ""  --域名，方便查找token, 如：hbz.qrmkt.cn
	self.FILE_SAVE_NAME 		= ""  -- 保存本地token文件名字，如: token.lua
	self.RECORD_SAVE_FILE_NAME 	= ""  --交互记录文件, 如：token_record_url.lua
	self.DATA_TO_FIND_ARRAY = {}      -- 请求头中要查找的字段，如：token, Cookie
	self.IS_OPEN_RECORD = false 	  --是否抓取接口保存到本地
	self._taskList = {}
	self:loadTask()
end

--加载所有任务到任务列表
function TaskBase:loadTask()
	self._taskList = {}
	local HttpTask = require("resources.luaScript.task.base.HttpTask")
	for index, task_config in ipairs(self.TASK_LIST_URL_CONFIG) do
		local task = HttpTask.new()
		task:initWithConfig(task_config)
		task:setCurTaskIndex(index)
		table.insert(self._taskList, task)
	end
end

--获取第一个任务
function TaskBase:getTop()
	return self._taskList[1]
end

--获取最后一个任务
function TaskBase:getEnd()
	return self._taskList[#self._taskList]
end

--获取任务列表
function TaskBase:getTaskList()
	return self._taskList
end

--获取任务数量
function TaskBase:getTaskCount()
	return #self._taskList
end

--请求头
function TaskBase:getReqHeadString()
	-- print("getReqHeadString()>> " .. Define.REQ_HEAD_BEFORE .. self.FIND_STRING_HOST)
	return Define.REQ_HEAD_BEFORE .. self.FIND_STRING_HOST
end

--请求体
function TaskBase:getReqBodyString()
	return Define.REQ_BODY_BEFORE .. self.FIND_STRING_HOST
end

--返回头
function TaskBase:getResHeadString()
	return Define.RES_HEAD_BEFORE .. self.FIND_STRING_HOST
end

--返回体
function TaskBase:getResBodyString()
	return Define.RES_BODY_BEFORE .. self.FIND_STRING_HOST
end

--交互记录
function TaskBase:getRecordString()
	return Define.RES_RECORD .. self.FIND_STRING_HOST
end

--查找字段
function TaskBase:getDataToFind()
	return self.DATA_TO_FIND_ARRAY
end

--是否开启记录交互记录
function TaskBase:getIsRecord()
	return self.IS_OPEN_RECORD
end

--返回保存tolen文件地址
function TaskBase:getSaveFileName()
	local CUR_DIR_NAME = CSFun.GetCurDir()
	local fileName = tostring(CUR_DIR_NAME) .. [[\resources\luaScript\token\]] .. self.FILE_SAVE_NAME
	return fileName
end

--返回保存交互记录文件地址
function TaskBase:getRecordGraspFileName()
	local CUR_DIR_NAME = CSFun.GetCurDir()
	local fileName = tostring(CUR_DIR_NAME) .. [[\resources\luaScript\token\]] .. self.RECORD_SAVE_FILE_NAME
	return fileName
end

--开始执行下一个任务,参数为HttpTask对象
--curHttpTaskObj: 当前task
--preHttpTaskObj: 前一个task
function TaskBase:onNextTask(curHttpTaskObj, preHttpTaskObj)
	--local preTaskName = preHttpTaskObj and preHttpTaskObj:getTaskName() or "empty"
	--print("hcc>>onTaskStart>> curTaskName: " .. curHttpTaskObj:getTaskName() .. " ,preTaskName: " .. preTaskName)
end 

--切换下一个token执行任务
--curHttpTaskObj: 当前task
--preHttpTaskObj: 前一个task
function TaskBase:onNextToken(curHttpTaskObj, preHttpTaskObj)
	--local preTaskName = preHttpTaskObj and preHttpTaskObj:getTaskName() or "empty"
	--print("hcc>>onNextToken>> " .. curHttpTaskObj:getTaskName() .. "   ,preTaskName: " .. preTaskName)
end

return TaskBase