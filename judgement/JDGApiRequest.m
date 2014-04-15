//
//  JDGApiRequest.m
//  judgement
//
//  Created by Max Yankov on 14.04.14.
//  Copyright (c) 2014 golergka. All rights reserved.
//

#import "JDGApiRequest.h"

@interface JDGApiRequest ()

@property(readwrite, copy) requestFailCallback _onFail;

@end

@implementation JDGApiRequest
{
    NSMutableData*  _responseData;
    
}
@synthesize onFail;

-(id)initWithApiClient:(JDGApiClient *)client
          failCallback:(requestFailCallback)onFailCallback
{
    if (self = [super init])
    {
        _apiClient = client;
        onFail = onFailCallback;
    }
    return self;
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _responseData = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection
   didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *e;
    NSDictionary *responseJson = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableContainers error:&e];
#if DEBUG
    NSLog(@"Response: %@", responseJson);
#endif
    NSString *error = [responseJson objectForKey:@"error"];
    if (error != NULL)
    {
#if DEBUG
        NSLog(@"Error: %@", error);
#endif
        self.onFail();
        [_apiClient completeRequest:self];
    } else {
        id content = [responseJson objectForKey:@"content"];
        [self processContent:content];
    }
}

-(void)processContent:(id)content
{
    NSLog(@"JDGApiRequest processContent");
    [self doesNotRecognizeSelector:_cmd];
}

@end
