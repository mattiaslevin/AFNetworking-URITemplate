//
//  AFHTTPClient+URITemplate.h
//  URITemplates
//
//  Created by Mattias Levin on 3/10/13.
//  Copyright (c) 2013 Mattias Levin. All rights reserved.
//

#import "AFHTTPClient.h"


/**
 The AFNetworking-URITemplate category provides methods for the AFHTTPClient class that support URI template expansion of relevant methods.
 
 Two types of template expansions are supported:
 
 * Using a NSDictonary - using the name of the URI variable to find a replacement string in the dictionary
 * Variable argument list (variadic) - replace the URI variables with the variables provided in the argument list in the same order as they appear. The list must be nil terminated
 
 Both methods provide the same level of functionality. Which one to is best to use depends on the context and developer preference.
 
 ## Examples
 
     // Create request using variable argument list
     NSMutableURLRequest *request = [self requestWithMethod:@"GET"
                                                       path:@"user/{user}/albumid/{albumId}"
                                                HTTPHeaders:nil
                                                   HTTPBody:nil
                                               URIVariables:user, albumId, nil];
     // Create request using dictionary
     NSDictonary *replacements = @{
                                    @"user" : @"MyName",
                                    @"albumId" : @"12345"
                                  };
     NSMutableURLRequest *request = [self requestWithMethod:@"GET"
                                                       path:@"user/{user}/albumid/{albumId}"
                                                HTTPHeaders:nil
                                                   HTTPBody:nil
                                               URIVariables:replacements];
 
 */
@interface AFHTTPClient (URITemplate)


/** @name Creating Request Objects */

/**
 Create a `NSMutableURLRequest` using template expansion from a `NSDictionary`.
 
 The name of the URI variable will be used as key to look up the replacement value in the provided dictionary. If the key is not found in the dictionary the variable will not be expanded.
 
 @param method The metod type, e.g. GET, POST, PUT etc
 @param path The path to be expanded, e.g. @"/api/rnr/product/{productId}/rating/{rating}
 @param HTTPHeaders The headers will be merged with any default headers set in the http client. Will override any existing default value.
 @param HTTPBody The body to send in the request. Some methods does not use the body, e.g. GET
 @param URIVariables Template URI variables will used as keys to get the replacement variable from this dictionary.
 
 @return A mutable url request that be be used by the http client to make requests.
 */
- (NSMutableURLRequest*)requestWithMethod:(NSString*)method
                                     path:(NSString*)path
                              HTTPHeaders:(NSDictionary*)HTTPHeaders
                                 HTTPBody:(NSDictionary*)HTTPBody
                         URIVariablesDict:(NSDictionary*)URIVariables;

/**
 Create a `NSMutableURLRequest` using template expansion from a variable argument list (variadic).
 
 The URI variable will be replaced by the provided arguments in the variable argument list in the same order as they appear.
 
 @param method The metod type, e.g. GET, POST, PUT etc
 @param path The path to be expanded, e.g. @"/api/rnr/product/{productId}/rating/{rating}
 @param HTTPHeaders The headers will be merged with any default headers set in the http client. Will override any existing default value.
 @param HTTPBody The body to send in the request. Some methods does not use the body, e.g. GET
 @param URIVariable Variable arguments list that will replace the URI variables. Must be nil terminated.
 
 @return A mutable url request that be be used by the http client to make requests.
 */
- (NSMutableURLRequest*)requestWithMethod:(NSString*)method
                                     path:(NSString*)path
                              HTTPHeaders:(NSDictionary*)HTTPHeaders
                                 HTTPBody:(NSDictionary*)HTTPBody
                             URIVariables:(NSString*)URIVariable, ...;


/** @name Making HTTP Requests */


/**
 Create `GET` request using dictionary variable expansion and add it to the operation queue.
 
 See AFHTTPClient for additional details.
 */
- (void)getPath:(NSString*)path
            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
    URIVariablesDict:(NSDictionary*)URIVariables;

/**
 Create `GET` request using variable argument list expansion and add it to the operation queue.
 
 See AFHTTPClient for additional details.
 */
- (void)getPath:(NSString*)path
            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
       URIVariables:(NSString*)URIVariable, ...;

/**
 Create `POST` request using dictionary variable expansion and add it to the operation queue.
 
 See AFHTTPClient for additional details.
 */
- (void)postPath:(NSString*)path
        HTTPBody:(NSDictionary*)HTTPbody
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
URIVariablesDict:(NSDictionary*)URIVariables;

/**
 Create `POST` request using variable argument list expansion and add it to the operation queue.
 
 See AFHTTPClient for additional details.
 */
- (void)postPath:(NSString*)path
        HTTPBody:(NSDictionary*)HTTPbody
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
    URIVariables:(NSString*)URIVariable, ...;


/**
 Create `PUT` request using dictionary variable expansion and add it to the operation queue.
 
 See AFHTTPClient for additional details.
 */
- (void)putPath:(NSString*)path
        HTTPBody:(NSDictionary*)HTTPbody
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
URIVariablesDict:(NSDictionary*)URIVariables;


/**
 Create `PUT` request using variable argument list expansion and add it to the operation queue.
 
 See AFHTTPClient for additional details.
 */
- (void)putPath:(NSString*)path
        HTTPBody:(NSDictionary*)HTTPbody
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
    URIVariables:(NSString*)URIVariable, ...;


/**
 Create `DELETE` request using dictionary variable expansion and add it to the operation queue.
 
 See AFHTTPClient for additional details.
 */
- (void)deletePath:(NSString*)path
           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
  URIVariablesDict:(NSDictionary*)URIVariables;


/**
 Create `DELETE` request using variable argument list expansion and add it to the operation queue.
 
 See AFHTTPClient for additional details.
 */
- (void)deletePath:(NSString*)path
           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
      URIVariables:(NSString*)URIVariable, ...;


/**
 Create `PATCH` request using dictionary variable expansion and add it to the operation queue.
 
 See AFHTTPClient for additional details.
 */
- (void)patchPath:(NSString*)path
          HTTPBody:(NSDictionary*)HTTPbody
           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
  URIVariablesDict:(NSDictionary*)URIVariables;


/**
 Create `PATCH` request using variable argument list expansion and add it to the operation queue.
 
 See AFHTTPClient for additional details.
 */
- (void)patchPath:(NSString*)path
         HTTPBody:(NSDictionary*)HTTPbody
          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
     URIVariables:(NSString*)URIVariable, ...;


// Expand a path using URI template variables

/**
 Expand a path or string using dictionary variable expansion.
 
 @param path The path to expand.
 @param URIVariables Template URI variables will used as keys to get the replacement variable from this dictionary.
 
 @return Expanded path.
 */
- (NSString*)expandPath:(NSString*)path withURIVariableDict:(NSDictionary*)URIVariables;


/**
 Expand a path or string using variable argument list expansion.
 
 @param path The path to expand.
 @param URIVariable Variable arguments list that will replace the URI variables. Must be nil terminated.
 
 @return Expanded path.
 */
- (NSString*)expandPath:(NSString*)path withURIVariables:(NSString*)URIVariable, ...;


@end
