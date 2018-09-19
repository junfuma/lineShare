//
//  ViewController.m
//  lineShare
//
//  Created by 开拍网ios研发 on 2018/9/18.
//  Copyright © 2018年 开拍网ios研发. All rights reserved.
//

#import "ViewController.h"
#import <LineSDK/LineSDK.h>

#define ITUNES_LINE_URL  @"itms-apps://itunes.apple.com/us/app/line/id443904275?mt=8"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
    //        [[LineSDKLogin sharedInstance] startLogin];
    UIButton *shareTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareTextBtn.frame = CGRectMake(100, 100, 150, 50) ;
    [shareTextBtn setTitle:@"分享文字" forState:UIControlStateNormal];
    [shareTextBtn setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
    [shareTextBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareTextBtn];
    
    UIButton *sharimageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sharimageBtn.frame = CGRectMake(100, 200, 150, 50) ;
    [sharimageBtn setTitle:@"分享图片" forState:UIControlStateNormal];
    [sharimageBtn setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
    [sharimageBtn addTarget:self action:@selector(shareimage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sharimageBtn];
  
}
- (void)share{
    [self shareText:@"测试line分享文字"];
}
- (void)shareimage{
    [self shareImage:@"https://img5q.duitang.com/uploads/item/201411/05/20141105005117_nBfM8.jpeg"];
}
//是否安装客户端
- (BOOL)canShareToLine

{
    
    return[[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"line://"]];
    
}
//分享文字

- (void)shareText:(NSString*)text

{
    
    if( [self canShareToLine] ) {
        //分享文字
        NSString *contentType = @"text";
        NSString*contentKey = (__bridge NSString*)CFURLCreateStringByAddingPercentEscapes(NULL,
//
                                                                                          (CFStringRef)text,

                                                                                          NULL,

                                                                                          (CFStringRef)@"!*'();:@&=+$,/?%#[]",

                                                                                          kCFStringEncodingUTF8);

        
        
        NSString*urlString = [NSString stringWithFormat:@"line://msg/%@/%@",
                              
                              contentType, contentKey];
        
        /***
         @{UIApplicationOpenURLOptionUniversalLinksOnly : @YES}
         YES  :也就是说只有安装了Link所对应的App的情况下才能打开这个 Link,而不是通过启动Safari方式打开这个Link的代表的网站.
         */
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString] options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @NO} completionHandler:^(BOOL success) {
              
            }];
        } else {
            // Fallback on earlier versions
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }

    }else{
//        跳转到App Store安装客户端APP
        NSURL *url = [NSURL URLWithString:ITUNES_LINE_URL];
        [[UIApplication sharedApplication] openURL:url];
    }
    
}
//分享图片
- (void)shareImage:(NSString*)imageUrl{
    
    if( [self canShareToLine] ) {
        //分享图片
         UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        /**
         本地图片
         [pasteboard setData:UIImageJPEGRepresentation([UIImage imageNamed:@"Snip20180907_3.png"] , 1.0) forPasteboardType:@"public.jpeg"];
        */
        /* 网络图片*/
        [pasteboard setData:UIImageJPEGRepresentation([UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]] , 1.0) forPasteboardType:@"public.jpeg"];
        
         NSString *contentType = @"image";
         NSString *urlString = [NSString
         stringWithFormat:@"line://msg/%@/%@",
         contentType, pasteboard.name]; //从剪切板中获取图片，文字亦能够如此

        
        /***
         @{UIApplicationOpenURLOptionUniversalLinksOnly : @YES}
         YES  :也就是说只有安装了Link所对应的App的情况下才能打开这个 Link,而不是通过启动Safari方式打开这个Link的代表的网站.
         */
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString] options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @NO} completionHandler:^(BOOL success) {
                
            }];
        } else {
            // Fallback on earlier versions
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
    }else{
        NSURL *url = [NSURL URLWithString:ITUNES_LINE_URL];
        [[UIApplication sharedApplication] openURL:url];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
