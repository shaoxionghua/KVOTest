//
//  AppDelegate.h
//  KVOTest
//
//  Created by danggui on 15/11/12.
//  Copyright © 2015年 danggui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height//获取屏幕高度，兼容性测试
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width//获取屏幕宽度，兼容性测试

#define ScreenHeightAuto [[UIScreen mainScreen] bounds].size.height /568 //获取屏幕高度，兼容性测试
#define ScreenWidthAuto [[UIScreen mainScreen] bounds].size.width /320 //获取屏幕宽度，兼容性测试


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

