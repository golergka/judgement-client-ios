//
//  JDGModel.m
//  judgement
//
//  Created by Max Yankov on 16.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGModel.h"

static NSDateFormatter* jsonDateFormatter;

@implementation JDGModel
@synthesize createdAt, updatedAt;

+(void)initialize
{
    if (self == [JDGModel self])
    {
        jsonDateFormatter = [[NSDateFormatter alloc] init];
        [jsonDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    }
}

+(NSDateFormatter*)jsonDateFormatter
{
    return jsonDateFormatter;
}

-(id)initWithJson:(NSDictionary*)json
{
    if (self = [super init])
    {
        @try
        {
            self.uid = [[json objectForKey:@"id"] intValue];
            NSString *createdAtString = [json objectForKey:@"createdAt"];
            NSString *updatedAtString = [json objectForKey:@"updatedAt"];
            self.createdAt = [jsonDateFormatter dateFromString:createdAtString];
            self.updatedAt = [jsonDateFormatter dateFromString:updatedAtString];
        }
        @catch(NSException *e)
        {
            self = nil;
        }
    }
    return self;
}

-(void)refresh
{
    // abstract method
}

@end
