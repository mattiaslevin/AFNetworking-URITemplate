//
//  AFHTTPClient+URITemplate.m
//  URITemplates
//
//  Created by Mattias Levin on 3/10/13.
//  Copyright (c) 2013 Mattias Levin. All rights reserved.
//

#import "AFHTTPClient+URITemplate.h"
#import "NSString+RegexpReplace.h"


#define PATTERN  @"(\\{.+?\\})"


// Private stuff
@interface AFHTTPClient (URITemplatePrivate)

- (NSMutableURLRequest*)requestWithMethod:(NSString*)method
                             expandedPath:(NSString*)path
                              HTTPHeaders:(NSDictionary*)HTTPHeaders
                                 HTTPBody:(NSDictionary*)HTTPBody;

- (NSString*)expandPath:(NSString*)path withURIVariablesArray:(NSArray*)URIVariables;

@end


// Implementation
@implementation AFHTTPClient (URITemplate)


// URL encode a parameter
// Copied from AFHTTPClient since function can not be reached
static NSString * AFPercentEscapedQueryStringPairMemberFromStringWithEncoding(NSString *string, NSStringEncoding encoding) {
  static NSString * const kAFCharactersToBeEscaped = @":/?&=;+!@#$()~";
  static NSString * const kAFCharactersToLeaveUnescaped = @"[].";
  
	return (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, (__bridge CFStringRef)kAFCharactersToLeaveUnescaped, (__bridge CFStringRef)kAFCharactersToBeEscaped, CFStringConvertNSStringEncodingToEncoding(encoding));
}


#pragma mark - Create url requests

// Create an url request using URI template and a dic
- (NSMutableURLRequest*)requestWithMethod:(NSString*)method
                                     path:(NSString*)path
                              HTTPHeaders:(NSDictionary*)HTTPHeaders
                                 HTTPBody:(NSDictionary*)HTTPBody
                         URIVariablesDict:(NSDictionary*)URIVariables {
  
  // Expand uri variables
  NSString *expandedPath = [self expandPath:path withURIVariableDict:URIVariables];
  NSLog(@"Expanded path:%@", expandedPath);

  return [self requestWithMethod:method expandedPath:expandedPath HTTPHeaders:HTTPHeaders HTTPBody:HTTPBody];
}


// Create an url request using URI template and var args
- (NSMutableURLRequest*)requestWithMethod:(NSString*)method
                                     path:(NSString*)path
                              HTTPHeaders:(NSDictionary*)HTTPHeaders
                                 HTTPBody:(NSDictionary*)HTTPBody
                             URIVariables:(NSString*)URIVariable, ... {
  
  // Collect var args
  NSMutableArray *URIVariables = [NSMutableArray array];
  va_list args;
  va_start(args, URIVariable);
  for (NSString *arg = URIVariable; arg != nil; arg = va_arg(args, NSString*))
  {
    [URIVariables addObject:arg];
  }
  va_end(args);

  // Expand uri variables
  NSString *expandedPath = [self expandPath:path withURIVariablesArray:URIVariables];
  NSLog(@"Expanded path:%@", expandedPath);
      
  return [self requestWithMethod:method expandedPath:expandedPath HTTPHeaders:HTTPHeaders HTTPBody:HTTPBody];
}


// Private method that takes an already expanded path
- (NSMutableURLRequest*)requestWithMethod:(NSString*)method
                             expandedPath:(NSString*)path
                              HTTPHeaders:(NSDictionary*)HTTPHeaders
                                 HTTPBody:(NSDictionary*)HTTPBody {
  
  // Create request
  NSMutableURLRequest *request = nil;
  if ([method isEqualToString:@"GET"] || [method isEqualToString:@"HEAD"] || [method isEqualToString:@"DELETE"]) {
    request = [self requestWithMethod:method path:path parameters:nil];
  } else {
    request = [self requestWithMethod:method path:path parameters:HTTPBody];
  }
  
  // Add headers
  if (nil != HTTPHeaders) {
    // Combine default headers with provided headers
    // Provided headers will override any exising values set by the default headers
    NSMutableDictionary *combinedHeaders = [NSMutableDictionary dictionaryWithDictionary:request.allHTTPHeaderFields];
    [combinedHeaders addEntriesFromDictionary:HTTPHeaders];
    
    request.allHTTPHeaderFields = combinedHeaders;
  }
  
  return request;
}

#pragma mark - Get path

// Get reource for path using URI template and dict
- (void)getPath:(NSString*)path
            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
   URIVariablesDict:(NSDictionary*)URIVariables {
  
  // Expand uri variables
  NSString *expandedPath = [self expandPath:path withURIVariableDict:URIVariables];
  NSLog(@"Expanded path:%@", expandedPath);
  
  return [self getPath:expandedPath parameters:nil success:success failure:failure];  
}


// Get reource for path using URI template and var args
- (void)getPath:(NSString*)path
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
   URIVariables:(NSString*)URIVariable, ... {
  
  // Collect var args
  NSMutableArray *URIVariables = [NSMutableArray array];
  va_list args;
  va_start(args, URIVariable);
  for (NSString *arg = URIVariable; arg != nil; arg = va_arg(args, NSString*))
  {
    [URIVariables addObject:arg];
  }
  va_end(args);
  
  // Expand uri variables
  NSString *expandedPath = [self expandPath:path withURIVariablesArray:URIVariables];
  NSLog(@"Expanded path:%@", expandedPath);
  
  return [self getPath:expandedPath parameters:nil success:success failure:failure];  
}


#pragma mark - Post path

// Post reource for path using URI template and dict
- (void)postPath:(NSString*)path
           HTTPBody:(NSDictionary*)HTTPbody
            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
   URIVariablesDict:(NSDictionary*)URIVariables {
  
  // Expand uri variables
  NSString *expandedPath = [self expandPath:path withURIVariableDict:URIVariables];
  NSLog(@"Expanded path:%@", expandedPath);
  
  return [self postPath:expandedPath parameters:HTTPbody success:success failure:failure];
}


// Post reource for path using URI template and var args
- (void)postPath:(NSString*)path
          HTTPBody:(NSDictionary*)HTTPbody
           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
      URIVariables:(NSString*)URIVariable, ... {
  
  // Collect var args
  NSMutableArray *URIVariables = [NSMutableArray array];
  va_list args;
  va_start(args, URIVariable);
  for (NSString *arg = URIVariable; arg != nil; arg = va_arg(args, NSString*))
  {
    [URIVariables addObject:arg];
  }
  va_end(args);
  
  // Expand uri variables
  NSString *expandedPath = [self expandPath:path withURIVariablesArray:URIVariables];
  NSLog(@"Expanded path:%@", expandedPath);
  
  return [self postPath:expandedPath parameters:HTTPbody success:success failure:failure];
}


#pragma mark - Put path

// Put reource for path using URI template and dict
- (void)putPath:(NSString*)path
           HTTPBody:(NSDictionary*)HTTPbody
            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
   URIVariablesDict:(NSDictionary*)URIVariables {
  
  // Expand uri variables
  NSString *expandedPath = [self expandPath:path withURIVariableDict:URIVariables];
  NSLog(@"Expanded path:%@", expandedPath);
  
  return [self putPath:expandedPath parameters:HTTPbody success:success failure:failure];
}


// Put reource for path using URI template and var args
- (void)putPath:(NSString*)path
            HTTPBody:(NSDictionary*)HTTPbody
             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
        URIVariables:(NSString*)URIVariable, ... {
  
  // Collect var args
  NSMutableArray *URIVariables = [NSMutableArray array];
  va_list args;
  va_start(args, URIVariable);
  for (NSString *arg = URIVariable; arg != nil; arg = va_arg(args, NSString*))
  {
    [URIVariables addObject:arg];
  }
  va_end(args);
  
  // Expand uri variables
  NSString *expandedPath = [self expandPath:path withURIVariablesArray:URIVariables];
  NSLog(@"Expanded path:%@", expandedPath);
  
  return [self putPath:expandedPath parameters:HTTPbody success:success failure:failure];
}


#pragma mark - Delete path

// Delete reource for path using URI template and dict
- (void)deletePath:(NSString*)path
           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
  URIVariablesDict:(NSDictionary*)URIVariables {
  
  // Expand uri variables
  NSString *expandedPath = [self expandPath:path withURIVariableDict:URIVariables];
  NSLog(@"Expanded path:%@", expandedPath);
  
  return [self deletePath:expandedPath parameters:nil success:success failure:failure];
}


// Delete reource for path using URI template and var args
- (void)deletePath:(NSString*)path
           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
      URIVariables:(NSString*)URIVariable, ... {
  
  // Collect var args
  NSMutableArray *URIVariables = [NSMutableArray array];
  va_list args;
  va_start(args, URIVariable);
  for (NSString *arg = URIVariable; arg != nil; arg = va_arg(args, NSString*))
  {
    [URIVariables addObject:arg];
  }
  va_end(args);
  
  // Expand uri variables
  NSString *expandedPath = [self expandPath:path withURIVariablesArray:URIVariables];
  NSLog(@"Expanded path:%@", expandedPath);
  
  return [self deletePath:expandedPath parameters:nil success:success failure:failure];
}


#pragma mark - Patch path

// Patch reource for path using URI template and dict
- (void)patchPath:(NSString*)path
         HTTPBody:(NSDictionary*)HTTPbody
          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
 URIVariablesDict:(NSDictionary*)URIVariables {
  
  // Expand uri variables
  NSString *expandedPath = [self expandPath:path withURIVariableDict:URIVariables];
  NSLog(@"Expanded path:%@", expandedPath);
  
  return [self patchPath:expandedPath parameters:HTTPbody success:success failure:failure];
}


// Patch reource for path using URI template and var args
- (void)patchPath:(NSString*)path
         HTTPBody:(NSDictionary*)HTTPbody
          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
     URIVariables:(NSString*)URIVariable, ... {
  
  // Collect var args
  NSMutableArray *URIVariables = [NSMutableArray array];
  va_list args;
  va_start(args, URIVariable);
  for (NSString *arg = URIVariable; arg != nil; arg = va_arg(args, NSString*))
  {
    [URIVariables addObject:arg];
  }
  va_end(args);
  
  // Expand uri variables
  NSString *expandedPath = [self expandPath:path withURIVariablesArray:URIVariables];
  NSLog(@"Expanded path:%@", expandedPath);
  
  return [self patchPath:expandedPath parameters:HTTPbody success:success failure:failure];
}


#pragma mark - Expand path

// Expand a path using a dictonary of replacement variables
- (NSString*)expandPath:(NSString*)path withURIVariableDict:(NSDictionary*)URIVariables {
    
  NSError *error = NULL;
  // Match all {...} in the path
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:PATTERN
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:&error];
  if (nil != error) {
    NSLog(@"Regular expression failed with reason:%@", error);
    
    // TODO handle regular expresssion errors
  }
  
  NSString *expandedPath =
  [path stringByReplacingMatches:regex
                         options:0 range:NSMakeRange(0, [path length])
         withTransformationBlock:^NSString *(NSString *stringToReplace, NSUInteger index, BOOL *stop) {
           //NSLog(@"Find replacement for:%@", stringToReplace);
                                    
           // Get the replacement string from the dictonary
           NSString *replacement = [URIVariables valueForKey:[stringToReplace substringWithRange:NSMakeRange(1, stringToReplace.length - 2)]];
           if (nil == replacement) {
             
             // TODO How to handle filed expland?
             
             NSLog(@"Warning, variable:%@ not found in dictonary, will expand to empty string", stringToReplace);
             return @"";
           }
           
           // URL encode the replacement string
           return AFPercentEscapedQueryStringPairMemberFromStringWithEncoding(replacement, self.stringEncoding);
         }];

  //NSLog(@"Path:%@ Dict:%@ Expanded:%@", path, URIVariables, expandedPath);
  return expandedPath;
}


// Expand a path using variable arguments
- (NSString*)expandPath:(NSString*)path withURIVariables:(NSString*)URIVariable, ... {
  
  // Collect var args
  NSMutableArray *replacements = [NSMutableArray array];
  va_list args;
  va_start(args, URIVariable);
  for (NSString *arg = URIVariable; arg != nil; arg = va_arg(args, NSString*))
  {
    [replacements addObject:arg];
  }
  va_end(args);
  
  return [self expandPath:path withURIVariablesArray:replacements];
}


// Expand a path using array
- (NSString*)expandPath:(NSString*)path withURIVariablesArray:(NSArray*)URIVariables {
  
  NSError *error = NULL;
  // Match all {...} in the path
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:PATTERN
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:&error];
  if (nil != error) {
    NSLog(@"Regular expression failed with reason:%@", error);
    
    // TODO handle regular expresssion errors
  }
  
  NSString *expandedPath =
  [path stringByReplacingMatches:regex
                         options:0
                           range:NSMakeRange(0, [path length])
         withTransformationBlock:^NSString *(NSString *stringToReplace, NSUInteger index, BOOL *stop) {
           // Get the replacement string from collected var ags
           
           if (index >= [URIVariables count]) {
             
            // TODO How to handle filed expland?
             
             NSLog(@"Warning, variable:%@ not found in var args, will expand to empty string", stringToReplace);
             return @"";
           }
           
           // URL encode the replacement string
           return  AFPercentEscapedQueryStringPairMemberFromStringWithEncoding([URIVariables objectAtIndex:index],
                                                                               self.stringEncoding);
         }];
  
  //NSLog(@"Path:%@ Var args:%@ Expanded:%@", path, replacements, expandedPath);
  return expandedPath;  
}


@end


  
  
