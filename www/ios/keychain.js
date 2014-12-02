cordova.define("com.aisino.plugin.keychainutils.CDVKeychain", function(require, exports, module) { /*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

// This is installed as a <js-module /> so it doesn't have a cordova.define wrapper

var exec = require('cordova/exec');

var Keychain = function() {};
     

//设置keychain
               
//successCallback 成功回调函数
//failureCallback 失败回调函数
//key   写入keychain用于区别其他的键值名称
//accessGroup appID标示符，由Prefix和ID组成，格式Prefix.ID,其中Prefix是创建appID时开发者网站生成的10位字符串，ID是创建appID时用户自定义的bundle ID，模拟器情况下可以设置为空（null）
Keychain.prototype.getForKey = function(successCallback, failureCallback, key,accessGroup)
{
	exec(successCallback, failureCallback, "CDVKeychain", "getForKey", [key, accessGroup]);
}

//读取keychain
               
//successCallback 成功回调函数
//failureCallback 失败回调函数
//key   写入keychain用于区别其他的键值名称
//value 写入keychainy需要加密的内容
Keychain.prototype.setForKey = function(successCallback, failureCallback, key, value,accessGroup)
{
	exec(successCallback, failureCallback, "CDVKeychain", "setForKey", [key, value, accessGroup]);
}

//删除keychain
               
//successCallback 成功回调函数
//failureCallback 失败回调函数
//key   写入keychain用于区别其他的键值名称
//accessGroup appID标示符，由Prefix和ID组成，格式Prefix.ID,其中Prefix是创建appID时开发者网站生成的10位字符串，ID是创建appID时用户自定义的bundle ID，模拟器情况下可以设置为空（null）
Keychain.prototype.removeForKey = function(successCallback, failureCallback, key,accessGroup)
{
	exec(successCallback, failureCallback, "CDVKeychain", "removeForKey", [key, accessGroup]);
}

module.exports = new Keychain();

});
