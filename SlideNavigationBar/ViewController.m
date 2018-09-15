//
//  ViewController.m
//  SlideNavigationBar
//
//  Created by 区振轩 on 2018/9/7.
//  Copyright © 2018年 区振轩. All rights reserved.
//

#import "ViewController.h"

#import "ZXFollowSlide.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ZXFollowSlide * slideView =  [[ZXFollowSlide alloc] initWithFrame:CGRectMake(0, 0, WIDTH , HEIGHT)];
    slideView.backgroundColor = [UIColor redColor];
    [self.view addSubview:slideView];
    
    self.view.backgroundColor = [UIColor yellowColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
