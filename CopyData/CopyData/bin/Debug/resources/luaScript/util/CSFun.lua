local CSFun = class("CSFun")
local UIConfigData = require("resources.luaScript.data.UIConfigData")
local StringUtils = require("resources.luaScript.util.StringUtils")

--打印到输出界面
function CSFun.LogOut(data)
	if not UIConfigData.getIsShowOutLog() then
		return
	end
	if LogOut then
		LogOut(tostring(data))
	end
end

--打印到命令行
function CSFun.LogLua(data)
	if not UIConfigData.getIsShowOutLog() then
		return
	end
	if LogLua then
		LogLua(tostring(data))
	end
end

--获取fidder传过来的字符串
function CSFun.GetFidderString()
	if GetFidderString then
		return GetFidderString()
	end
end

--设置延时，time 秒
function CSFun.SetDelayTime(time ,func)
	if SetDelayTime then
		SetDelayTime(time, func)
	end
end

--定时器
--返回定时器ID
function CSFun.SetInterval(time, func)
	if SetInterval then
		return SetInterval(time, func)
	end
end

--停止某个定时器
-- timerID: 定时器ID，string类型
function CSFun.StopTimer(timerID)
	if StopTimer then
		return StopTimer(tostring(timerID))
	end
end

--获取当前exe所在目录
function CSFun.GetCurDir()
	if GetCurDir then
		return GetCurDir()
	end
end

--获取桌面目录
function CSFun.GetDeskTopDir()
	if GetDeskTopDir then
		return GetDeskTopDir()
	end
end

--[[
url: "www.baidu.com"
callFunc: 回调
method: Method {GET,POST,PUT,DELETE}: 0 ,1 ,2 ,3
headTable:{AAA = "" , bbb = "" }
urlBody: "aaa=1&bbb=123"
postBody: "anything"
cookies: "cookie1=avlue;cookies2=cvalue"  需要用分号隔开
taskEndAction: lua function
proxyAddress:"false" --代理, 默认false 不开启
]]
--异步请求http
function CSFun.httpReqAsync(url, callFunc, method, headTable, urlBody, postBody, cookies, proxyAddress)
	local Define = require("resources.luaScript.config.Define")
	method = method or Define.Method.GET
	headTable = headTable or {}
	urlBody = urlBody or ""
	postBody = postBody or ""
	cookies = cookies or ""
	proxyAddress = proxyAddress or ""
	if type(headTable) ~= "table" then
		headTable = {}
	end

	if not url or url == "" then 
		LogOut("error url is empty>> " .. debug.traceback())
		return
	 end

	 callFunc = callFunc or function(ret) end

	if HttpRequestAsync then
		HttpRequestAsync(url, method, headTable, urlBody, postBody, cookies, proxyAddress, callFunc)
	end
end

--文件是否存在
function CSFun.IsFileExist(fileName)
	if IsFileExist then
		return IsFileExist(fileName)
	end
end

--写入字符串到文件，文件不存在会创建
function CSFun.WriteFile(fileName, dataStr)
	if WriteFile then
		return WriteFile(fileName, dataStr)
	end
end

--读取文件内容
function CSFun.ReadFile(fileName)
	if ReadFile then
		return ReadFile(fileName)
	end
end

--继续写入字符串
function CSFun.AppendText(fileName, dataStr)
	if AppendText then
		return AppendText(fileName, dataStr)
	end
end

--继续写入一行
function CSFun.AppendLine(fileName, dataStr)
	if AppendLine then
		return AppendLine(fileName, dataStr)
	end
end

--创建文件
function CSFun.CreateFile(fileName)
	if CreateFile then
		return CreateFile(fileName)
	end
end

--播放wav音效
function CSFun.PlayWAVSound(filePath)
	local UIConfigData = require("resources.luaScript.data.UIConfigData")
	if not UIConfigData.getIsOpenTipSound() then
		return
	end
	if PlayWAVSound then
		PlayWAVSound(filePath)
	end
end

--字符串比较
function CSFun.StringCompare(srcStr, desStr)
	if StringCompare then
		return StringCompare(srcStr, desStr)
	end
end

--字符串转码
function CSFun.Utf8ToDefault(str)
	if Utf8ToDefault then
		return Utf8ToDefault(str)
	end
end

--字符串转码
function CSFun.DefaultToUtf8(str)
	if DefaultToUtf8 then
		return DefaultToUtf8(str)
	end
end

-- 清理输出日志
function CSFun.ClearOutLog()
	if ClearOutLog then ClearOutLog() end
end

-- 设置到剪贴板
function CSFun.CopyToClipBoard(dataStr)
	if CopyToClipBoard then
		CopyToClipBoard(dataStr)
	end
end

-- 获取剪贴板内容
function CSFun.GetClipBoardData()
	if GetClipBoardData then
		return GetClipBoardData()
	end
end

--代理IP是否可用
function CSFun.IsProxyCanUse(proxyUrl,callback)
	if not proxyUrl or proxyUrl == "" then
		if callback then
			callback(proxyUrl,false,nil)
		end
		return
	end
	--默认用http 不用https
	local tmpProxyUrl = proxyUrl
	if not StringUtils.checkWithHttp(proxyUrl) then
		tmpProxyUrl = "http://" .. proxyUrl
	end
	-- print(CSFun.Utf8ToDefault("测试URL: ") .. tostring(proxyUrl))
	local Define = require("resources.luaScript.config.Define")
	CSFun.httpReqAsync(Define.IP_ADDRESS_URL,function(self_address)
		CSFun.httpReqAsync(Define.IP_ADDRESS_URL,function(proxy_address) 
			-- print(CSFun.Utf8ToDefault("本机地址: ") .. self_address)
			-- print(CSFun.Utf8ToDefault("代理地址: ") .. proxy_address)
			local isFindStr = string.find(proxy_address,"returnCitySN")
			local is_proxy_useful = isFindStr and proxy_address and proxy_address ~= "" and (self_address ~= proxy_address)
			is_proxy_useful = is_proxy_useful or false
			-- print(CSFun.Utf8ToDefault("代理是否可用: ") .. proxyUrl .. "   " .. tostring(is_proxy_useful))
			if callback then
				callback(proxyUrl, is_proxy_useful, proxy_address)
			end
		end,nil,nil,nil,nil,nil,tmpProxyUrl)
	end)
end

--resStr是否是srcStr的子串
function CSFun.IsSubString(srcStr, resStr)
	if srcStr and resStr then
		if IsSubString then
			return IsSubString(srcStr, resStr)
		end
	end
end

return CSFun