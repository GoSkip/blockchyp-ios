# BlockChyp iOS SDK

[![Build Status](https://circleci.com/gh/blockchyp/blockchyp-ios/tree/master.svg?style=shield)](https://circleci.com/gh/blockchyp/blockchyp-ios/tree/master)
[![CocoaPods](https://img.shields.io/cocoapods/v/BlockChyp)](https://cocoapods.org/pods/BlockChyp)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/blockchyp/blockchyp-ios/blob/master/LICENSE)

This is the SDK for iOS. Like all BlockChyp SDKs, it provides a full
client for the BlockChyp gateway and BlockChyp payment terminals. The SDK is
written in Objective-C, but can be used by Swift developers as well.

## Installation

The preferred method of installing BlockChyp is via cocoapods. Add the following
dependency to your Podfile and type `pod install`.

```
  pod 'BlockChyp', '~> sdk.version'
```

Note: If you're using Swift, you'll need to make sure dynamic frameworks are turned
on in your Podfile or create a bridging header.

## A Simple Objective-C Example

The following snippet illustrates how to run a simple terminal transaction from Objective-C.

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"test"] = @YES;
  request[@"terminalName"] = @"Test Terminal";
  request[@"amount"] = @"55.00";
  [client chargeWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"approved"];
    if (success.boolValue) {
      NSLog(@"Approved");
    }
    NSLog(@"%@: %@", @"authCode", [response objectForKey:@"authCode"])
    NSLog(@"%@: %@", @"authorizedAmount", [response objectForKey:@"authorizedAmount"])
  }];
  [pool drain];
  return 0;
}
```

## A Simple Swift Example

The following snippet illustrates how to run a simple terminal transaction from Swift.

```swift
import BlockChyp

let client = BlockChyp.init(
  apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
  bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
  signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
)

var request: [String:Any] = [:]
request["test"] = true
request["terminalName"] = "Test Terminal"
request["amount"] = "55.00"
client.charge(withRequest: request, handler: { (request, response, error) in
  let approved = response["approved"] as? Bool
  if (approved.unsafelyUnwrapped) {
    NSLog("Approved")
  }
  NSLog("authCode" + ": " + (response["authCode"] as? String).unsafelyUnwrapped)
  NSLog("authorizedAmount" + ": " + (response["authorizedAmount"] as? String).unsafelyUnwrapped)
})
```


All calls to the BlockChyp SDK must be asyncronous, so you must provide a
`BlockChypCompletionHandler` block for each call. The completion handler is
declared as a type in BlockChypClient.h.

```objective-c
typedef void(^BlockChypCompletionHandler)(NSDictionary *request, NSDictionary *response, NSError * _Nullable error);
```

The block will be passed a copy of the original request NSDictionary and
the response as an NSDictionary along with an NSError with any error information that
may be relevant.




## The Rest APIs

All BlockChyp SDKs provide a convenient way of accessing the BlockChyp REST APIs.
You can checkout the REST API documentation via the links below.

[Terminal REST API Docs](https://docs.blockchyp.com/rest-api/terminal/index.html)

[Gateway REST API Docs](https://docs.blockchyp.com/rest-api/gateway/index.html)

## Other SDKs

BlockChyp has officially supported SDKs for eight different development platforms and counting.
Here's the full list with links to their GitHub repositories.

[Go SDK](https://github.com/blockchyp/blockchyp-go)

[Node.js/JavaScript SDK](https://github.com/blockchyp/blockchyp-js)

[Java SDK](https://github.com/blockchyp/blockchyp-java)

[.net/C# SDK](https://github.com/blockchyp/blockchyp-csharp)

[Ruby SDK](https://github.com/blockchyp/blockchyp-ruby)

[PHP SDK](https://github.com/blockchyp/blockchyp-php)

[Python SDK](https://github.com/blockchyp/blockchyp-python)

[iOS (Objective-C/Swift) SDK](https://github.com/blockchyp/blockchyp-ios)

## Getting a Developer Kit

In order to test your integration with real terminals, you'll need a BlockChyp
Developer Kit. Our kits include a fully functioning payment terminal with
test pin encryption keys. Every kit includes a comprehensive set of test
cards with test cards for every major card brand and entry method, including
Contactless and Contact EMV and mag stripe cards. Each kit also includes
test gift cards for our blockchain gift card system.

Access to BlockChyp's developer program is currently invite only, but you
can request an invitation by contacting our engineering team at **nerds@blockchyp.com**.

You can also view a number of long form demos and learn more about us on our [YouTube Channel](https://www.youtube.com/channel/UCE-iIVlJic_XArs_U65ZcJg).

## Transaction Code Examples

You don't want to read words. You want examples. Here's a quick rundown of the
stuff you can do with the BlockChyp IOS SDK and a few basic examples.

#### Charge

Executes a standard direct preauth and capture.

##### From Objective-C:

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"test"] = @YES;
  request[@"terminalName"] = @"Test Terminal";
  request[@"amount"] = @"55.00";
  [client chargeWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"approved"];
    if (success.boolValue) {
      NSLog(@"Approved");
    }
    NSLog(@"%@: %@", @"authCode", [response objectForKey:@"authCode"])
    NSLog(@"%@: %@", @"authorizedAmount", [response objectForKey:@"authorizedAmount"])
  }];
  [pool drain];
  return 0;
}


```

##### From Swift:

```swift
import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["test"] = true
    request["terminalName"] = "Test Terminal"
    request["amount"] = "55.00"
    client.charge(withRequest: request, handler: { (request, response, error) in
      let approved = response["approved"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Approved")
      }
      NSLog("authCode" + ": " + (response["authCode"] as? String).unsafelyUnwrapped)
      NSLog("authorizedAmount" + ": " + (response["authorizedAmount"] as? String).unsafelyUnwrapped)
    })
  }


```



#### Preauthorization

Executes a preauthorization intended to be captured later.

##### From Objective-C:

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"test"] = @YES;
  request[@"terminalName"] = @"Test Terminal";
  request[@"amount"] = @"27.00";
  [client preauthWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"approved"];
    if (success.boolValue) {
      NSLog(@"Approved");
    }
    NSLog(@"%@: %@", @"authCode", [response objectForKey:@"authCode"])
    NSLog(@"%@: %@", @"authorizedAmount", [response objectForKey:@"authorizedAmount"])
  }];
  [pool drain];
  return 0;
}


```

##### From Swift:

```swift
import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["test"] = true
    request["terminalName"] = "Test Terminal"
    request["amount"] = "27.00"
    client.preauth(withRequest: request, handler: { (request, response, error) in
      let approved = response["approved"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Approved")
      }
      NSLog("authCode" + ": " + (response["authCode"] as? String).unsafelyUnwrapped)
      NSLog("authorizedAmount" + ": " + (response["authorizedAmount"] as? String).unsafelyUnwrapped)
    })
  }


```



#### Terminal Ping

Tests connectivity with a payment terminal.

##### From Objective-C:

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"terminalName"] = @"Test Terminal";
  [client pingWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"success"];
    if (success.boolValue) {
      NSLog(@"Success");
    }
  }];
  [pool drain];
  return 0;
}


```

##### From Swift:

```swift
import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["terminalName"] = "Test Terminal"
    client.ping(withRequest: request, handler: { (request, response, error) in
      let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
    })
  }


```



#### Balance

Checks the remaining balance on a payment method.

##### From Objective-C:

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"test"] = @YES;
  request[@"terminalName"] = @"Test Terminal";
  request[@"cardType"] = [NSNumber numberWithInt:CARD_TYPE_EBT];
  [client balanceWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"success"];
    if (success.boolValue) {
      NSLog(@"Success");
    }
  }];
  [pool drain];
  return 0;
}


```

##### From Swift:

```swift
import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["test"] = true
    request["terminalName"] = "Test Terminal"
    request["cardType"] = [NSNumber numberWithInt:CARD_TYPE_EBT]
    client.balance(withRequest: request, handler: { (request, response, error) in
      let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
    })
  }


```



#### Terminal Clear

Clears the line item display and any in progress transaction.

##### From Objective-C:

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"test"] = @YES;
  request[@"terminalName"] = @"Test Terminal";
  [client clearWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"success"];
    if (success.boolValue) {
      NSLog(@"Success");
    }
  }];
  [pool drain];
  return 0;
}


```

##### From Swift:

```swift
import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["test"] = true
    request["terminalName"] = "Test Terminal"
    client.clear(withRequest: request, handler: { (request, response, error) in
      let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
    })
  }


```



#### Terms & Conditions Capture

Prompts the user to accept terms and conditions.

##### From Objective-C:

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"test"] = @YES;
  request[@"terminalName"] = @"Test Terminal";
  request[@"tcAlias"] = @"hippa";
  request[@"tcName"] = @"HIPPA Disclosure";
  request[@"tcContent"] = @"Full contract text";
  request[@"sigFormat"] = SIGNATURE_FORMAT_PNG;
  request[@"sigWidth"] = @200;
  request[@"sigRequired"] = @YES;
  [client termsAndConditionsWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"success"];
    if (success.boolValue) {
      NSLog(@"Success");
    }
    NSLog(@"%@: %@", @"sig", [response objectForKey:@"sig"])
    NSLog(@"%@: %@", @"sigFile", [response objectForKey:@"sigFile"])
  }];
  [pool drain];
  return 0;
}


```

##### From Swift:

```swift
import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["test"] = true
    request["terminalName"] = "Test Terminal"
    request["tcAlias"] = "hippa"
    request["tcName"] = "HIPPA Disclosure"
    request["tcContent"] = "Full contract text"
    request["sigFormat"] = SIGNATURE_FORMAT_PNG
    request["sigWidth"] = 200
    request["sigRequired"] = true
    client.termsAndConditions(withRequest: request, handler: { (request, response, error) in
      let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
      NSLog("sig" + ": " + (response["sig"] as? String).unsafelyUnwrapped)
      NSLog("sigFile" + ": " + (response["sigFile"] as? String).unsafelyUnwrapped)
    })
  }


```



#### Update Transaction Display

Appends items to an existing transaction display.  Subtotal, Tax, and Total are
overwritten by the request. Items with the same description are combined into
groups.

##### From Objective-C:

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"test"] = @YES;
  request[@"terminalName"] = @"Test Terminal";
  [request setObject:[self newTransactionDisplayTransaction] forKey:@"transaction"];
  [client updateTransactionDisplayWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"success"];
    if (success.boolValue) {
      NSLog(@"Success");
    }
  }];
  [pool drain];
  return 0;
}

- (NSDictionary *) newTransactionDisplayTransaction {
  NSMutableDictionary *val = [[NSMutableDictionary alloc] init];
  val[@"subtotal"] = @"60.00";
  val[@"tax"] = @"5.00";
  val[@"total"] = @"65.00";
  val[@"items"] = [self newTransactionDisplayItems];
  return val;
}
- (NSArray *) newTransactionDisplayItems {
  NSMutableArray *val = [[NSMutableArray alloc] init];
  [val addObject: [self newTransactionDisplayItem2]];
  return val;
}
- (NSDictionary *) newTransactionDisplayItem2 {
  NSMutableDictionary *val = [[NSMutableDictionary alloc] init];
  val[@"description"] = @"Leki Trekking Poles";
  val[@"price"] = @"35.00";
  val[@"extended"] = @"70.00";
  val[@"discounts"] = [self newTransactionDisplayDiscounts];
  return val;
}
- (NSArray *) newTransactionDisplayDiscounts {
  NSMutableArray *val = [[NSMutableArray alloc] init];
  [val addObject: [self newTransactionDisplayDiscount2]];
  return val;
}
- (NSDictionary *) newTransactionDisplayDiscount2 {
  NSMutableDictionary *val = [[NSMutableDictionary alloc] init];
  val[@"description"] = @"memberDiscount";
  val[@"amount"] = @"10.00";
  return val;
}

```

##### From Swift:

```swift
import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["test"] = true
    request["terminalName"] = "Test Terminal"
    request["transaction"] = newTransactionDisplayTransaction()
    client.updateTransactionDisplay(withRequest: request, handler: { (request, response, error) in
      let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
    })
  }

  func newTransactionDisplayTransaction() -> [String:Any] {
    var val: [String:Any] = [:]
  val[@"subtotal"] = @"60.00";
  val[@"tax"] = @"5.00";
  val[@"total"] = @"65.00";
  val[@"items"] = [self newTransactionDisplayItems];
    return val
  }
  func newTransactionDisplayItems()  -> [[String:Any]] {
    var val = [[String:Any]]()
    val.append(newTransactionDisplayItem2())
    return val
  }
  func newTransactionDisplayItem2() -> [String:Any] {
    var val: [String:Any] = [:]
  val[@"description"] = @"Leki Trekking Poles";
  val[@"price"] = @"35.00";
  val[@"extended"] = @"70.00";
  val[@"discounts"] = [self newTransactionDisplayDiscounts];
    return val;
  }
  func newTransactionDisplayDiscounts()  -> [[String:Any]] {
    var val = [[String:Any]]()
    val.append(newTransactionDisplayDiscount2())
    return val
  }
  func newTransactionDisplayDiscount2() -> [String:Any] {
    var val: [String:Any] = [:]
  val[@"description"] = @"memberDiscount";
  val[@"amount"] = @"10.00";
    return val;
  }

```



#### New Transaction Display

Displays a new transaction on the terminal.

##### From Objective-C:

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"test"] = @YES;
  request[@"terminalName"] = @"Test Terminal";
  [request setObject:[self newTransactionDisplayTransaction] forKey:@"transaction"];
  [client newTransactionDisplayWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"success"];
    if (success.boolValue) {
      NSLog(@"Success");
    }
  }];
  [pool drain];
  return 0;
}

- (NSDictionary *) newTransactionDisplayTransaction {
  NSMutableDictionary *val = [[NSMutableDictionary alloc] init];
  val[@"subtotal"] = @"60.00";
  val[@"tax"] = @"5.00";
  val[@"total"] = @"65.00";
  val[@"items"] = [self newTransactionDisplayItems];
  return val;
}
- (NSArray *) newTransactionDisplayItems {
  NSMutableArray *val = [[NSMutableArray alloc] init];
  [val addObject: [self newTransactionDisplayItem2]];
  return val;
}
- (NSDictionary *) newTransactionDisplayItem2 {
  NSMutableDictionary *val = [[NSMutableDictionary alloc] init];
  val[@"description"] = @"Leki Trekking Poles";
  val[@"price"] = @"35.00";
  val[@"extended"] = @"70.00";
  val[@"discounts"] = [self newTransactionDisplayDiscounts];
  return val;
}
- (NSArray *) newTransactionDisplayDiscounts {
  NSMutableArray *val = [[NSMutableArray alloc] init];
  [val addObject: [self newTransactionDisplayDiscount2]];
  return val;
}
- (NSDictionary *) newTransactionDisplayDiscount2 {
  NSMutableDictionary *val = [[NSMutableDictionary alloc] init];
  val[@"description"] = @"memberDiscount";
  val[@"amount"] = @"10.00";
  return val;
}

```

##### From Swift:

```swift
import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["test"] = true
    request["terminalName"] = "Test Terminal"
    request["transaction"] = newTransactionDisplayTransaction()
    client.newTransactionDisplay(withRequest: request, handler: { (request, response, error) in
      let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
    })
  }

  func newTransactionDisplayTransaction() -> [String:Any] {
    var val: [String:Any] = [:]
  val[@"subtotal"] = @"60.00";
  val[@"tax"] = @"5.00";
  val[@"total"] = @"65.00";
  val[@"items"] = [self newTransactionDisplayItems];
    return val
  }
  func newTransactionDisplayItems()  -> [[String:Any]] {
    var val = [[String:Any]]()
    val.append(newTransactionDisplayItem2())
    return val
  }
  func newTransactionDisplayItem2() -> [String:Any] {
    var val: [String:Any] = [:]
  val[@"description"] = @"Leki Trekking Poles";
  val[@"price"] = @"35.00";
  val[@"extended"] = @"70.00";
  val[@"discounts"] = [self newTransactionDisplayDiscounts];
    return val;
  }
  func newTransactionDisplayDiscounts()  -> [[String:Any]] {
    var val = [[String:Any]]()
    val.append(newTransactionDisplayDiscount2())
    return val
  }
  func newTransactionDisplayDiscount2() -> [String:Any] {
    var val: [String:Any] = [:]
  val[@"description"] = @"memberDiscount";
  val[@"amount"] = @"10.00";
    return val;
  }

```



#### Text Prompt

Asks the consumer a text based question.

##### From Objective-C:

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"test"] = @YES;
  request[@"terminalName"] = @"Test Terminal";
  request[@"promptType"] = PROMPT_TYPE_EMAIL;
  [client textPromptWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"success"];
    if (success.boolValue) {
      NSLog(@"Success");
    }
    NSLog(@"%@: %@", @"response", [response objectForKey:@"response"])
  }];
  [pool drain];
  return 0;
}


```

##### From Swift:

```swift
import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["test"] = true
    request["terminalName"] = "Test Terminal"
    request["promptType"] = PROMPT_TYPE_EMAIL
    client.textPrompt(withRequest: request, handler: { (request, response, error) in
      let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
      NSLog("response" + ": " + (response["response"] as? String).unsafelyUnwrapped)
    })
  }


```



#### Boolean Prompt

Asks the consumer a yes/no question.

##### From Objective-C:

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"test"] = @YES;
  request[@"terminalName"] = @"Test Terminal";
  request[@"prompt"] = @"Would you like to become a member?";
  request[@"yesCaption"] = @"Yes";
  request[@"noCaption"] = @"No";
  [client booleanPromptWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"success"];
    if (success.boolValue) {
      NSLog(@"Success");
    }
    NSLog(@"%@: %@", @"response", [response objectForKey:@"response"])
  }];
  [pool drain];
  return 0;
}


```

##### From Swift:

```swift
import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["test"] = true
    request["terminalName"] = "Test Terminal"
    request["prompt"] = "Would you like to become a member?"
    request["yesCaption"] = "Yes"
    request["noCaption"] = "No"
    client.booleanPrompt(withRequest: request, handler: { (request, response, error) in
      let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
      NSLog("response" + ": " + (response["response"] as? String).unsafelyUnwrapped)
    })
  }


```



#### Display Message

Displays a short message on the terminal.

##### From Objective-C:

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"test"] = @YES;
  request[@"terminalName"] = @"Test Terminal";
  request[@"message"] = @"Thank you for your business.";
  [client messageWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"success"];
    if (success.boolValue) {
      NSLog(@"Success");
    }
  }];
  [pool drain];
  return 0;
}


```

##### From Swift:

```swift
import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["test"] = true
    request["terminalName"] = "Test Terminal"
    request["message"] = "Thank you for your business."
    client.message(withRequest: request, handler: { (request, response, error) in
      let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
    })
  }


```



#### Refund

Executes a refund.

##### From Objective-C:

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"terminalName"] = @"Test Terminal";
  request[@"transactionId"] = @"<PREVIOUS TRANSACTION ID>";
  request[@"amount"] = @"5.00";
  [client refundWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"approved"];
    if (success.boolValue) {
      NSLog(@"Approved");
    }
  }];
  [pool drain];
  return 0;
}


```

##### From Swift:

```swift
import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["terminalName"] = "Test Terminal"
    request["transactionId"] = "<PREVIOUS TRANSACTION ID>"
    request["amount"] = "5.00"
    client.refund(withRequest: request, handler: { (request, response, error) in
      let approved = response["approved"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Approved")
      }
    })
  }


```



#### Enroll

Adds a new payment method to the token vault.

##### From Objective-C:

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"test"] = @YES;
  request[@"terminalName"] = @"Test Terminal";
  [client enrollWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"approved"];
    if (success.boolValue) {
      NSLog(@"Approved");
    }
    NSLog(@"%@: %@", @"token", [response objectForKey:@"token"])
  }];
  [pool drain];
  return 0;
}


```

##### From Swift:

```swift
import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["test"] = true
    request["terminalName"] = "Test Terminal"
    client.enroll(withRequest: request, handler: { (request, response, error) in
      let approved = response["approved"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Approved")
      }
      NSLog("token" + ": " + (response["token"] as? String).unsafelyUnwrapped)
    })
  }


```



#### Gift Card Activation

Activates or recharges a gift card.

##### From Objective-C:

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"test"] = @YES;
  request[@"terminalName"] = @"Test Terminal";
  request[@"amount"] = @"50.00";
  [client giftActivateWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"approved"];
    if (success.boolValue) {
      NSLog(@"Approved");
    }
    NSLog(@"%@: %@", @"amount", [response objectForKey:@"amount"])
    NSLog(@"%@: %@", @"currentBalance", [response objectForKey:@"currentBalance"])
    NSLog(@"%@: %@", @"publicKey", [response objectForKey:@"publicKey"])
  }];
  [pool drain];
  return 0;
}


```

##### From Swift:

```swift
import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["test"] = true
    request["terminalName"] = "Test Terminal"
    request["amount"] = "50.00"
    client.giftActivate(withRequest: request, handler: { (request, response, error) in
      let approved = response["approved"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Approved")
      }
      NSLog("amount" + ": " + (response["amount"] as? String).unsafelyUnwrapped)
      NSLog("currentBalance" + ": " + (response["currentBalance"] as? String).unsafelyUnwrapped)
      NSLog("publicKey" + ": " + (response["publicKey"] as? String).unsafelyUnwrapped)
    })
  }


```



#### Time Out Reversal

Executes a manual time out reversal.

We love time out reversals. Don't be afraid to use them whenever a request to a
BlockChyp terminal times out. You have up to two minutes to reverse any
transaction. The only caveat is that you must assign transactionRef values when
you build the original request. Otherwise, we have no real way of knowing which
transaction you're trying to reverse because we may not have assigned it an id
yet. And if we did assign it an id, you wouldn't know what it is because your
request to the terminal timed out before you got a response.

##### From Objective-C:

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"terminalName"] = @"Test Terminal";
  request[@"transactionRef"] = @"<LAST TRANSACTION REF>";
  [client reverseWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"approved"];
    if (success.boolValue) {
      NSLog(@"Approved");
    }
  }];
  [pool drain];
  return 0;
}


```

##### From Swift:

```swift
import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["terminalName"] = "Test Terminal"
    request["transactionRef"] = "<LAST TRANSACTION REF>"
    client.reverse(withRequest: request, handler: { (request, response, error) in
      let approved = response["approved"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Approved")
      }
    })
  }


```



#### Capture Preauthorization

Captures a preauthorization.

##### From Objective-C:

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"test"] = @YES;
  request[@"transactionId"] = @"<PREAUTH TRANSACTION ID>";
  [client captureWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"approved"];
    if (success.boolValue) {
      NSLog(@"Approved");
    }
  }];
  [pool drain];
  return 0;
}


```

##### From Swift:

```swift
import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["test"] = true
    request["transactionId"] = "<PREAUTH TRANSACTION ID>"
    client.capture(withRequest: request, handler: { (request, response, error) in
      let approved = response["approved"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Approved")
      }
    })
  }


```



#### Close Batch

Closes the current credit card batch.

##### From Objective-C:

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"test"] = @YES;
  [client closeBatchWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"success"];
    if (success.boolValue) {
      NSLog(@"Success");
    }
    NSLog(@"%@: %@", @"capturedTotal", [response objectForKey:@"capturedTotal"])
    NSLog(@"%@: %@", @"openPreauths", [response objectForKey:@"openPreauths"])
  }];
  [pool drain];
  return 0;
}


```

##### From Swift:

```swift
import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["test"] = true
    client.closeBatch(withRequest: request, handler: { (request, response, error) in
      let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
      NSLog("capturedTotal" + ": " + (response["capturedTotal"] as? String).unsafelyUnwrapped)
      NSLog("openPreauths" + ": " + (response["openPreauths"] as? String).unsafelyUnwrapped)
    })
  }


```



#### Void Transaction

Discards a previous preauth transaction.

##### From Objective-C:

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"test"] = @YES;
  request[@"transactionId"] = @"<PREVIOUS TRANSACTION ID>";
  [client voidWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"approved"];
    if (success.boolValue) {
      NSLog(@"Approved");
    }
  }];
  [pool drain];
  return 0;
}


```

##### From Swift:

```swift
import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["test"] = true
    request["transactionId"] = "<PREVIOUS TRANSACTION ID>"
    client.void(withRequest: request, handler: { (request, response, error) in
      let approved = response["approved"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Approved")
      }
    })
  }


```



#### Terminal Status

Returns the current status of a terminal.

##### From Objective-C:

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"terminalName"] = @"Test Terminal";
  [client terminalStatusWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"success"];
    if (success.boolValue) {
      NSLog(@"Success");
    }
    NSLog(@"%@: %@", @"idle", [response objectForKey:@"idle"])
    NSLog(@"%@: %@", @"status", [response objectForKey:@"status"])
  }];
  [pool drain];
  return 0;
}


```

##### From Swift:

```swift
import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["terminalName"] = "Test Terminal"
    client.terminalStatus(withRequest: request, handler: { (request, response, error) in
      let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
      NSLog("idle" + ": " + (response["idle"] as? String).unsafelyUnwrapped)
      NSLog("status" + ": " + (response["status"] as? String).unsafelyUnwrapped)
    })
  }


```



#### Capture Signature.

Captures and returns a signature.

##### From Objective-C:

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"terminalName"] = @"Test Terminal";
  request[@"sigFormat"] = SIGNATURE_FORMAT_PNG;
  request[@"sigWidth"] = @200;
  [client captureSignatureWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"success"];
    if (success.boolValue) {
      NSLog(@"Success");
    }
  }];
  [pool drain];
  return 0;
}


```

##### From Swift:

```swift
import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["terminalName"] = "Test Terminal"
    request["sigFormat"] = SIGNATURE_FORMAT_PNG
    request["sigWidth"] = 200
    client.captureSignature(withRequest: request, handler: { (request, response, error) in
      let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
    })
  }


```



#### Update Customer

Updates or creates a customer record.

##### From Objective-C:

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  [request setObject:[self newCustomer] forKey:@"customer"];
  [client updateCustomerWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"success"];
    if (success.boolValue) {
      NSLog(@"Success");
    }
    NSLog(@"%@: %@", @"customer", [response objectForKey:@"customer"])
  }];
  [pool drain];
  return 0;
}

- (NSDictionary *) newCustomer {
  NSMutableDictionary *val = [[NSMutableDictionary alloc] init];
  val[@"id"] = @"ID of the customer to update";
  val[@"customerRef"] = @"Customer reference string";
  val[@"firstName"] = @"FirstName";
  val[@"lastName"] = @"LastName";
  val[@"companyName"] = @"Company Name";
  val[@"emailAddress"] = @"support@blockchyp.com";
  val[@"smsNumber"] = @"(123) 123-1231";
  return val;
}

```

##### From Swift:

```swift
import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["customer"] = newCustomer()
    client.updateCustomer(withRequest: request, handler: { (request, response, error) in
      let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
      NSLog("customer" + ": " + (response["customer"] as? String).unsafelyUnwrapped)
    })
  }

  func newCustomer() -> [String:Any] {
    var val: [String:Any] = [:]
  val[@"id"] = @"ID of the customer to update";
  val[@"customerRef"] = @"Customer reference string";
  val[@"firstName"] = @"FirstName";
  val[@"lastName"] = @"LastName";
  val[@"companyName"] = @"Company Name";
  val[@"emailAddress"] = @"support@blockchyp.com";
  val[@"smsNumber"] = @"(123) 123-1231";
    return val
  }

```



#### Retrieve Customer

Retrieves a customer by id.

##### From Objective-C:

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"customerId"] = @"ID of the customer to retrieve";
  [client customerWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"success"];
    if (success.boolValue) {
      NSLog(@"Success");
    }
    NSLog(@"%@: %@", @"customer", [response objectForKey:@"customer"])
  }];
  [pool drain];
  return 0;
}


```

##### From Swift:

```swift
import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["customerId"] = "ID of the customer to retrieve"
    client.customer(withRequest: request, handler: { (request, response, error) in
      let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
      NSLog("customer" + ": " + (response["customer"] as? String).unsafelyUnwrapped)
    })
  }


```



#### Search Customer

Searches the customer database.

##### From Objective-C:

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"query"] = @"(123) 123-1234";
  [client customerSearchWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"success"];
    if (success.boolValue) {
      NSLog(@"Success");
    }
    NSLog(@"%@: %@", @"customers", [response objectForKey:@"customers"])
  }];
  [pool drain];
  return 0;
}


```

##### From Swift:

```swift
import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["query"] = "(123) 123-1234"
    client.customerSearch(withRequest: request, handler: { (request, response, error) in
      let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
      NSLog("customers" + ": " + (response["customers"] as? String).unsafelyUnwrapped)
    })
  }


```



#### Transaction Status

Retrieves the current status of a transaction.

##### From Objective-C:

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"transactionId"] = @"ID of transaction to retrieve";
  [client transactionStatusWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"success"];
    if (success.boolValue) {
      NSLog(@"Success");
    }
    NSLog(@"%@: %@", @"responseDescription", [response objectForKey:@"responseDescription"])
    NSLog(@"%@: %@", @"authorizedAmount", [response objectForKey:@"authorizedAmount"])
  }];
  [pool drain];
  return 0;
}


```

##### From Swift:

```swift
import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["transactionId"] = "ID of transaction to retrieve"
    client.transactionStatus(withRequest: request, handler: { (request, response, error) in
      let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
      NSLog("responseDescription" + ": " + (response["responseDescription"] as? String).unsafelyUnwrapped)
      NSLog("authorizedAmount" + ": " + (response["authorizedAmount"] as? String).unsafelyUnwrapped)
    })
  }


```



#### Send Payment Link

Creates and send a payment link to a customer.

##### From Objective-C:

```objective-c
#import <Foundation/Foundation.h>
#import <BlockChyp/BlockChyp.h>

int main (int argc, const char * argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  BlockChyp *client = [[BlockChyp alloc]
    initWithApiKey:@"SPBXTSDAQVFFX5MGQMUMIRINVI"
    bearerToken:@"7BXBTBUPSL3BP7I6Z2CFU6H3WQ"
    signingKey:@"bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"];

  NSMutableDictionary *request = [[NSMutableDictionary alloc] init];
  request[@"amount"] = @"199.99";
  request[@"description"] = @"Widget";
  request[@"subject"] = @"Widget invoice";
  [request setObject:[self newTransactionDisplayTransaction] forKey:@"transaction"];
  request[@"autoSend"] = @YES;
  [request setObject:[self newCustomer] forKey:@"customer"];
  [client sendPaymentLinkWithRequest:request handler:^(NSDictionary *request, NSDictionary *response, NSError *error) {
    NSNumber *success = [response objectForKey:@"success"];
    if (success.boolValue) {
      NSLog(@"Success");
    }
    NSLog(@"%@: %@", @"responseDescription", [response objectForKey:@"responseDescription"])
    NSLog(@"%@: %@", @"authorizedAmount", [response objectForKey:@"authorizedAmount"])
  }];
  [pool drain];
  return 0;
}

- (NSDictionary *) newTransactionDisplayTransaction {
  NSMutableDictionary *val = [[NSMutableDictionary alloc] init];
  val[@"subtotal"] = @"195.00";
  val[@"tax"] = @"4.99";
  val[@"total"] = @"199.99";
  val[@"items"] = [self newTransactionDisplayItems];
  return val;
}
- (NSArray *) newTransactionDisplayItems {
  NSMutableArray *val = [[NSMutableArray alloc] init];
  [val addObject: [self newTransactionDisplayItem2]];
  return val;
}
- (NSDictionary *) newTransactionDisplayItem2 {
  NSMutableDictionary *val = [[NSMutableDictionary alloc] init];
  val[@"description"] = @"Widget";
  val[@"price"] = @"195.00";
  return val;
}
- (NSDictionary *) newCustomer {
  NSMutableDictionary *val = [[NSMutableDictionary alloc] init];
  val[@"customerRef"] = @"Customer reference string";
  val[@"firstName"] = @"FirstName";
  val[@"lastName"] = @"LastName";
  val[@"companyName"] = @"Company Name";
  val[@"emailAddress"] = @"support@blockchyp.com";
  val[@"smsNumber"] = @"(123) 123-1231";
  return val;
}

```

##### From Swift:

```swift
import BlockChyp

class ExampleClass {

  func example() {
    let client = BlockChyp.init(
      apiKey: "ZN5WQGX5PN6BE2MF75CEAWRETM",
      bearerToken: "SVVHJCYVFWJR2QKYKFWMZQVZL4",
      signingKey: "7c1b9e4d1308e7bbe76a1920ddd9449ce50af2629f6bb70ed3c110365935970b"
    )

    var request: [String:Any] = [:]
    request["amount"] = "199.99"
    request["description"] = "Widget"
    request["subject"] = "Widget invoice"
    request["transaction"] = newTransactionDisplayTransaction()
    request["autoSend"] = true
    request["customer"] = newCustomer()
    client.sendPaymentLink(withRequest: request, handler: { (request, response, error) in
      let approved = response["success"] as? Bool
      if (approved.unsafelyUnwrapped) {
        NSLog("Success")
      }
      NSLog("responseDescription" + ": " + (response["responseDescription"] as? String).unsafelyUnwrapped)
      NSLog("authorizedAmount" + ": " + (response["authorizedAmount"] as? String).unsafelyUnwrapped)
    })
  }

  func newTransactionDisplayTransaction() -> [String:Any] {
    var val: [String:Any] = [:]
  val[@"subtotal"] = @"195.00";
  val[@"tax"] = @"4.99";
  val[@"total"] = @"199.99";
  val[@"items"] = [self newTransactionDisplayItems];
    return val
  }
  func newTransactionDisplayItems()  -> [[String:Any]] {
    var val = [[String:Any]]()
    val.append(newTransactionDisplayItem2())
    return val
  }
  func newTransactionDisplayItem2() -> [String:Any] {
    var val: [String:Any] = [:]
  val[@"description"] = @"Widget";
  val[@"price"] = @"195.00";
    return val;
  }
  func newCustomer() -> [String:Any] {
    var val: [String:Any] = [:]
  val[@"customerRef"] = @"Customer reference string";
  val[@"firstName"] = @"FirstName";
  val[@"lastName"] = @"LastName";
  val[@"companyName"] = @"Company Name";
  val[@"emailAddress"] = @"support@blockchyp.com";
  val[@"smsNumber"] = @"(123) 123-1231";
    return val
  }

```



## Running Integration Tests

If you'd like to run the integration tests, create a new file on your system
called `sdk-itest-config.json` with the API credentials you'll be using as
shown in the example below.

```
{
 "gatewayHost": "https://api.blockchyp.com",
 "testGatewayHost": "https://test.blockchyp.com",
 "apiKey": "PZZNEFK7HFULCB3HTLA7HRQDJU",
 "bearerToken": "QUJCHIKNXOMSPGQ4QLT2UJX5DI",
 "signingKey": "f88a72d8bc0965f193abc7006bbffa240663c10e4d1dc3ba2f81e0ca10d359f5"
}
```

This file can be located in a few different places, but is usually located
at `<USER_HOME>/.config/blockchyp/sdk-itest-config.json`. All BlockChyp SDKs
use the same configuration file.

To run the integration test suite via `make`, type the following command:

`make integration`


## Running Integration Tests Via the Command Line

If you'd like to run the entire integration test suite from the xcode command line,
open a terminal window and cd your way into the `blockchyp-ios` directory.

From inside the blockchyp-ios directory, run the following command to execute all tests.

```
xcodebuild test -project blockchyp-ios.xcodeproj -scheme Tests -destination 'platform=iOS Simulator,name=iPad (7th generation)'
```

Note that the BC_TEST_DELAY environment variable setting used for most other SDK's
is not used for iOS.  The test delay is built into the Test schema configuration for
iOS.

To exececute a single test, add the `-only-testing` argument as shown in the example below:

```
xcodebuild test -project blockchyp-ios.xcodeproj -scheme Tests -destination 'platform=iOS Simulator,name=iPad (7th generation)' -only-testing:Tests/TerminalChargeTest
```




## Contributions

BlockChyp welcomes contributions from the open source community, but bear in mind
that this repository has been generated by our internal SDK Generator tool. If
we choose to accept a PR or contribution, your code will be moved into our SDK
Generator project, which is a private repository.

## License

Copyright BlockChyp, Inc., 2019

Distributed under the terms of the [MIT] license, blockchyp-ios is free and open source software.

[MIT]: https://github.com/blockchyp/blockchyp-ios/blob/master/LICENSE
