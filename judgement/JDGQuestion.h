//
//  JDGQuestion.h
//  judgement
//
//  Created by Max Yankov on 06.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDGQuestion : NSObject

@property NSString * text;
@property NSDate * date;
@property int uid;

+ (id) questionFromJson:(NSDictionary *)questionJson;

@end
