//
//  OCJSViewController.m
//  KVOTest
//
//  Created by danggui on 16/1/7.
//  Copyright © 2016年 danggui. All rights reserved.
//

#import "OCJSViewController.h"
#import "OCJSObject.h"

@interface OCJSViewController ()

@end

@implementation OCJSViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *httpStr=@"https://www.baidu.com";
    NSURL *httpUrl=[NSURL URLWithString:httpStr];
    NSURLRequest *httpRequest=[NSURLRequest requestWithURL:httpUrl];
    [self.MyWebView loadRequest:httpRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --webViewDelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //网页加载之前会调用此方法
    
    //retrun YES 表示正常加载网页 返回NO 将停止网页加载
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //开始加载网页调用此方法
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //网页加载完成调用此方法
    
//    //iOS调用js
//    //首先创建JSContext 对象（此处通过当前webView的键获取到jscontext）
//    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    NSString *alertJS=@"alert('test js OC')"; //准备执行的js代码
//    [context evaluateScript:alertJS];//通过oc方法调用js的alert
//    
//    
//    //js调用iOS
//    //第一种情况
//    //其中test1就是js的方法名称，赋给是一个block 里面是iOS代码
//    //此方法最终将打印出所有接收到的参数，js参数是不固定的 我们测试一下就知道
//    context[@"test1"] = ^() {
//        NSArray *args = [JSContext currentArguments];
//        for (id obj in args) {
//            NSLog(@"%@",obj);
//        }
//    };
//    //此处我们没有写后台（但是前面我们已经知道iOS是可以调用js的，我们模拟一下）
//    //首先准备一下js代码，来调用js的函数test1 然后执行
//    //一个参数
//    NSString *jsFunctStr=@"test1('参数1')";
//    [context evaluateScript:jsFunctStr];
//    
//    //二个参数
//    NSString *jsFunctStr1=@"test1('参数a','参数b')";
//    [context evaluateScript:jsFunctStr1];
//    
    

    if (webView.isLoading) {
        return;
    }

     NSLog(@"%@", [webView stringByEvaluatingJavaScriptFromString:@"document.title"]);
    //首先创建JSContext 对象（此处通过当前webView的键获取到jscontext）
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //第二种情况，js是通过对象调用的，我们假设js里面有一个对象 testobject 在调用方法
    //首先创建我们新建类的对象，将他赋值给js的对象
    
    OCJSObject *testJO=[OCJSObject new];
    context[@"WebObject"]=testJO;
    
    //同样我们也用刚才的方式模拟一下js调用方法
    NSString *jsStr1=@"window.WebObject.PublicMethod()";
    [context evaluateScript:jsStr1];
    NSString *jsStr2=@"window.WebObject.LoginJudge('参数1')";
    [context evaluateScript:jsStr2];
    NSString *jsStr3=@"window.WebObject.PayMethondParameter('参数A')";
    [context evaluateScript:jsStr3];
    
    
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //网页加载失败 调用此方法
}


@end
