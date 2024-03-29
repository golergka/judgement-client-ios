//
//  JDGRegisterApiRequest.m
//  judgement
//
//  Created by Max Yankov on 14.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGRegisterApiRequest.h"
#import "JDGValidatedUser.h"

@implementation JDGRegisterApiRequest
{
    NSURLConnection* _connection;
    NSString* _vendorIdHash;
}

-(id)initWithApiClient:(JDGApiClient *)client
          vendorIdHash:(NSString*)vendorIdHash
       successCallback:(registerCallback)onSuccess
          failCallback:(requestFailCallback)onFail
{
    if (self = [super initWithApiClient:client
                           failCallback:onFail])
    {
        _vendorIdHash = vendorIdHash;
        NSDictionary *params = @{
            @"method": @"register",
            @"vendorIdHash": vendorIdHash
        };
        self.onSuccess = onSuccess;
        NSURL *url = [client urlForParams:params];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    }
    return self;
}

-(void)processContent:(id)content
{
#if DEBUG
    NSLog(@"Registration: %@", content);
#endif
    JDGValidatedUser *result = [[JDGValidatedUser alloc] initWithJson:(NSDictionary*)content];
    result.vendorIdHash = _vendorIdHash;
    self.onSuccess(result);
    [self.apiClient completeRequest:self];
}

@end
