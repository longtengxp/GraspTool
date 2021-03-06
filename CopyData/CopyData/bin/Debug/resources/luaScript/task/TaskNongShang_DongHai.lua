--[[农商银行-东海]] 
local TaskBase 		= require("resources.luaScript.task.base.TaskBase")
local TaskTMP 		= class("TaskTMP", TaskBase)
local CShapListView = require("resources.luaScript.uiLogic.CShapListView")
local CSFun 		= require("resources.luaScript.util.CSFun")

local GET = TaskBase.GET
local POST = TaskBase.POST

TaskTMP.FIND_STRING_HOST 		= "wx.dhrcbank.com"
TaskTMP.DATA_TO_FIND_ARRAY 		= {"XAuthToken","Cookie"}
TaskTMP.DEFAULT_KABAO_COUNT 	= 250 	-- 默认卡包次数，需要设置isKabao后才生效

--额外的请求头,也可以不用配置
TaskTMP.ERQ_HEADER_EXT = {
	["Referer"] = "http://wx.dhrcbank.com/win/WxyhServerV5/Areas/PigOpenDoor/Pages/Index.html?typeCode=FLM&mpId=rcb",
	["Accept"] = "*/*",
}

--任务列表
TaskTMP.TASK_LIST_URL_CONFIG = {
	{
		curTaskName = "抽奖", 
		url = "http://wx.dhrcbank.com/win/WxyhServerV5/api/LottApi/Run",
		method = POST, 
		reqCount = 150,
		urlBody = "", 
		postBody = [[{"typeCode":"FLM","wxLatitude":30.276626586914062,"wxLongitude":120.09983825683594,"locName":null}]],
		delay = 0,
		isKabao = true,
	},
}

return TaskTMP