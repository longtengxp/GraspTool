﻿using System;
using LuaInterface;
using JinYiHelp.MediaHelp;

//lua 调用的接口
namespace CopyData
{
    class LuaCall
    {
        //获取当前文件所在位置目录
        public static string GetCurDir()
        {
            return Environment.CurrentDirectory;
        }

        //获取桌面位置目录
        public static string GetDeskTopDir() {
            return Environment.GetFolderPath(Environment.SpecialFolder.DesktopDirectory);
        }

        //执行一次http请求,异步
        //url: "www.baidu.com"
        //method: Method {GET,POST,PUT,DELETE}: 0 ,1 ,2 ,3
        //headTable:{AAA = "" , bbb = "" }
        //urlBody: "aaa=1&bbb=123"
        //postBody: "anything"
        //cookies: "a=avlue;c=cvalue"
        //proxyAddress: "http://127.0.0.1:8080" 代理IP:端口
        //taskEndAction: lua function
        public static void HttpRequestAsync(string url = null,int method = 0, LuaTable headTable = null, string urlBody = null, string postBody = null, string cookies = null, string proxyAddress = null, LuaFunction luaCallfunc = null)
        {
            CCHttp.HttpRequestAsync(url, method, headTable, urlBody, postBody, cookies, proxyAddress, luaCallfunc);
        }
        
        //执行一次http请求,同步
        public static string HttpRequest(string url = null, int method = 0, LuaTable headTable = null, string urlBody = null, string postBody = null, string cookies = null, string proxyAddress = null)
        {
            return CCHttp.HttpRequest(url, method, headTable, urlBody, postBody, cookies, proxyAddress);
        }

        //播放音效
        public static void PlayWAVSound(string path) {
            try {
                MediaHelper.ASyncPlayWAV(path);
            } catch (Exception e) {
                Console.WriteLine("playEffect error>> " + e.Message);
            }
        }

    }
}