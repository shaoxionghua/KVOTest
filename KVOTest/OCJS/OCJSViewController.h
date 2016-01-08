//
//  OCJSViewController.h
//  KVOTest
//
//  Created by danggui on 16/1/7.
//  Copyright © 2016年 danggui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface OCJSViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *MyWebView;
@end
