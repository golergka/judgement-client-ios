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
        [jsonDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
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
        id idObject;
        NSString *createdAtString;
        NSString *updatedAtString;
        
        if (json == nil || json == [NSNull null])
        { goto fail; }
        
        idObject = [json objectForKey:@"id"];
        createdAtString = [json objectForKey:@"createdAt"];
        updatedAtString = [json objectForKey:@"updatedAt"];
        
        if (idObject == nil || createdAtString == nil || updatedAtString == nil)
        { goto fail; }

        self.uid = [idObject intValue];
        self.createdAt = [jsonDateFormatter dateFromString:createdAtString];
        self.updatedAt = [jsonDateFormatter dateFromString:updatedAtString];
        
        if(false)
        {
        fail:
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
