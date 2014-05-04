//
//  JDGSetFacebookAccessTokenRequest.h
//  judgement
//
//  Created by Max Yankov on 04.05.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGApiRequest.h"
#import "JDGValidatedUser.h"

@interface JDGSetFacebookAccessTokenRequest : JDGApiRequest

-(id)initWithApiClient:(JDGApiClient *)client
                  user:(JDGValidatedUser *)user
   facebookAccessToken:(NSString *)token
       successCallback:(setFacebookAccessTokenCallback)onSuccess
          failCallback:(requestFailCallback)onFail;

@end
