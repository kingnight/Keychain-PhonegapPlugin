/*
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

#import "CDVKeychain.h"
#import "KeychainItemWrapper.h"

@implementation CDVKeychain

- (void) getForKey:(CDVInvokedUrlCommand*)command
{
    NSArray* arguments = command.arguments;
    CDVPluginResult* pluginResult = nil;
    
    if ([arguments count] >= 2)
    {
        NSString* key = [arguments objectAtIndex:0];
        NSString* accessGroup = [arguments objectAtIndex:1];

        KeychainItemWrapper *wrapper=[[KeychainItemWrapper alloc]initWithIdentifier:key accessGroup:accessGroup];
        NSString* value=[wrapper objectForKey:(__bridge id)kSecValueData];
        NSLog(@"getForKey=%@",value);
        if (value != nil) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:value];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                             messageAsString:[NSString stringWithFormat:@"error retrieving value for key '%@' ", key]];
        }
    }
    else
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                         messageAsString:@"incorrect number of arguments for getForkey"];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) setForKey:(CDVInvokedUrlCommand*)command
{
    NSArray* arguments = command.arguments;
    CDVPluginResult* pluginResult = nil;
    
    if ([arguments count] >= 3)
    {
        NSString* key = [arguments objectAtIndex:0];
        NSString* value = [arguments objectAtIndex:1];
        NSString* accessGroup = [arguments objectAtIndex:2];
        NSError* error = nil;
        
        KeychainItemWrapper *wrapper=[[KeychainItemWrapper alloc]initWithIdentifier:key accessGroup:accessGroup];
        [wrapper setObject:value forKey:(__bridge id)kSecValueData withError:error];
        //kSecValueData 被加密数据
        //kSecAttrGeneric   区别不同字段
        
        if (error == nil) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[error localizedDescription]];
        }
    }
    else
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                         messageAsString:@"incorrect number of arguments for setForKey"];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) removeForKey:(CDVInvokedUrlCommand*)command
{
    NSArray* arguments = command.arguments;
    CDVPluginResult* pluginResult = nil;
    
    if ([arguments count] >= 2)
    {
        NSString* key = [arguments objectAtIndex:0];
        NSString* accessGroup = [arguments objectAtIndex:1];
        
        NSError* error = nil;
        
        KeychainItemWrapper *wrapper=[[KeychainItemWrapper alloc]initWithIdentifier:key accessGroup:accessGroup];
        [wrapper resetKeychainItem:error];
        
        if (error == nil) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[error localizedDescription]];
        }
    }
    else
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                         messageAsString:@"incorrect number of arguments for removeForKey"];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


@end

