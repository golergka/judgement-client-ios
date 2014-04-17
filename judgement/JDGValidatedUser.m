//
//  JDGUser.m
//  judgement
//
//  Created by Max Yankov on 16.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGValidatedUser.h"
#import "JDGApiClient.h"

static JDGValidatedUser* thisUser;

@implementation JDGValidatedUser
@synthesize vendorIdHash;

+(void)load
{
    NSString *vendorId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [[JDGApiClient sharedClient]
     registerWithVendorIdHash:vendorId
     successCallback:^(JDGValidatedUser *result){
         thisUser = result;
     }
     failCallback:nil];
}

+(JDGValidatedUser*)thisUser
{
    return thisUser;
}

@end
