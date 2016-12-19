//
//  OYQToastBackground.h
//  OYQToast
//
//  Created by 欧阳铨 on 2016/12/19.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OYQToastBackgroundView : UIView

/**
 创建toast背景view的单例

 @return 背景view
 */
+ (OYQToastBackgroundView *)shareBackgroundView;
@end
