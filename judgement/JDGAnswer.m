//
//  JDGAnswer.m
//  judgement
//
//  Created by Max Yankov on 16.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGAnswer.h"
#import "JDGModel.h"

@implementation JDGAnswer

-(id)initWithJson:(NSDictionary *)json
{
    if (self = [super initWithJson:json])
    {
        self.value = [[json objectForKey:@"value"] boolValue];
    }
    return self;
}

@end
