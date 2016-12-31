//
//  ViewController.m
//  高斯模糊
//
//  Created by 马永刚 on 2016/12/31.
//  Copyright © 2016年 【code_小马】. All rights reserved.
//

#import "ViewController.h"
#import <Accelerate/Accelerate.h>


#define YGScreen_W [UIScreen mainScreen].bounds.size.width

#define YGScreen_H [UIScreen mainScreen].bounds.size.height



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//原图
    UIImageView * YG_image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, YGScreen_W/2.0, YGScreen_H/2.0)];
    
    YG_image.image = [UIImage imageNamed:@"code_xiaoma.png"];
    [self.view addSubview:YG_image];

    
    
//CoreImage
    UIImageView * YG_core_image = [[UIImageView alloc]initWithFrame:CGRectMake(0, YGScreen_H/2.0, YGScreen_W/2.0, YGScreen_H/2.0)];
    
    YG_core_image.image = [self coreBlurImage:[UIImage imageNamed:@"code_xiaoma.png"] withBlurNumber:2.0];
    [self.view addSubview:YG_core_image];
    
//vImage
    UIImageView * YG_v_image = [[UIImageView alloc]initWithFrame:CGRectMake(YGScreen_W/2.0, YGScreen_H/2.0, YGScreen_W/2.0, YGScreen_H/2.0)];
    
    YG_v_image.image = [self coreBlurImage:[UIImage imageNamed:@"code_xiaoma.png"] withBlurNumber:3.0];
    [self.view addSubview:YG_v_image];


}

//CoreImage
-(UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage= [CIImage imageWithCGImage:image.CGImage];
    //设置filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey]; [filter setValue:@(blur) forKey: @"inputRadius"];
    //模糊图片
    CIImage *result=[filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage=[context createCGImage:result fromRect:[result extent]];
    UIImage *blurImage=[UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return blurImage;
}

//vImage
-(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
{
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate( outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace, kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    //clean up CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    return returnImage;
}

@end
