//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"

@interface TCTemplateUpdateTest : BlockChypTest



@end

@implementation TCTemplateUpdateTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  [self testDelayWith:client testName:@"TCTemplateUpdateTest"];


}

- (void)tearDown {

}

- (void)testTCTemplateUpdate{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"TCTemplateUpdate Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
        request[@"alias"] = [self getUUID];
        request[@"name"] = @"HIPPA Disclosure";
        request[@"content"] = @"Lorem ipsum dolor sit amet.";

  [client tcUpdateTemplateWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([response objectForKey:@"success"]);
    XCTAssertNotNil([response objectForKey:@"alias"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"alias"]) length] > 0);
    XCTAssertEqualObjects(@"HIPPA Disclosure", (NSString *)[response objectForKey:@"name"]);
    XCTAssertEqualObjects(@"Lorem ipsum dolor sit amet.", (NSString *)[response objectForKey:@"content"]);

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:30 handler:nil];

}



@end
