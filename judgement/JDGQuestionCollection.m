//
//  JDGQuestionEnumerable.m
//  judgement
//
//  Created by Max Yankov on 30.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGQuestionCollection.h"
#import "JDGApiClient.h"

@interface JDGQuestionCollection () {
    NSArray *_questions;
}
@end

@implementation JDGQuestionCollection

-(id)initAndRefreshWithSuccessCallback:(void (^)(void))onSuccess
                          failCallback:(void (^)(void))onFail
{
    if (self = [super init])
    {
        [self refreshWithSuccessCallback:onSuccess
                            failCallback:onFail];
    }
    return self;
}

-(JDGQuestion*)getQuestionAtIndex:(NSUInteger)index
{
    if (index >= [_questions count])
        return nil;
    else
        return [_questions objectAtIndex:index];
}

-(void)refreshWithSuccessCallback:(void (^)(void))onSuccess
                     failCallback:(void (^)(void))onFail
{
    [[JDGApiClient sharedClient]
     getQuestionsWithSuccessCallback:^(NSArray *questions) {
        _questions = questions;
        onSuccess();
        return;
     }
     failCallback:onFail];
}

@end
