//
//  JDGUser.m
//  judgement
//
//  Created by Max Yankov on 16.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGUser.h"
#import "JDGApiClient.h"

static JDGUser* thisUser;

@implementation JDGUser

+(void)load
{
    NSString *vendorId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [[JDGApiClient sharedClient]
     registerWithVendorIdHash:vendorId
     successCallback:^(JDGUser *result){
         thisUser = result;
     }
     failCallback:nil];
}

+(JDGUser*)thisUser
{
    return thisUser;
}

@end
