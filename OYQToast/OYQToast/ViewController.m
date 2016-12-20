//
//  ViewController.m
//  OYQToast
//
//  Created by 欧阳铨 on 2016/12/19.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "ViewController.h"
#import "UIView+OYQToast.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	UIButton *button0 = [UIButton buttonWithType:UIButtonTypeCustom];
	button0.frame = CGRectMake(100, 300, 100, 50);
	[button0 setTitle:@"Toast" forState:UIControlStateNormal];
	[button0 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	[self.view addSubview:button0];
	[button0 addTarget:self action:@selector(button0Click) forControlEvents:UIControlEventTouchUpInside];
	
	UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
	button1.frame = CGRectMake(100, 400, 100, 50);
	[button1 setTitle:@"Toast" forState:UIControlStateNormal];
	[button1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	[self.view addSubview:button1];
	[button1 addTarget:self action:@selector(button1Click) forControlEvents:UIControlEventTouchUpInside];
	
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)button0Click{
	[self.view OYQ_makeToast:@"123阿大大一奥苏姑嫂发"];
	//[self.view OYQ_makeToast:@"123阿大大一奥苏姑嫂发SD撒SD素雅US一大" title:nil duration:0.3f toastPosition:OYQToastPositionBottom image:[UIImage imageNamed:@"icon64_wx_logo"] imagePosition:OYQImagePositionBottom];
}

- (void)button1Click{
	//[self.view OYQ_makeToast:@"123阿大大一奥苏姑嫂发"];
	[self.view OYQ_makeToast:@"123阿素雅US一大" title:@"标题" duration:0.3f toastPosition:OYQToastPositionDefault image:nil imagePosition:OYQImagePositionTop];
}

@end
