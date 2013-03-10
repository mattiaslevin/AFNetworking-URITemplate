//
//  NSString+RegexpReplace.m
//  URITemplates
//
//  Created by Mattias Levin on 3/10/13.
//  Copyright (c) 2013 Mattias Levin. All rights reserved.
//

#import "NSString+RegexpReplace.h"


@implementation NSString (RegexpReplace)

- (NSString*)stringByReplacingMatches:(NSRegularExpression*)anExpression
                              options:(NSMatchingOptions)options
                                range:(NSRange)range
              withTransformationBlock:(NSString* (^)(NSString *stringToReplace, NSUInteger index, BOOL *stop))block {
  
  NSMutableString *transformedString = [NSMutableString stringWithString:self];
  int offset = 0;
  uint index = 0;
  BOOL shouldStop = false;
  
  NSArray *matches = [anExpression matchesInString:transformedString options:options range:range];
  // Repalce each match
  for (NSTextCheckingResult *match in matches) {
    
    // Adjust the offset give the length of previously replaced strings
    NSRange resultRange = match.range;
    resultRange.location += offset;
    
    // Get the replacement string from the block
    NSString *toReplace = [transformedString substringWithRange:resultRange];
    NSString *replacement = block(toReplace, index, &shouldStop);
    if (nil == replacement) {
      NSLog(@"Error, no replacement string found for match:%@, abort",
            [transformedString substringWithRange:resultRange]);
      
      // TODO How to hande errors
      
      return nil;
    }
    
    [transformedString replaceCharactersInRange:resultRange withString:replacement];
    
    // Check if we should stop
    if (shouldStop) {
      break;
    }
    
    // Calculate new offset andi index
    offset += ([replacement length] - resultRange.length);
    index++;

  }
  
  return transformedString;
}

@end
