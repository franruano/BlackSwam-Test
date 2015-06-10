

#import "NetworkManager.h"
#import "Reachability.h"
#import "Constants.h"




@implementation NetworkManager

- (void) createUrlRequest:(NSString *)strUrl {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    if (networkStatus != NotReachable) {
        // Initialize a request with an url cache policy and timeout.
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",kBasePath,strUrl]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                           timeoutInterval:20.0];
        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(NetworkManagerDidFinishLoadingItem:message:)]) {
            NSDictionary *userInfo = @{
                                       NSLocalizedDescriptionKey: NSLocalizedString(@"Not Connected To Internet", nil),
                                       NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"Not Connected To Internet", nil),
                                       NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Could you check your Internet connection??", nil)
                                       };
            NSError *error = [NSError errorWithDomain:@"InternetError"
                                                 code:kCFURLErrorNotConnectedToInternet
                                             userInfo:userInfo];
            
            [self.delegate NetworkManagerDidFinishLoadingItem:nil message:error];
        }
    }
}


#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (self.delegate && [self.delegate respondsToSelector:@selector(NetworkManagerDidFinishLoadingItem:  message:)]) {
        [self.delegate NetworkManagerDidFinishLoadingItem:self.responseData message:nil];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error.description);
    if (self.delegate && [self.delegate respondsToSelector:@selector(NetworkManagerDidFinishLoadingItem: message:)]) {
        [self.delegate NetworkManagerDidFinishLoadingItem:nil message:error];
    }
}

@end
