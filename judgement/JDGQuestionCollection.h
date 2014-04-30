//
//  JDGQuestionEnumerable.h
//  judgement
//
//  Created by Max Yankov on 30.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDGQuestion.h"

@interface JDGQuestionCollection : NSObject


-(id)initAndRefreshWithSuccessCallback:(void (^)(void))onSuccess
                          failCallback:(void (^)(void))onFail;

-(void)refreshWithSuccessCallback:(void (^)(void))onSuccess
                     failCallback:(void (^)(void))onFail;

-(JDGQuestion*)getQuestionAtIndex:(NSUInteger)index;

@end
