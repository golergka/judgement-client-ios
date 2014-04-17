//
//  JDGUser.h
//  judgement
//
//  Created by Max Yankov on 16.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGModel.h"
#import "JDGUser.h"

@interface JDGValidatedUser : JDGUser

+(JDGValidatedUser*)thisUser;

@property NSString* vendorIdHash;

@end
