//
//  BlockChypTest.m
//  Tests
//
//  Created by Jeff Payne on 12/15/19.
//  Copyright © 2019 Jeff Payne. All rights reserved.
//

#import "BlockChypTest.h"
#import "../BlockChyp/EncodingUtils.h"

@implementation BlockChypTest


-(TestConfiguration*)loadConfiguration {
    
    TestConfiguration *config = [[TestConfiguration alloc]init];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:@"sdk-itest-config" ofType:@"json"];
    NSData *content = [NSData dataWithContentsOfFile:path];
    
    NSString *json = [[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding];
    
    NSDictionary *jsonDict = [EncodingUtils parseJSON:json];
    
    for (NSString* key in jsonDict) {
        [config setValue:[jsonDict valueForKey:key] forKey:key];
    }
    
    return config;
}

-(void)logJSON:(NSDictionary *)dict {
    if ([NSJSONSerialization isValidJSONObject:dict])
    {
      NSError *error;
      NSString *json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
     
      // If no errors, let's view the JSON
      if (json != nil && error == nil)
      {
        NSString *jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
     
        NSLog(@"JSON: %@", jsonString);
      }
    }
}

@end
