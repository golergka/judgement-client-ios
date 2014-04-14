//
//  NSDictionary+JDGUrlEncoding.m
//  judgement
//
//  Created by Max Yankov on 13.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "NSDictionary+JDGUrlEncoding.h"

static NSString *toString(id object) {
    return [NSString stringWithFormat:@"%@", object];
}

static NSString *urlEncode(id object) {
    NSString *string = toString(object);
    return [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@implementation NSDictionary (JDGUrlEncoding)

-(NSString*) urlEncodedString {
    NSMutableArray *parts = [NSMutableArray array];
    for (id key in self) {
        id value = [self objectForKey: key];
        NSString *part = [NSString stringWithFormat:@"%@=%@", urlEncode(key), urlEncode(value)];
        [parts addObject:part];
    }
    return [parts componentsJoinedByString:@"&"];
}



@end
