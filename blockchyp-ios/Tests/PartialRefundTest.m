//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"

@interface PartialRefundTest : BlockChypTest


  @property NSString *lastTransactionId;
  @property NSString *lastTransactionRef;


@end

@implementation PartialRefundTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  [self testDelayWith:client testName:@"PartialRefundTest"];


  XCTestExpectation *expectation = [self expectationWithDescription:@"PartialRefund Test Setup"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
      request[@"pan"] = @"4111111111111111";
      request[@"expMonth"] = @"12";
      request[@"expYear"] = @"2025";
      request[@"amount"] = @"25.55";
      request[@"test"] = @YES;
      request[@"transactionRef"] = [self getUUID];

  [client chargeWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {

    XCTAssertNil(error);
    self.lastTransactionId = [response objectForKey:@"transactionId"];
    self.lastTransactionRef = [response objectForKey:@"transactionRef"];

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:60 handler:nil];


}

- (void)tearDown {

}

- (void)testPartialRefund{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"PartialRefund Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
        request[@"transactionId"] = self.lastTransactionId;
        request[@"amount"] = @"5.00";
        request[@"test"] = @YES;

  [client refundWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([response objectForKey:@"success"]);
    XCTAssertTrue([response objectForKey:@"approved"]);

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:30 handler:nil];

}



@end
