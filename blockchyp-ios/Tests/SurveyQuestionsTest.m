// Copyright 2019-2022 BlockChyp, Inc. All rights reserved. Use of this code
// is governed by a license that can be found in the LICENSE file.
//
// This file was generated automatically by the BlockChyp SDK Generator.
// Changes to this file will be lost every time the code is regenerated.

#import "BlockChypTest.h"

@interface SurveyQuestionsTest : BlockChypTest


  @property NSString *lastTransactionId;
  @property NSString *lastTransactionRef;
  @property NSString *lastToken;
  @property NSString *lastCustomerId;
  @property NSDictionary *setupRequest;
  @property NSDictionary *setupResponse;


@end

@implementation SurveyQuestionsTest

- (void)setUp {

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;



  XCTestExpectation *expectation = [self expectationWithDescription:@"SurveyQuestions Test Setup"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"ordinal"] = @1;
  request[@"questionText"] = @"Would you shop here again?";
  request[@"questionType"] = @"yes_no";
  self.setupRequest = request;

    [client updateSurveyQuestionWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
      XCTAssertNil(error);
    self.setupResponse = response;
    self.lastTransactionId = [response objectForKey:@"transactionId"];
    self.lastTransactionRef = [response objectForKey:@"transactionRef"];
    self.lastToken = [response objectForKey:@"token"];
    NSDictionary *customer = (NSDictionary*)[response objectForKey:@"customer"];
    if ( (customer != NULL) && (customer != [NSNull null])) {
        self.lastCustomerId = [customer objectForKey:@"id"];
    }
    [expectation fulfill];
  }];

  @try {
    [self waitForExpectationsWithTimeout:60 handler:nil];
  }
  @catch (NSException *exception) {
    NSLog(@"Exception:%@",exception);
  }

}

- (void)tearDown {

}

- (void)testSurveyQuestions{

  TestConfiguration *config = [self loadConfiguration];
  BlockChyp *client = [[BlockChyp alloc] initWithApiKey:config.apiKey bearerToken:config.bearerToken signingKey:config.signingKey];
  client.gatewayHost = config.gatewayHost;
  client.testGatewayHost = config.testGatewayHost;
  client.dashboardHost = config.dashboardHost;

  
  XCTestExpectation *expectation = [self expectationWithDescription:@"SurveyQuestions Test"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];

  [client surveyQuestionsWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {

    [self logJSON:response];
    XCTAssertNotNil(response);
    // response assertions
    XCTAssertTrue([[response objectForKey:@"success"]boolValue]);
  
    [expectation fulfill];
  }];

  @try {
      [self waitForExpectationsWithTimeout:60 handler:nil];
  }
  @catch (NSException *exception) {
    NSLog(@"Exception:%@",exception);
  }

}

@end
