//
//  UIImage+BlurI.h
//  高斯模糊
//  https://github.com/McodeYG/iOSGaussianBlur
//  Created by 【code_小马】 on 2017/1/1.
//  Copyright © 2017年 【code_小马】. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BlurI)

+(UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

@end
