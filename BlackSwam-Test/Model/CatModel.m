

#import "CatModel.h"




@implementation CatModel


- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.date forKey:kDate];
    [coder encodeObject:self.fileName forKey:kFileName];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [self init];
    self.date = [coder decodeObjectForKey:kDate];
    self.fileName = [coder decodeObjectForKey:kFileName];
    return self;
}

- (void) setCacheImage:(NSData *) imageData {
    self.date = [[NSDate alloc]init];
    
    self.fileName = [NSString stringWithFormat:@"%@.jpg",[self convertNSDateToNSString]];
    NSString *fullPath = [[self getFolderPath] stringByAppendingPathComponent:self.fileName];
    
    [imageData writeToFile:fullPath atomically:YES];
}

- (NSData *) getCacheImage {
    NSString *fullPath = [[self getFolderPath] stringByAppendingPathComponent:self.fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath]) {
        return [NSData dataWithContentsOfFile:fullPath];
    }
    return nil;
}

#pragma marks - helper

- (NSString *) getFolderPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return paths[0];
}

- (NSString *) convertNSDateToNSString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:kDateFileName];
    
    return  [formatter stringFromDate:self.date];
}

@end
