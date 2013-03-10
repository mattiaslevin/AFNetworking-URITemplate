//
//  NSString+RegexpReplace.h
//  URITemplates
//
//  Created by Mattias Levin on 3/10/13.
//  Copyright (c) 2013 Mattias Levin. All rights reserved.
//

#import <Foundation/Foundation.h>


// Category for easy string replacement using regular expression
@interface NSString (RegexpReplace)

// Replace each match individually with a unique replacement string
- (NSString*)stringByReplacingMatches:(NSRegularExpression*)anExpression
                              options:(NSMatchingOptions)options
                                range:(NSRange)range
              withTransformationBlock:(NSString* (^)(NSString *stringToReplace, NSUInteger index, BOOL *stop))block;

@end


