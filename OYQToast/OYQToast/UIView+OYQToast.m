//
//  UIView+OYQToast.m
//  OYQToast
//
//  Created by 欧阳铨 on 2016/12/19.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "UIView+OYQToast.h"
#import "OYQToastBackgroundView.h"

/// 屏幕高度
#define MainScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
/// 屏幕宽度
#define MainScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
/// weakself
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//显示动画延时时间
static const float OYQToastShowDuration = 0.3f;
//显示时间
static const float OYQToastDuration = 2.0f;
//消失动画延时时间
static const float OYQToastDismissDuration = 0.15f;
//Toast的最低高度
static const CGFloat ToastMinHeight = 30;
// 显示图片的宽高
static const CGFloat imageViewWH = 50;

@implementation UIView (OYQToast)

/*
+ (instancetype)shareToast{
	static UIView *view = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		view = [[UIView alloc] init];
	});
	return view;
	
}
 */

- (UIView *)OYQ_makeToast:(NSString *)message{
	NSAssert(message != nil, @"message不能为空");
	[self toastAddLabel:message
			   position:OYQToastPositionDefault
				  title:nil
				  image:nil
		  imagePosition:OYQImagePositionDefault];
	
	[self showToastWithDuration:OYQToastShowDuration];
	return self;
}

-(UIView *)OYQ_makeToast:(NSString *)message
				   title:(NSString *)title
				duration:(float)duration
		   toastPosition:(OYQToastPosition)toastPosition
				   image:(UIImage *)image
		   imagePosition:(OYQImagePosition)imagePosition{
	
	NSAssert(message != nil, @"message不能为空");
	[self toastAddLabel:message
			   position:toastPosition
				  title:title
				  image:image
		  imagePosition:imagePosition];
	
	[self showToastWithDuration:duration];
	return self;
}

- (void)toastAddLabel:(NSString *)message
			 position:(OYQToastPosition)position
				title:(NSString *)title
				image:(UIImage *)image
		imagePosition:(OYQImagePosition)imagePosition{
	
	OYQToastBackgroundView *background = [OYQToastBackgroundView shareBackgroundView];
	[background removeFromSuperview];
	for(UIView *view in [background subviews]){
		[view removeFromSuperview];
	}
	
	UILabel *messageLabel = [[UILabel alloc] init];
	UILabel *titleLabel = [[UILabel alloc] init];
	UIImageView *imageView = [[UIImageView alloc] init];
	CGFloat backgroundW = 0;
	CGFloat backgroundH = 0;
	
	messageLabel.numberOfLines = 0;
	messageLabel.font = [UIFont systemFontOfSize:13.0f];
	messageLabel.textAlignment = NSTextAlignmentCenter;
	messageLabel.textColor = [UIColor whiteColor];
	messageLabel.backgroundColor = [UIColor clearColor];
	messageLabel.text = message;
	[background addSubview:messageLabel];
	
	if (title) {
		titleLabel.numberOfLines = 1;
		titleLabel.font = [UIFont systemFontOfSize:15.0f];
		titleLabel.textAlignment = NSTextAlignmentCenter;
		titleLabel.textColor = [UIColor whiteColor];
		titleLabel.backgroundColor = [UIColor clearColor];
		titleLabel.text = title;
		[background addSubview:titleLabel];
	}
	
	if (image) {
		imageView.contentMode = UIViewContentModeScaleAspectFill;
		imageView.clipsToBounds = YES;
		imageView.image = image;
		[background addSubview:imageView];
	}
	
	
	
	
	if (image && title) {//同时有图片和标题
		
	}
	
	if (title) {//只有标题
		
	}
	
	if (image) {//只有图片
		CGSize titleSize = [message boundingRectWithSize:CGSizeMake(MainScreenWidth-imageViewWH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} context:nil].size;
		CGFloat messageLabelW = titleSize.width;
		CGFloat messageLabelH = titleSize.height;
		
		switch (imagePosition) {
			case OYQImagePositionDefault:
				backgroundW = imageViewWH + messageLabelW;
				backgroundH = MAX(imageViewWH, messageLabelH);

				imageView.frame = CGRectMake(0, (backgroundH-imageViewWH)/2, imageViewWH, imageViewWH);
				messageLabel.frame = CGRectMake(imageViewWH, (backgroundH-messageLabelH)/2, messageLabelW, messageLabelH);
				
				NSLog(@"imageX-%d,imageY-%f,messageX-%f,messageY-%f",0,(backgroundH-imageViewWH)/2, imageViewWH,(backgroundH-messageLabelH)/2);
				break;
			case OYQImagePositionRight:
				imageView.frame = CGRectMake(self.frame.size.width - imageViewWH, (self.frame.size.height-imageViewWH)/2, imageViewWH, imageViewWH);
				break;
			case OYQImagePositionTop:
				imageView.frame = CGRectMake((self.frame.size.width-imageViewWH)/2, 0, imageViewWH, imageViewWH);
				break;
			case OYQImagePositionBottom:
				imageView.frame = CGRectMake((self.frame.size.width-imageViewWH)/2, self.frame.size.height-imageViewWH, imageViewWH, imageViewWH);
				break;
				
			default:
				break;
		}
		
		
	}
	
	
	
	/*
	CGFloat messageLabelW = titleSize.width;
	CGFloat messageLabelH = ToastMinHeight;
	if (titleSize.height > 30) {
		messageLabelH = titleSize.height;
	}
	*/
	
	
	
	//OYQToastBackgroundView *background = [OYQToastBackgroundView shareBackgroundView];
	//[background addSubview:messageLabel];
	//background.frame = CGRectMake(100, 100, titleSize.width, messageLabelH);
	//messageLabel.frame = CGRectMake(0, 0, titleSize.width, messageLabelH);
	//CGFloat backgroundW = backgroundSize.width;
	//CGFloat backgroundH = backgroundSize.height;
	NSAssert(backgroundW <= MainScreenWidth, @"toast的宽度不能大于屏幕宽度");
	NSAssert(backgroundH <= MainScreenHeight, @"toast的高度不能大于屏幕高度");
	
	CGFloat backgroundX = 0;
	CGFloat backgroundY = 0;
	switch (position) {
		case OYQToastPositionDefault:
			backgroundX = (self.frame.size.width - backgroundW)/2;
			backgroundY = (self.frame.size.height - backgroundH)/2;
			break;
		case OYQToastPositionBottom:
			backgroundX = (self.frame.size.width - backgroundW)/2;
			backgroundY = self.frame.size.height - backgroundH;
			break;
		case OYQToastPositionTop:
			backgroundX = (self.frame.size.width - backgroundW)/2;
			backgroundY = backgroundH;
			break;
			
		default:
			break;
	}
	//CGFloat backgroundX = (self.frame.size.width - backgroundW)/2;
	//CGFloat backgroundY = (self.frame.size.height - backgroundH)/2;
	
    background.frame = CGRectMake(backgroundX, backgroundY, backgroundW, backgroundH);
	[self addSubview:background];
	
}

- (void)showToastWithDuration:(float)duration{
	OYQToastBackgroundView *background = [OYQToastBackgroundView shareBackgroundView];
	[UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
		background.alpha = 1.0f;
	} completion:nil];
		

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(OYQToastDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[UIView animateWithDuration:OYQToastDismissDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
			background.alpha = 0.0f;
		} completion:^(BOOL finished) {
			[background removeFromSuperview];
			for(UIView *view in [background subviews]){
				[view removeFromSuperview];
			}
		}];
	});
	

}
@end
