//
//  ToastViewController.m
//  OYQToast
//
//  Created by 欧阳铨 on 2016/12/28.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "ToastViewController.h"
#import "UIView+OYQToast.h"

/// Toast的内容
static NSString * const toastMessage = @"Toast内容";
/// Toast的标题
static NSString * const toastTitle = @"标题";
/// Toast图片的名字
static NSString * const toastImageName = @"wechatLogo";


static NSString * const cellNames[] = {
	@"🍎基础Toast",
	@"🍏基础Toast(下方显示，延时5秒)",
	@"🍋基础Toast+标题",
	@"🍒基础Toast+标题(下方显示)",
	@"🍇基础Toast+图片",
	@"🍉基础Toast+图片(图片在上方显示)",
	@"🍓基础Toast+标题+图片",
	@"🍑基础Toast+标题+图片(图片在上方显示)"
};
@interface ToastViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ToastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"🍞OYQToast🍞";
	
	UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
	[tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([UITableViewCell class])]];
	[self.view addSubview:tableView];
	tableView.delegate = self;
	tableView.dataSource = self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return 8;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([UITableViewCell class])] forIndexPath:indexPath];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.textLabel.text = cellNames[indexPath.row];
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	NSString *selectorStr = [NSString stringWithFormat:@"showToast%ld",(long)indexPath.row];
	if ([self respondsToSelector:NSSelectorFromString(selectorStr)]) {
		SEL selector = NSSelectorFromString(selectorStr);
		IMP imp = [self methodForSelector:selector];
		void (*func)(id, SEL) = (void *)imp;
		func(self, selector);
	}
	
}

- (void)showToast0{
	[self.view OYQ_makeToast:toastMessage];
}

- (void)showToast1{
	[self.view OYQ_makeToast:toastMessage
					duration:5.0f
					position:OYQToastPositionBottom];
}

- (void)showToast2{
	[self.view OYQ_makeToast:toastMessage
					   title:toastTitle
					duration:3.0f
			   toastPosition:OYQToastPositionDefault
					   image:nil
			   imagePosition:OYQImagePositionDefault];
}

- (void)showToast3{
	[self.view OYQ_makeToast:toastMessage
					   title:toastTitle
					duration:3.0f
			   toastPosition:OYQToastPositionBottom
					   image:nil
			   imagePosition:OYQImagePositionDefault];
}

- (void)showToast4{
	[self.view OYQ_makeToast:toastMessage
					   title:nil
					duration:3.0f
			   toastPosition:OYQToastPositionBottom
					   image:[UIImage imageNamed:toastImageName]
			   imagePosition:OYQImagePositionDefault];
}

- (void)showToast5{
	[self.view OYQ_makeToast:toastMessage
					   title:nil
					duration:3.0f
			   toastPosition:OYQToastPositionBottom
					   image:[UIImage imageNamed:toastImageName]
			   imagePosition:OYQImagePositionTop];
}

- (void)showToast6{
	[self.view OYQ_makeToast:toastMessage
					   title:toastTitle
					duration:3.0f
			   toastPosition:OYQToastPositionBottom
					   image:[UIImage imageNamed:toastImageName]
			   imagePosition:OYQImagePositionDefault];
}

- (void)showToast7{
	[self.view OYQ_makeToast:toastMessage
					   title:toastTitle
					duration:3.0f
			   toastPosition:OYQToastPositionDefault
					   image:[UIImage imageNamed:toastImageName]
			   imagePosition:OYQImagePositionTop];
}



@end
