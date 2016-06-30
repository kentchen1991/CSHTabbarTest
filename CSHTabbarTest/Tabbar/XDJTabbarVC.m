//
//  XDJTabbarVC.m
//  XDJMallStandard
//
//  Created by apple on 16/3/7.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "XDJTabbarVC.h"
#import "XDJHomeVC.h"
#import "XDJAccountVC.h"
//#import "CBNavigationController.h"
//#import "XDJConfig.h"
//#import "XDJConstant.h"
#import "TabView.h"
#import "TabItem.h"
#import "XDJTabbar.h"
#define fTabW  [UIScreen mainScreen].bounds.size.width/3
#define fTabH  49

@interface XDJTabbarVC () <TabViewDelegate>
{
}
@property (nonatomic, strong) TabView *tabView;
@property (nonatomic, strong) XDJTabbar *tabbar;
@end

@implementation XDJTabbarVC

- (void)viewDidLoad{
    [super viewDidLoad];
    // 用来设置状态栏颜色
    //    [self.view setBackgroundColor:[AppUtil colorWithHexString:@"3d4496"]];  // 61,68,150
    //去掉原生 tabBar 的背景图和阴影
    //    self.tabBar.backgroundImage = [UIImage new];
    //    self.tabBar.shadowImage = [UIImage new];
    //设置自定义TabViewUI
    self.tabbar = [[XDJTabbar alloc] init];
    [self setValue:self.tabbar forKeyPath:@"tabBar"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setTabViewUI];
        // 添加子controller
        [self createChildViewControllers];
        
        [self.tabView setItemClickAtIndex:0];
    });
  
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //自定义 tabView会被挡住
    //    [self.tabBar bringSubviewToFront:self.tabView];
    
}

//取出系统自带的tabbar并把里面的按钮删除掉
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    NSLog(@"==%@",self.tabBar.subviews);
    for ( UIView * child in  self.tabBar.subviews) {
        
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    //调整tabBar 位置
    NSLog(@"%@",self.tabBar.subviews);
    //    self.tabBar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-fTabH, [UIScreen mainScreen].bounds.size.width, fTabH);
    for (UIView *child in self.tabBar.subviews) {
        
        if ([child isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [child removeFromSuperview];
        }
        
    }
}


#pragma mark - 创建子控制器
- (void)createChildViewControllers
{
    
    // 首页
    XDJHomeVC* homePageVC = [[XDJHomeVC alloc] init];
    
    UINavigationController *homePageNaviVC = [[UINavigationController alloc] initWithRootViewController:homePageVC];
    

    homePageNaviVC.navigationBar.translucent = NO;
    homePageVC.title = @"首页";
    XDJAccountVC *accountVC = [[XDJAccountVC alloc] init];
    UINavigationController *accountNaviVC = [[UINavigationController alloc] initWithRootViewController:accountVC];
    accountNaviVC.navigationBar.translucent = NO;
    accountVC.title = @"我的";
    self.viewControllers = @[homePageNaviVC, accountNaviVC];
    
}

// 设置初始界面
- (void)setInitialIndex:(NSUInteger) index{
    self.selectedIndex = index;
}

// 重写UITabBarController的方法
- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    [_tabView setItemClickAtIndex:selectedIndex];
}

/**
 *  设置自定义TabView
 */
- (void)setTabViewUI{
    
    _tabView = [[TabView alloc]init];
    
    self.tabbar.tabV = _tabView;
    
    CGRect rect = self.tabBar.bounds;
    _tabView.delegate = self;
    _tabView.frame = rect;
    // 底部tabbar
    TabItem *message = [[TabItem alloc] initWithFrame:CGRectMake(0, 0, fTabW, fTabH)];
    message.itemLabel.text = @"首页";
    message.hightIconStr = @"tabbar_icon_home_selected";
    message.nomalIconStr = @"tabbar_icon_home_normal";
    
    
//    TabItem *releaseCourse = [[TabItem alloc] initWithFrame:CGRectMake(fTabW, -20, fTabW, fTabH+20)];
//    message.itemLabel.text = @"发布课程";
//    message.hightIconStr = @"tabbar_icon_home_selected";
//    message.nomalIconStr = @"tabbar_icon_home_normal";

    TabItem *account = [[TabItem alloc] initWithFrame:CGRectMake(fTabW * 2, 0,fTabW, fTabH)];
    account.itemLabel.text = @"我的";
    account.hightIconStr = @"tabbar_icon_person_selected";
    account.nomalIconStr = @"tabbar_icon_person_normal";
    [_tabView setTabItem:@[message ,account]];
    [self.tabBar addSubview:_tabView];
}


#pragma mark - TabViewDelegate
- (void)touchTabViewAtIndex:(NSInteger)index{
    if (self.selectedIndex == index) {
        return;
    }
    self.selectedIndex = index;
}

@end
