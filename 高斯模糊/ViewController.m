//
//  ViewController.m
//  高斯模糊
//  https://github.com/McodeYG/iOSGaussianBlur
//  Created by 【code_小马】 on 2016/12/31.
//  Copyright © 2016年 【code_小马】. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+BlurI.h"


#define YGScreen_W [UIScreen mainScreen].bounds.size.width
#define YGScreen_H [UIScreen mainScreen].bounds.size.height


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor   = [UIColor whiteColor];
    
//原图
    UIImageView * YG_image      = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, YGScreen_W/2.0, YGScreen_H/2.0)];
    
    YG_image.image              = [UIImage imageNamed:@"code_xiaoma.png"];
    [self.view addSubview:YG_image];

    
//CoreImage
    UIImageView * YG_core_image = [[UIImageView alloc]initWithFrame:CGRectMake(0, YGScreen_H/2.0, YGScreen_W/2.0, YGScreen_H/2.0)];
    
    YG_core_image.image         = [UIImage coreBlurImage:[UIImage imageNamed:@"code_xiaoma.png"] withBlurNumber:0.9];
    [self.view addSubview:YG_core_image];
    
    
//vImage
    UIImageView * YG_v_image    = [[UIImageView alloc]initWithFrame:CGRectMake(YGScreen_W/2.0, YGScreen_H/2.0, YGScreen_W/2.0, YGScreen_H/2.0)];
    
    YG_v_image.image            = [UIImage coreBlurImage:[UIImage imageNamed:@"code_xiaoma.png"] withBlurNumber:1.8];
    [self.view addSubview:YG_v_image];


}


@end
