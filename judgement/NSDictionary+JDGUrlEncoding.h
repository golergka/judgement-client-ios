//
//  NSDictionary+JDGUrlEncoding.h
//  judgement
//
//  Created by Max Yankov on 13.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

// http://stackoverflow.com/questions/718429/creating-url-query-parameters-from-nsdictionary-objects-in-objectivec

#import <Foundation/Foundation.h>

@interface NSDictionary (JDGUrlEncoding)

-(NSString*) urlEncodedString;

@end
