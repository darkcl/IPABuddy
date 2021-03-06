//
//  IPABuddyTests.m
//  IPABuddyTests
//
//  Created by Yeung Yiu Hung on 6/4/2016.
//  Copyright © 2016 darkcl. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <IPABuddy/IPABuild.h>

@interface IPABuddyTests : XCTestCase

@end

@implementation IPABuddyTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testListInfo{
    XCTestExpectation *expectation = [self expectationWithDescription:@"List Info"];
    
    [IPABuild buildInformationForProjectPath:@"/Users/darkcl/Documents/Workspace/friendzone-swift/"
                                     success:^(NSArray *targets, NSArray *configurations, NSArray *schemes) {
                                         NSLog(@"Targets: %@", targets);
                                         NSLog(@"Configuration: %@", configurations);
                                         NSLog(@"Schemes: %@", schemes);
                                         
                                         [expectation fulfill];
                                     }
                                     failure:^(NSException *err) {
                                         XCTFail(@"Should not fail %@", err.debugDescription);
                                         [expectation fulfill];
                                     }];
    
    [self waitForExpectationsWithTimeout:INT_MAX
                                 handler:^(NSError * _Nullable error) {
                                     XCTAssertNil(error);
                                 }];
}

- (void)testBuild{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Build"];
    
    [IPABuild buildWithProjectPath:@"/Users/yeungyiuhung/Documents/Workspace/facesss-ios/Facesss.xcworkspace"
                            scheme:@"Facesss"
                            config:@"Release"
                            target:@"Facesss"
                        exportPath:@"/Users/yeungyiuhung/Documents/OTA Build"
                            domain:@"https://host/"
                         provision:@"Facesss App Developement"
                           ipaName:@"test-201604071151"
                           success:^{
                               [expectation fulfill];
                           }
                          progress:^(NSString *logs) {
                              NSLog(@"%@", logs);
                          }
                           failure:^(NSException *err) {
                               XCTFail(@"Should not fail %@", err.debugDescription);
                               [expectation fulfill];
                           }];
    [self waitForExpectationsWithTimeout:INT_MAX
                                 handler:^(NSError * _Nullable error) {
                                     XCTAssertNil(error);
                                 }];
}

@end
