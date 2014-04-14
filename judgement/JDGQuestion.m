//
//  JDGQuestion.m
//  judgement
//
//  Created by Max Yankov on 06.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGQuestion.h"

@implementation JDGQuestion
@synthesize text, date;

+(id) questionFromJson:(NSDictionary *)questionJson
{
    JDGQuestion *result = [[JDGQuestion alloc] init];
    result.uid = [[questionJson objectForKey:@"id"] intValue];
    result.text = [questionJson objectForKey:@"text"];
    
    NSDateFormatter *jsonDateFormat = [[NSDateFormatter alloc] init];
    [jsonDateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    
    result.date = [jsonDateFormat dateFromString:[questionJson objectForKey:@"date"]];
    
    return result;
}

@end
