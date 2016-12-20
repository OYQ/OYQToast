//
//  UIView+OYQToast.m
//  OYQToast
//
//  Created by 欧阳铨 on 2016/12/19.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "UIView+OYQToast.h"

/// 屏幕高度
#define MainScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
/// 屏幕宽度
#define MainScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
/// weakself
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define OYQ_MAX(a,b,c) MAX(a,MAX(b,c))

//显示动画延时时间
static const float OYQToastShowDuration = 0.3f;
//显示时间
static const float OYQToastDuration = 2.0f;
//消失动画延时时间
static const float OYQToastDismissDuration = 0.15f;
// 显示图片的宽高
static const CGFloat OYQToastImageViewWH = 50;
// Toast最小高度
static const CGFloat OYQToastMinHeight = 30;
// Toast内容的边距
static const CGFloat OYQToastMargin = 5;

@implementation UIView (OYQToast)

- (UIView *)OYQ_makeToast:(NSString *)message{
	NSAssert(message != nil, @"message不能为空");
	[self toastAddLabel:message
			   position:OYQToastPositionDefault
				  title:nil
				  image:nil
		  imagePosition:OYQImagePositionDefault
			   duration:OYQToastDuration];
	
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
		  imagePosition:imagePosition
			   duration:duration];
	
	return self;
}

- (void)toastAddLabel:(NSString *)message
			 position:(OYQToastPosition)position
				title:(NSString *)title
				image:(UIImage *)image
		imagePosition:(OYQImagePosition)imagePosition
			 duration:(float)duration{
	
	UIView *background = [[UIView alloc] init];
	background.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
	background.alpha = 0.0f;
	background.layer.cornerRadius = 5;
	background.layer.masksToBounds = YES;
	
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
	
	
	CGSize messageSize = [message boundingRectWithSize:CGSizeMake(MainScreenWidth-OYQToastImageViewWH, MainScreenHeight-OYQToastImageViewWH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} context:nil].size;
	CGFloat messageLabelW = messageSize.width;
	CGFloat messageLabelH = messageSize.height;
	
	if (image && title) {//同时有图片和标题
		CGSize titleSize = [title boundingRectWithSize:CGSizeMake(MainScreenWidth-OYQToastImageViewWH, MainScreenHeight-OYQToastImageViewWH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} context:nil].size;
		CGFloat titleLabelW = titleSize.width;
		CGFloat titleLabelH = titleSize.height;
		
		switch (imagePosition) {
			case OYQImagePositionDefault:
				backgroundW = OYQToastImageViewWH + MAX(messageLabelW, titleLabelW) + 3*OYQToastMargin;
				backgroundH = MAX(OYQToastImageViewWH, messageLabelH+titleLabelH);
				
				imageView.frame = CGRectMake(OYQToastMargin, (backgroundH-OYQToastImageViewWH)/2, OYQToastImageViewWH, OYQToastImageViewWH);
				titleLabel.frame = CGRectMake((backgroundW-OYQToastImageViewWH-2*OYQToastMargin-titleLabelW)/2 + OYQToastImageViewWH +OYQToastMargin, backgroundH/2-titleLabelH, titleLabelW, titleLabelH);
				messageLabel.frame = CGRectMake((backgroundW-OYQToastImageViewWH-2*OYQToastMargin-messageLabelW)/2 + OYQToastImageViewWH + OYQToastMargin, backgroundH/2, messageLabelW, messageLabelH);
				
				
				//NSLog(@"imageX-%d,imageY-%f,messageX-%f,messageY-%f",OYQToastMargin,(backgroundH-OYQToastImageViewWH)/2, OYQToastImageViewWH,(backgroundH-messageLabelH)/2);
				break;
			case OYQImagePositionRight:
				backgroundW = OYQToastImageViewWH + MAX(messageLabelW, titleLabelW) + 3*OYQToastMargin;
				backgroundH = MAX(OYQToastImageViewWH, messageLabelH+titleLabelH);
				
				imageView.frame = CGRectMake(backgroundW-OYQToastImageViewWH-OYQToastMargin, (backgroundH-OYQToastImageViewWH)/2, OYQToastImageViewWH, OYQToastImageViewWH);
				titleLabel.frame = CGRectMake((backgroundW-OYQToastImageViewWH-2*OYQToastMargin-titleLabelW)/2 + OYQToastMargin, backgroundH/2-titleLabelH, titleLabelW, titleLabelH);
				messageLabel.frame = CGRectMake((backgroundW-OYQToastImageViewWH-2*OYQToastMargin-messageLabelW)/2 + OYQToastMargin, backgroundH/2, messageLabelW, messageLabelH);
				break;
			case OYQImagePositionTop:
				backgroundW = OYQ_MAX(OYQToastImageViewWH, messageLabelW, titleLabelW) + 2*OYQToastMargin;;
				backgroundH = OYQToastImageViewWH + messageLabelH + titleLabelH + 4*OYQToastMargin;
				
				imageView.frame = CGRectMake((backgroundW-OYQToastImageViewWH)/2, OYQToastMargin, OYQToastImageViewWH, OYQToastImageViewWH);
				titleLabel.frame = CGRectMake((backgroundW-titleLabelW)/2, CGRectGetMaxY(imageView.frame)+OYQToastMargin, titleLabelW, titleLabelH);
				messageLabel.frame = CGRectMake((backgroundW-messageLabelW)/2, CGRectGetMaxY(titleLabel.frame)+OYQToastMargin, messageLabelW, messageLabelH);
				break;
			case OYQImagePositionBottom:
				backgroundW = OYQ_MAX(OYQToastImageViewWH, messageLabelW, titleLabelW) + 2*OYQToastMargin;
				backgroundH = OYQToastImageViewWH + messageLabelH + titleLabelH + 4*OYQToastMargin;
				
				
				titleLabel.frame = CGRectMake((backgroundW-titleLabelW)/2, OYQToastMargin, titleLabelW, titleLabelH);
				messageLabel.frame = CGRectMake((backgroundW-messageLabelW)/2, CGRectGetMaxY(titleLabel.frame)+OYQToastMargin, messageLabelW, messageLabelH);
				imageView.frame = CGRectMake((backgroundW-OYQToastImageViewWH)/2, CGRectGetMaxY(messageLabel.frame)+OYQToastMargin, OYQToastImageViewWH, OYQToastImageViewWH);
				break;
				
			default:
				break;
		}
		
		
	}else if (title){//只有标题
		CGSize titleSize = [title boundingRectWithSize:CGSizeMake(MainScreenWidth-OYQToastImageViewWH, MainScreenHeight-OYQToastImageViewWH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} context:nil].size;
		CGFloat titleLabelW = titleSize.width;
		CGFloat titleLabelH = titleSize.height;
		
		backgroundW = MAX(titleLabelW, messageLabelW);
		backgroundH = titleLabelH + messageLabelH;
		
		titleLabel.frame = CGRectMake((backgroundW-titleLabelW)/2, OYQToastMargin, titleLabelW, titleLabelH);
		messageLabel.frame = CGRectMake((backgroundW-messageLabelW)/2, titleLabelH, messageLabelW, messageLabelH);
		
	}else if (image){//只有图片
		switch (imagePosition) {
			case OYQImagePositionDefault:
				backgroundW = OYQToastImageViewWH + messageLabelW;
				backgroundH = MAX(OYQToastImageViewWH, messageLabelH);
				
				imageView.frame = CGRectMake(OYQToastMargin, (backgroundH-OYQToastImageViewWH)/2, OYQToastImageViewWH, OYQToastImageViewWH);
				messageLabel.frame = CGRectMake(OYQToastImageViewWH, (backgroundH-messageLabelH)/2, messageLabelW, messageLabelH);
				
				//NSLog(@"imageX-%d,imageY-%f,messageX-%f,messageY-%f",OYQToastMargin,(backgroundH-OYQToastImageViewWH)/2, OYQToastImageViewWH,(backgroundH-messageLabelH)/2);
				break;
			case OYQImagePositionRight:
				backgroundW = OYQToastImageViewWH + messageLabelW;
				backgroundH = MAX(OYQToastImageViewWH, messageLabelH);
				
				imageView.frame = CGRectMake(backgroundW-OYQToastImageViewWH-OYQToastMargin, (backgroundH-OYQToastImageViewWH)/2, OYQToastImageViewWH, OYQToastImageViewWH);
				messageLabel.frame = CGRectMake(OYQToastMargin, (backgroundH-messageLabelH)/2, messageLabelW, messageLabelH);
				break;
			case OYQImagePositionTop:
				backgroundW = MAX(OYQToastImageViewWH, messageLabelW);
				backgroundH = OYQToastImageViewWH + messageLabelH;
				
				imageView.frame = CGRectMake((backgroundW-OYQToastImageViewWH)/2, OYQToastMargin, OYQToastImageViewWH, OYQToastImageViewWH);
				messageLabel.frame = CGRectMake((backgroundW-messageLabelW)/2, OYQToastImageViewWH, messageLabelW, messageLabelH);
				break;
			case OYQImagePositionBottom:
				backgroundW = MAX(OYQToastImageViewWH, messageLabelW);
				backgroundH = OYQToastImageViewWH + messageLabelH;
				
				imageView.frame = CGRectMake((backgroundW-OYQToastImageViewWH)/2, messageLabelH, OYQToastImageViewWH, OYQToastImageViewWH);
				messageLabel.frame = CGRectMake((backgroundW-messageLabelW)/2, OYQToastMargin, messageLabelW, messageLabelH);
				break;
				
			default:
				break;
		}

	}else{//只有toast文字
		backgroundW = messageLabelW;
		backgroundH = messageLabelH;
		if (backgroundH < OYQToastMinHeight) {
			backgroundH = OYQToastMinHeight;
		}
		messageLabel.frame = CGRectMake((backgroundW-messageLabelW)/2, (backgroundH-messageLabelH)/2, messageLabelW, messageLabelH);
	}
	
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
	
    background.frame = CGRectMake(backgroundX, backgroundY, backgroundW, backgroundH);
	[self addSubview:background];
	
	
	[UIView animateWithDuration:OYQToastShowDuration delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
		background.alpha = 1.0f;
	} completion:nil];
	
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
