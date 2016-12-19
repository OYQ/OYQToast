//
//  OYQToastBackground.m
//  OYQToast
//
//  Created by 欧阳铨 on 2016/12/19.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "OYQToastBackgroundView.h"

@implementation OYQToastBackgroundView

+ (OYQToastBackgroundView *)shareBackgroundView{
	static OYQToastBackgroundView *background = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		background = [[OYQToastBackgroundView alloc] init];
		[background setUpView];
	});
	return background;
	
}

- (void)setUpView{
	self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
	self.alpha = 0.0f;
	self.layer.cornerRadius = 5;
	self.layer.masksToBounds = YES;
}

//- (void)setFrame:(CGRect)frame{
//	
//	
//	[super setFrame:frame];
//}


@end
