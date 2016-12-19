//
//  UIView+OYQToast.m
//  OYQToast
//
//  Created by 欧阳铨 on 2016/12/19.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "UIView+OYQToast.h"

@implementation UIView (OYQToast)

+ (instancetype)shareToast{
	static UIView *view = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		view = [[UIView alloc] init];
	});
	return view;
	
}

+ (void)makeToast:(NSString *)message{
	UIView *toast = [self shareToast];
	
}
@end
