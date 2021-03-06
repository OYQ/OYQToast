//
//  UIView+OYQToast.h
//  OYQToast
//
//  Created by 欧阳铨 on 2016/12/19.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, OYQToastPosition){
	OYQToastPositionDefault  = 0,	//居中显示
	OYQToastPositionBottom   = 1,	//下方显示
	OYQToastPositionTop      = 2    //上方显示
};//Toast的显示位置

typedef NS_ENUM(NSInteger, OYQImagePosition){
	OYQImagePositionDefault  = 0,	//左方显示
	OYQImagePositionRight    = 1,	//右方显示
	OYQImagePositionBottom   = 2,   //下方显示
	OYQImagePositionTop      = 3    //上方显示
};//Toast中图片的位置



@interface UIView (OYQToast)
/**
 创建纯文字的Toast，默认延时toastDuration秒,在下方显示

 @param message 需要显示的文字
 @return 返回Toast
 */
- (UIView *)OYQ_makeToast:(NSString *)message;

/**
 创建纯文字的Toast，延时duration秒，显示位置position

 @param message 显示的文字
 @param duration 延时时间
 @param position 显示位置OYQToastPosition
 @return 返回Toast
 */
- (UIView *)OYQ_makeToast:(NSString *)message
				 duration:(float)duration
				 position:(OYQToastPosition)position;

/**
 创建带图片、标题、内容的toast，延时duration秒，toast显示位置position，图片位置imagePosition

 @param message 显示的文字
 @param title Toast标题
 @param duration 延时时间
 @param toastPosition Toast位置
 @param image 显示图片
 @param imagePosition 图片在Toast的位置
 @return 返回Toast
 */
- (UIView *)OYQ_makeToast:(NSString *)message
					title:(NSString *)title
				 duration:(float)duration
			toastPosition:(OYQToastPosition)toastPosition
					image:(UIImage *)image
			imagePosition:(OYQImagePosition)imagePosition;

@end
