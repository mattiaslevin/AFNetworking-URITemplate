//
//  AFHTTPClient+URITemplateTests.m
//  URITemplates
//
//  Created by Mattias Levin on 3/10/13.
//  Copyright (c) 2013 Mattias Levin. All rights reserved.
//

#import "AFHTTPClient+URITemplateTests.h"
#import "AFHTTPClient.h"
#import "AFHTTPClient+URITemplate.h"


# define TEST_BASE_URL @"http://ww.dn.se"


@interface AFHTTPClient_URITemplateTests ()

@property (strong, nonatomic) AFHTTPClient *testHTTPClient;

@end


@implementation AFHTTPClient_URITemplateTests


#pragma mark - Test setup

- (void)setUp{
  [super setUp];
  
  // Create a http client
  self.testHTTPClient = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:TEST_BASE_URL]];
}


- (void)tearDown {
  self.testHTTPClient = nil;
  
  [super tearDown];
}


#pragma mark - Create request using dict

// Create GET request
- (void)testGetRequestWithDict {
  NSDictionary *URIVariables = @{
    @"replace1" : @"expanded1",
    @"replace2" : @"expanded2"
  };
  
  NSURLRequest *request =
  [self.testHTTPClient requestWithMethod:@"GET"
                                    path:@"/path/{replace1}/path/{replace2}/path"
                             HTTPHeaders:nil
                                HTTPBody:nil
                        URIVariablesDict:URIVariables];
  NSString *url = request.URL.absoluteString;
  
  STAssertTrue([url isEqualToString:@"http://ww.dn.se/path/expanded1/path/expanded2/path"],
                @"URL request expand with dict failed");
  STAssertNil(request.HTTPBody, @"HTTP body should be nil");
}

// Create POST request with body
- (void)testPostRequestWithBodyWithDict {
  NSDictionary *URIVariables = @{
    @"replace1" : @"expanded1",
    @"replace2" : @"expanded2"
  };
  
  NSDictionary *body = @{
    @"param1" : @"value1",
    @"param2" : @"value2",
  };
  
  NSURLRequest *request =
  [self.testHTTPClient requestWithMethod:@"POST"
                                    path:@"/path/{replace1}/path/{replace2}/path"
                             HTTPHeaders:nil
                                HTTPBody:body
                        URIVariablesDict:URIVariables];
  NSString *url = request.URL.absoluteString;
  
  STAssertTrue([url isEqualToString:@"http://ww.dn.se/path/expanded1/path/expanded2/path"],
               @"URL request expand with dict failed");
  STAssertNotNil(request.HTTPBody, @"HTTP body should be nil");
}


// Create DELETE request
- (void)testDeleteRequestWithDict {
  NSDictionary *URIVariables = @{
    @"replace1" : @"expanded1",
    @"replace2" : @"expanded2"
  };
  
  // Body should not be set for Delete
  NSDictionary *body = @{
    @"param1" : @"value1",
    @"param2" : @"value2",
  };
  
  // Body should not be set for Delete
  NSDictionary *headers = @{
    @"My-Header" : @"Value",
  };

  
  NSURLRequest *request =
  [self.testHTTPClient requestWithMethod:@"DELETE"
                                    path:@"/path/{replace1}/path/{replace2}/path"
                             HTTPHeaders:headers
                                HTTPBody:body
                        URIVariablesDict:URIVariables];
  NSString *url = request.URL.absoluteString;
  
  STAssertTrue([url isEqualToString:@"http://ww.dn.se/path/expanded1/path/expanded2/path"],
               @"URL request expand with dict failed");
  STAssertNil(request.HTTPBody, @"HTTP body should be nil");
  
  // Check header
  STAssertNotNil([request.allHTTPHeaderFields objectForKey:@"My-Header"], @"Header not set");
}


#pragma mark - Create request using var arge

// Create GET request
- (void)testGetRequestWitVarArgs {
  
  NSURLRequest *request =
  [self.testHTTPClient requestWithMethod:@"GET"
                                    path:@"/path/{replace1}/path/{replace2}/path"
                             HTTPHeaders:nil
                                HTTPBody:nil
                            URIVariables:@"expanded1", @"expanded2", nil];
  NSString *url = request.URL.absoluteString;
  
  STAssertTrue([url isEqualToString:@"http://ww.dn.se/path/expanded1/path/expanded2/path"],
               @"URL request expand with dict failed");
  STAssertNil(request.HTTPBody, @"HTTP body should be nil");
}


#pragma mark - String expand using dict

// Expand path using dict
- (void)testPathExpandWithDict {
  
  NSDictionary *URIVariables = @{
    @"variable1" : @"expanded1",
    @"variable2" : @"expanded2"
  };
  
  NSString *expandedPath = [AFHTTPClient expandPath:@"/path/{variable1}/path/{variable2}" withURIVariableDict:URIVariables];
  STAssertTrue([expandedPath isEqualToString:@"/path/expanded1/path/expanded2"], @"Path expand with dict failed");
}

// Expand path using dict, missing variable
- (void)testMissingPathExpandWithDict {
  
  NSDictionary *URIVariables = @{
    @"variable1" : @"expanded1",
  };
  
  NSString *expandedPath = [AFHTTPClient expandPath:@"/path/{variable1}/path/{variable2}" withURIVariableDict:URIVariables];
  STAssertTrue([expandedPath isEqualToString:@"/path/expanded1/path/"], @"Path expand with dict failed");
}

// Expand path using dict, no match
- (void)testNoMatchPathExpandWithDict {
  
  NSDictionary *URIVariables = @{
  @"variable1" : @"expanded1",
  @"variable2" : @"expanded2"
  };
  
  NSString *expandedPath = [AFHTTPClient expandPath:@"/path/variable1/path/variable2" withURIVariableDict:URIVariables];
  STAssertTrue([expandedPath isEqualToString:@"/path/variable1/path/variable2"], @"Path expand with dict failed");
}

// Expand path using dict, dict nill
- (void)testNilPathExpandWithDict {
  
  NSDictionary *URIVariables = nil;
  
  NSString *expandedPath = [AFHTTPClient expandPath:@"/path/{variable1}/path/{variable2}" withURIVariableDict:URIVariables];
  STAssertTrue([expandedPath isEqualToString:@"/path//path/"], @"Path expand with dict failed");
}


#pragma mark - String expand using var args

// Expand path using variable arguments
- (void)testBasicPathExpandWithVarArgs {
    
  NSString *expandedPath = [AFHTTPClient expandPath:@"/path/{variable1}/path/{variable2}"
                                   withURIVariables:@"expanded1", @"expanded2", nil];
  STAssertTrue([expandedPath isEqualToString:@"/path/expanded1/path/expanded2"], @"Path expand with var args failed");
}


// Expand path using variable arguments, out of bounds
- (void)testOutOfBoundsPathExpandWithVarArgs {
  
  NSString *expandedPath = [AFHTTPClient expandPath:@"/path/{variable1}/path/{variable2}"
                                   withURIVariables:@"expanded1", nil];
  STAssertTrue([expandedPath isEqualToString:@"/path/expanded1/path/"], @"Path expand with var args failed");
}

// Expand path using variable arguments, no match
- (void)testNoMatchPathExpandWithVarArgs {
  
  NSString *expandedPath = [AFHTTPClient expandPath:@"/path/variable1/path/variable2"
                                   withURIVariables:@"expanded1", @"expanded2", nil];
  STAssertTrue([expandedPath isEqualToString:@"/path/variable1/path/variable2"], @"Path expand with var args failed");
}

// Expand path using variable arguments, extra arguments
- (void)testExtraPathExpandWithVarArgs {
  
  NSString *expandedPath = [AFHTTPClient expandPath:@"/path/{variable1}/path/{variable2}"
                                   withURIVariables:@"expanded1", @"expanded2", @"expanded3", @"expanded4", nil];
  STAssertTrue([expandedPath isEqualToString:@"/path/expanded1/path/expanded2"], @"Path expand with var args failed");
}

// Expand path using variable arguments, no arguments
- (void)testNilPathExpandWithVarArgs {
  
  NSString *expandedPath = [AFHTTPClient expandPath:@"/path/{variable1}/path/{variable2}"
                                   withURIVariables:nil];
  STAssertTrue([expandedPath isEqualToString:@"/path//path/"], @"Path expand with var args failed");
}



@end
