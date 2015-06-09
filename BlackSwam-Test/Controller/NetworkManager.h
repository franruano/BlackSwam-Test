//
//  NetworkController.h
//  BlackSwam-Test
//
//  Created by Fran Abucillo on 22/5/15.
//  Copyright (c) 2015 Fran Ruano. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkManagerDelegate <NSObject>
@required
- (void) NetworkManagerDidFinishLoadingItem:(id)item message:(NSError *)errorMessage;
@end


@interface NetworkManager : NSObject <NSURLConnectionDelegate>{
    id <NetworkManagerDelegate> _delegate;
}

@property (nonatomic,strong) NSMutableData *responseData;
@property (nonatomic,strong) id delegate;

- (void) createUrlRequest:(NSString *)strUrl;

@end
