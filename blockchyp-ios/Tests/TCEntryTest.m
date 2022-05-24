//
//  Tests.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"

@interface TCEntryTest : BlockChypTest


  @property NSString *lastTransactionId;
  @property NSString *lastTransactionRef;
  @property NSString *lastToken;
  @property NSString *lastCustomerId;


@end

@implementation TCEntryTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  [self testDelayWith:client testName:@"TCEntryTest"];


  XCTestExpectation *expectation = [self expectationWithDescription:@"TCEntry Test Setup"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];

  [client tcLogWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {

    XCTAssertNil(error);
    self.lastTransactionId = [response objectForKey:@"transactionId"];
    self.lastTransactionRef = [response objectForKey:@"transactionRef"];
    self.lastToken = [response objectForKey:@"lastToken"];
    self.lastCustomerId = [response objectForKey:@"lastCustomerId"];

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:60 handler:nil];


}

- (void)tearDown {

}

- (void)testTCEntry{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;

  XCTestExpectation *expectation = [self expectationWithDescription:@"TCEntry Test"];

      NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
    
  [client tcEntryWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([response objectForKey:@"success"]);
    XCTAssertNotNil([response objectForKey:@"id"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"id"]) length] > 0);
    XCTAssertNotNil([response objectForKey:@"terminalId"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"terminalId"]) length] > 0);
    XCTAssertNotNil([response objectForKey:@"terminalName"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"terminalName"]) length] > 0);
    XCTAssertNotNil([response objectForKey:@"timestamp"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"timestamp"]) length] > 0);
    XCTAssertNotNil([response objectForKey:@"name"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"name"]) length] > 0);
    XCTAssertNotNil([response objectForKey:@"content"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"content"]) length] > 0);
    XCTAssertTrue([response objectForKey:@"hasSignature"]);
    XCTAssertNotNil([response objectForKey:@"signature"]);
    XCTAssertTrue([((NSString *)[response objectForKey:@"signature"]) length] > 0);

    [expectation fulfill];
  }];

  [self waitForExpectationsWithTimeout:30 handler:nil];

}



@end
