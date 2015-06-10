

#import <Foundation/Foundation.h>
#import "Constants.h"


@interface CatModel:NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *fileName;


- (void) setCacheImage:(NSData *) imageData;
- (NSData *) getCacheImage;
@end
