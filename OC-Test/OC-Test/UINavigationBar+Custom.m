//
//  UINavigationBar+Custom.m
//  Anonymous_friends
//
//  Created by 叶世昌 on 2019/1/5.
//  Copyright © 2019 Luomi. All rights reserved.
//

#import "UINavigationBar+Custom.h"
#import "objc/runtime.h"

static char const *const heightKey = "Height";

@implementation UINavigationBar (Custom)

- (void)setHeight:(CGFloat)height
{
    objc_setAssociatedObject(self, heightKey, @(height), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)height
{
    return objc_getAssociatedObject(self, heightKey);
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize newSize;
    
    if (self.height) {
        newSize = CGSizeMake(self.superview.bounds.size.width, [self.height floatValue]);
    } else {
        newSize = [super sizeThatFits:size];
    }
    
    return newSize;
}


@end
