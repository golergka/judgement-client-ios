//
//  JDGAddQuestionApiRequest.h
//  judgement
//
//  Created by Max Yankov on 03.05.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGApiRequest.h"
#import "JDGQuestion.h"

@interface JDGAddQuestionApiRequest : JDGApiRequest

-(id)initWithApiClient:(JDGApiClient *)client
                  user:(JDGValidatedUser *)user
                  text:(NSString *)questionText
              deadline:(NSDate *)questionDate
       successCallback:(addQuestionCallback)onSuccess
          failCallback:(requestFailCallback)onFail;

@end
