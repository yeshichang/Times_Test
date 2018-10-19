//
//  Tools.h
//  特效相机
//
//  Created by 叶世昌 on 2018/10/18.
//  Copyright © 2018 Luomi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tools : NSObject

+ (unsigned char *)convertUIImageToData:(UIImage *)image;

+ (UIImage *)convertDataToUIImage:(unsigned char *)imageData image:(UIImage *)imageSource;

+ (unsigned char *)imageGrayWithData:(unsigned char *)imageData Width:(CGFloat)width height:(CGFloat)height;

+ (unsigned char *)imageReColorWithData:(unsigned char *)imageData Width:(CGFloat)width Height:(CGFloat)height;

+ (unsigned char *)imageHighlightWithData:(unsigned char *)imageData Width:(CGFloat)width Height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
