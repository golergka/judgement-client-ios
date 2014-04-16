//
//  JDGModel.h
//  judgement
//
//  Created by Max Yankov on 16.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDGModel : NSObject

@property int uid;
@property NSDate* createdAt;
@property NSDate* updatedAt;

-(id)initWithJson:(NSDictionary*)json;

+(NSDateFormatter*)jsonDateFormatter;

@end
