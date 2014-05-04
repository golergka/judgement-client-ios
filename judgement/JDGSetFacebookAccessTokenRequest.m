//
//  JDGSetFacebookAccessTokenRequest.m
//  judgement
//
//  Created by Max Yankov on 04.05.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGSetFacebookAccessTokenRequest.h"
#import "JDGValidatedUser.h"

@implementation JDGSetFacebookAccessTokenRequest
{
    NSURLConnection                 *_connection;
    setFacebookAccessTokenCallback  _onSuccess;
}

-(id)initWithApiClient:(JDGApiClient *)client
                  user:(JDGValidatedUser *)user
   facebookAccessToken:(NSString *)token
       successCallback:(setFacebookAccessTokenCallback)onSuccess
          failCallback:(requestFailCallback)onFail
{
    if (self = [super initWithApiClient:client failCallback:onFail])
    {
        NSDictionary *params = @{
            @"method"               : @"setFacebookAccessToken",
            @"vendorIdHash"         : user.vendorIdHash,
            @"facebookAccessToken"  : token
        };
        NSURL *url = [client urlForParams:params];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        _onSuccess = onSuccess;
    }
    return self;
}

-(void)processContent:(id)content
{
    if (_onSuccess != nil)
        _onSuccess();
    [self.apiClient completeRequest:self];
}

@end
