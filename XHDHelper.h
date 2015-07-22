//
//  XHDHelper.h
//  My--One
//
//  Created by mac on 15-3-28.
//  Copyright (c) 2015年 xhd945. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SDImageCache.h"

@interface XHDHelper : NSObject

//创建按钮
+(UIButton*)createButton:(CGRect)frame title:(NSString*)title image:(UIImage*)image target:(id)target selector:(SEL)selector;

//创建一个UIBarButtonItem
+(UIBarButtonItem*)createBarButtonWith:(CGRect)frame Title:(NSString*)title ImageName:(NSString*)imageName Target:(id)target Selector:(SEL)selector;

//创建一个Label
+(UILabel*)createLabelWithFrame:(CGRect)frame andText:text andFont:(UIFont*)font AndBackGround:(UIColor*)bgColor AndTextColor:(UIColor*)textColor;

//创建一个UIImageView
+(UIImageView*)createImageViewWithFrame:(CGRect)frame AndImageName:(NSString*)imageName AndCornerRadius:(CGFloat)radius andGestureRecognizer:(NSInteger)gesturtCode AndTarget:(id)target AndAction:(SEL)action;

//提示框
+ (void)showAlert:(NSString*)message;




// 带系统版本判断的label的自适应高度
+ (CGSize)heightOfString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode;



//获取今天的日期
+(NSString*)getToday;

//获取时间
+(NSDictionary*)getDate;

//计算单个文件的大小
+(float)fileSizeAtPath:(NSString *)path;

//计算目录大小
//+(float)folderSizeAtPath:(NSString *)path;

//清理缓存文件
+(void)clearCacheWith:(id)target AndAction:(SEL)action;

@end
