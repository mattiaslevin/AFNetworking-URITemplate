//
//  AFHTTPClient+URITemplate.h
//  URITemplates
//
//  Created by Mattias Levin on 3/10/13.
//  Copyright (c) 2013 Mattias Levin. All rights reserved.
//

#import "AFHTTPClient.h"

@interface AFHTTPClient (URITemplate)

// Create URL request
- (NSMutableURLRequest*)requestWithMethod:(NSString*)method
                                     path:(NSString*)path
                              HTTPHeaders:(NSDictionary*)HTTPHeaders
                                 HTTPBody:(NSDictionary*)HTTPBody
                         URIVariablesDict:(NSDictionary*)URIVariables;

- (NSMutableURLRequest*)requestWithMethod:(NSString*)method
                                     path:(NSString*)path
                              HTTPHeaders:(NSDictionary*)HTTPHeaders
                                 HTTPBody:(NSDictionary*)HTTPBody
                             URIVariables:(NSString*)URIVariable, ...;

// GET
- (void)getPath:(NSString*)path
            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
    URIVariablesDict:(NSDictionary*)URIVariables;

- (void)getPath:(NSString*)path
            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
       URIVariables:(NSString*)URIVariable, ...;

// POST
- (void)postPath:(NSString*)path
        HTTPBody:(NSDictionary*)HTTPbody
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
URIVariablesDict:(NSDictionary*)URIVariables;

- (void)postPath:(NSString*)path
        HTTPBody:(NSDictionary*)HTTPbody
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
    URIVariables:(NSString*)URIVariable, ...;

// PUT
- (void)putPath:(NSString*)path
        HTTPBody:(NSDictionary*)HTTPbody
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
URIVariablesDict:(NSDictionary*)URIVariables;

- (void)putPath:(NSString*)path
        HTTPBody:(NSDictionary*)HTTPbody
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
    URIVariables:(NSString*)URIVariable, ...;

// DELETE
- (void)deletePath:(NSString*)path
           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
  URIVariablesDict:(NSDictionary*)URIVariables;

- (void)deletePath:(NSString*)path
           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
      URIVariables:(NSString*)URIVariable, ...;

// PATCH
- (void)patchPath:(NSString*)path
          HTTPBody:(NSDictionary*)HTTPbody
           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
  URIVariablesDict:(NSDictionary*)URIVariables;

- (void)patchPath:(NSString*)path
         HTTPBody:(NSDictionary*)HTTPbody
          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
     URIVariables:(NSString*)URIVariable, ...;


// Expand a path using URI template variables
- (NSString*)expandPath:(NSString*)path withURIVariableDict:(NSDictionary*)URIVariables;
- (NSString*)expandPath:(NSString*)path withURIVariables:(NSString*)URIVariable, ...;
- (NSString*)expandPath:(NSString*)path withURIVariablesArray:(NSArray*)URIVariables;

@end
