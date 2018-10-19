//
//  Tools.m
//  特效相机
//
//  Created by 叶世昌 on 2018/10/18.
//  Copyright © 2018 Luomi. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+ (unsigned char *)convertUIImageToData:(UIImage *)image {
    CGImageRef imageref = image.CGImage;
    CGSize image_size = image.size;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 每个像素点 4个byte R G B A 像素点个数 = 宽*高
    // malloc： 内存分配
    void *data = malloc(image_size.width * image_size.height *4);
    
    CGContextRef context = CGBitmapContextCreate(data, image_size.width, image_size.height, 8, 4*image_size.width, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextDrawImage(context, CGRectMake(0, 0, image_size.width, image_size.height), imageref);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    return (unsigned char*)data;
}

+ (UIImage *)convertDataToUIImage:(unsigned char *)imageData image:(UIImage *)imageSource {
    CGFloat width = imageSource.size.width;
    CGFloat height = imageSource.size.height;
    NSInteger dataLength = width * height * 4;
    CGDataProviderRef provide = CGDataProviderCreateWithData(NULL, imageData, dataLength, NULL);
    int bitsPerComponent = 8;
    int bitsPerPixel = 32;
    int bytesPerRow = 4 * width;
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderIntent = kCGRenderingIntentDefault;
    
    CGImageRef imageRef = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provide, NULL, false, renderIntent);
    UIImage *imageNew = [UIImage imageWithCGImage:imageRef];
    CFRelease(imageRef);
    CGColorSpaceRelease(colorSpaceRef);
    CGDataProviderRelease(provide);
    return imageNew;
}

+ (unsigned char *)imageGrayWithData:(unsigned char *)imageData Width:(CGFloat)width height:(CGFloat)height {
    // 分配内存空间
    unsigned char *resultData = malloc(width * height * sizeof(unsigned char) * 4);
    memset(resultData, 0, width * height * sizeof(unsigned char) * 4);
    for (int h = 0; h < height; h++) {
        for (int w = 0; w < width; w++) {
            unsigned int imageIndex = h * width + w;
            // 像素RABA == 4B
            
            unsigned char bitMapRed = *(imageData + imageIndex * 4);
            unsigned char bitMapGreen = *(imageData + imageIndex * 4 + 1);
            unsigned char bitMapBlue = *(imageData + imageIndex * 4 + 2);
            
            int bitMap = bitMapRed*77/255 + bitMapGreen*151/255 + bitMapBlue*88/255;
            unsigned char newBitMap = (bitMap > 255) ? 255 : bitMap;
            memset(resultData + imageIndex*4, newBitMap, 1);
            memset(resultData + imageIndex*4 + 1, newBitMap, 1);
            memset(resultData + imageIndex*4 + 2, newBitMap, 1);
        }
    }
    return resultData;
}

+ (unsigned char *)imageReColorWithData:(unsigned char *)imageData Width:(CGFloat)width Height:(CGFloat)height {
    // 分配内存空间
    unsigned char *resultData = malloc(width * height * sizeof(unsigned char) * 4);
    memset(resultData, 0, width * height * sizeof(unsigned char) * 4);
    for (int h = 0; h < height; h++) {
        for (int w = 0; w < width; w++) {
            unsigned int imageIndex = h * width + w;
            // 像素RABA == 4B
            
            unsigned char bitMapRed = *(imageData + imageIndex * 4);
            unsigned char bitMapGreen = *(imageData + imageIndex * 4 + 1);
            unsigned char bitMapBlue = *(imageData + imageIndex * 4 + 2);
            
            unsigned char bitMapRedNew = 255 - bitMapRed;
            unsigned char bitMapGreenNew = 255 - bitMapGreen;
            unsigned char bitMapBlueNew = 255 - bitMapBlue;
            
            memset(resultData + imageIndex*4, bitMapRedNew, 1);
            memset(resultData + imageIndex*4 + 1, bitMapGreenNew, 1);
            memset(resultData + imageIndex*4 + 2, bitMapBlueNew, 1);
        }
    }
    return resultData;
}

+ (unsigned char *)imageHighlightWithData:(unsigned char *)imageData Width:(CGFloat)width Height:(CGFloat)height {
    // 分配内存空间
    unsigned char *resultData = malloc(width * height * sizeof(unsigned char) * 4);
    memset(resultData, 0, width * height * sizeof(unsigned char) * 4);
    
    NSArray *colorArrayBase = @[@"55", @"110", @"155", @"185", @"220", @"240", @"250", @"255"];
    NSMutableArray *colorArray = [NSMutableArray array];
    int beforNum = 0;
    for (int i = 0; i < 8; i++) {
        NSString *numStr = [colorArrayBase objectAtIndex:i];
        int num = numStr.intValue;
        float step = 0;
        if (i == 0) {
            step = num/32.0;
            beforNum = num;
        } else {
            step = (num - beforNum)/32.0;
        }
        for (int j = 0; j < 32; j++) {
            int newNum = 0;
            if (i == 0) {
                newNum = (int)(j * step);
            } else {
                newNum = (int)(beforNum + j*step);
            }
            NSString *newNumStr = [NSString stringWithFormat:@"%d", newNum];
            [colorArray addObject:newNumStr];
        }
        beforNum = num;
    }
    for (int h = 0; h < height; h++) {
        for (int w = 0; w < width; w++) {
            unsigned int imageIndex = h * width + w;
            // 像素RABA == 4B
            
            unsigned char bitMapRed = *(imageData + imageIndex * 4);
            unsigned char bitMapGreen = *(imageData + imageIndex * 4 + 1);
            unsigned char bitMapBlue = *(imageData + imageIndex * 4 + 2);
            
            NSString *redStr = [colorArray objectAtIndex:bitMapRed];
            NSString *greenStr = [colorArray objectAtIndex:bitMapGreen];
            NSString *blueStr = [colorArray objectAtIndex:bitMapBlue];
            
            unsigned char bitMapRedNew = redStr.intValue;
            unsigned char bitMapGreenNew = greenStr.intValue;
            unsigned char bitMapBlueNew = blueStr.intValue;
            
            memset(resultData + imageIndex*4, bitMapRedNew, 1);
            memset(resultData + imageIndex*4 + 1, bitMapGreenNew, 1);
            memset(resultData + imageIndex*4 + 2, bitMapBlueNew, 1);
        }
    }
    return resultData;
}

@end
