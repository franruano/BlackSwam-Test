//
//  CatModelTests.m
//  BlackSwam-Test
//
//  Created by Fran Abucillo on 23/5/15.
//  Copyright (c) 2015 Fran Ruano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "catModel.h"

@interface CatModelTests : XCTestCase
{
    NSData* _img1;
    NSData* _img2;
    NSData* _img3;
}
@end


@implementation CatModelTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NSString *path1 = [[NSBundle bundleForClass:[self class]] pathForResource:@"dog1" ofType:@"jpg"];
    _img1 = [NSData dataWithContentsOfFile:path1];
    NSString *path2 = [[NSBundle bundleForClass:[self class]] pathForResource:@"dog2" ofType:@"jpg"];
    _img2 = [NSData dataWithContentsOfFile:path2];
    NSString *path3 = [[NSBundle bundleForClass:[self class]] pathForResource:@"dog3" ofType:@"jpg"];
    _img3 = [NSData dataWithContentsOfFile:path3];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSetModelNotNil {
    CatModel *cat1 = [[CatModel alloc] init];
    XCTAssertNotEqual(cat1, nil, "Object declared not nil");
}
- (void)testSetModelAndCreatedImageNotNil {
    CatModel *cat1 = [[CatModel alloc] init];
    [cat1 setCacheImage:_img1];
    XCTAssertNotEqual(cat1.fileName, nil, "fileName attribute not nil");
}
- (void)testSetModelAndCreatedDateNotNil {
    CatModel *cat1 = [[CatModel alloc] init];
    [cat1 setCacheImage:_img1];
    XCTAssertNotEqual(cat1.date, nil, "date attribute not nil");
}
- (void)testSetImagesAndCompareWithOriginal {
    CatModel *cat2 = [[CatModel alloc] init];
    [cat2 setCacheImage:_img2];
    if ([_img2 isEqualToData:[cat2 getCacheImage]]) {
        XCTAssert(YES, "image attribute correctly saved");
    }
}
- (void)testCompareModelWithWrongImage {
    CatModel *cat2 = [[CatModel alloc] init];
    [cat2 setCacheImage:_img2];
    if (![_img3 isEqualToData:[cat2 getCacheImage]]) {
        XCTAssert(YES, "image attribute compare with wrong imge");
    }
}





@end
