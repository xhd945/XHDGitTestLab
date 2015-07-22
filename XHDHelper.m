//
//  XHDHelper.m
//  My--One
//
//  Created by mac on 15-3-28.
//  Copyright (c) 2015年 xhd945. All rights reserved.
//

#import "XHDHelper.h"
#import <sys/utsname.h>


@implementation XHDHelper


//创建按钮
+(UIButton*)createButton:(CGRect)frame title:(NSString*)title image:(UIImage*)image target:(id)target selector:(SEL)selector
{
    UIButton *bnt = [UIButton buttonWithType:UIButtonTypeCustom];
    bnt.frame = frame;
    [bnt addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [bnt setBackgroundImage:image forState:UIControlStateNormal];
   
//    CGRect newFrame=frame;
//    newFrame.origin.y=frame.size.height/2.0;
//    newFrame.size.height=frame.size.height/2.0;
//    newFrame.origin.x=0;
//    
//    UILabel * label=[[UILabel alloc]initWithFrame:newFrame];
//    label.text=title;
//    label.font=[UIFont systemFontOfSize:12];
//    label.backgroundColor=[UIColor clearColor];
//    
//    [bnt addSubview:label];
    return bnt;
}

//创建一个UIBarButtonItem
+(UIBarButtonItem*)createBarButtonWith:(CGRect)frame Title:(NSString*)title ImageName:(NSString*)imageName Target:(id)target Selector:(SEL)selector
{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}


//提示框
+ (void)showAlert:(NSString*)message
{
    UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"好", nil];
    [a show];
}

//创建一个label
+(UILabel*)createLabelWithFrame:(CGRect)frame andText:text andFont:(UIFont*)font AndBackGround:(UIColor*)bgColor AndTextColor:(UIColor*)textColor
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    [label setFont:font];
    label.textColor = textColor;
    label.backgroundColor = bgColor;
    return label;
}

/**
 *  创建一个UIImageView
 *
 *  @param frame     坐标
 *  @param imageName 图片名字
 *  @param radius    倒角
 *  @param gesture   手势  1==tap， 2==pan，3==1ongPress
 *  @param target    手势目标
 *  @param action    手势点击执行的动作
 *
 *  @return 返回一个ImageView
 */
+(UIImageView*)createImageViewWithFrame:(CGRect)frame AndImageName:(NSString*)imageName AndCornerRadius:(CGFloat)radius andGestureRecognizer:(NSInteger)gesturtCode AndTarget:(id)target AndAction:(SEL)action
{
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:frame];
    imageview.image = [UIImage imageNamed:imageName];
    imageview.layer.cornerRadius = radius;
    imageview.clipsToBounds = YES;
    imageview.userInteractionEnabled = YES;
    
    UIGestureRecognizer *gesture;
    switch (gesturtCode) {
        case 1:
        {
            gesture = [[UITapGestureRecognizer alloc]init];
        }
            break;
        case 2:
        {
            gesture = [[UIPanGestureRecognizer alloc]init];
        }
            break;
        case 3:
        {
            gesture = [[UILongPressGestureRecognizer alloc]init];
        }
            break;
        default:
            break;
    }
    [gesture addTarget:target action:action];
    [imageview addGestureRecognizer:gesture];
    
    return imageview;
}


//获取今天日期的字符串YY-MM-DD
+(NSString*)getToday
{
    //获取今天的日期
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = kCFCalendarUnitYear|kCFCalendarUnitMonth|kCFCalendarUnitDay|kCFCalendarUnitWeekday;
    
    NSDateComponents *components = [calendar components:unit fromDate:today];
    NSString *year = [NSString stringWithFormat:@"%ld", [components year]];
    NSString *month = [NSString stringWithFormat:@"%02ld", [components month]];
    NSString *day = [NSString stringWithFormat:@"%02ld", [components day]];
    
    NSString *currentDateStr = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
    return currentDateStr;
}


//获取时间
+(NSDictionary*)getDate
{
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *compontents = [calendar components:unit fromDate:today];
    NSString *year = [NSString stringWithFormat:@"%ld",[compontents year]];
    NSString *month = [NSString stringWithFormat:@"%ld",[compontents month]];
    NSString *day = [NSString stringWithFormat:@"%02ld",[compontents day]];
    
    NSDictionary *dic = @{@"year":year,@"month":month,@"day":day};
    return dic;
}


//label的自适应高度
+ (CGSize)heightOfString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode
{
    CGSize h;
    //系统版本适配
    if (UIDevice.currentDevice.systemVersion.doubleValue >= 7.0)
    {
        NSDictionary *dic = @{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName: font};
        h = [str boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    }
    else
    {
        h = [str sizeWithFont:font constrainedToSize:size lineBreakMode:mode];
    }
    return h;
}



//清理缓存
//计算单个文件的大小，传入的时绝对的路径
+(float)fileSizeAtPath:(NSString *)path
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

//计算目录大小
+(float)folderSizeAtPath:(NSString *)path
{

    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[self fileSizeAtPath:absolutePath];
        }
        //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}

//清理缓存文件
+(void)clearCacheWith:(id)target AndAction:(SEL)action
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
    NSLog(@"files :%ld",[files count]);
    for (NSString *p in files)
    {
        NSError *error;
        NSString *path = [cachPath stringByAppendingPathComponent:p];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path])
        {
          [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        }
    }
        //action 是一个清理缓存成功后的提示框
    [target performSelectorOnMainThread:action withObject:nil waitUntilDone:YES];});
}

@end
