//
//  NSstring+Contains.m
//  AtrributedString
//
//  Created by Admin on 03/08/16.
//  Copyright © 2016 Paymate. All rights reserved.
//

#import "NSstring+Contains.h"

@implementation NSString (Contains)

- (BOOL)myContainsString:(NSString*)other {
    NSRange range = [self rangeOfString:other];
    return range.length != 0;
}

@end
