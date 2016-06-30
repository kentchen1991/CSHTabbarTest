//
//  TabView.m
//  mybox
//
//  Created by nice on 5/13/14.
//  Copyright (c) 2014 yes. All rights reserved.
//

#import "TabView.h"
#import "TabItem.h"
//#import "XDJConstant.h"
#import "UIView+Frame.h"

@interface TabView()



@end

@implementation TabView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _currentIndex = -1; // 初始为-1,这样当外部通过setItemClickAtIndex调用初始页面为第一页时才会生效
        [self setExclusiveTouch:YES];
        [self addSubview:self.plusView];
    }
    return self;
}



- (void) setTabItem:(NSArray *) array{
    _array = array;
    for(int i = 0; i < _array.count; i++){
        TabItem *item = [_array objectAtIndex:i];
        item.tag = i;
        item.itemBtn.tag = item.tag;
        // 给按钮添加事件
        [item.itemBtn addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
    }
}


- (void) setItemClickAtIndex:(NSInteger) index
{
    // 改变按钮状态
    [self clickItem:((TabItem *)[_array objectAtIndex:index]).itemBtn];
    
}


// 点击了Item
- (void)clickItem:(UIButton *)sender
{
    if (_currentIndex == sender.tag) {
        return;
    }
    
    _currentIndex = sender.tag;
    for (TabItem *item in _array) {
        
        if(sender == item.itemBtn){
            [item setSelect:YES];
        }else{
            [item setSelect:NO];
        }
    }
    // 改变当前页面
    [self.delegate touchTabViewAtIndex:_currentIndex];
    
}

-(UIView *)plusView {
    if (_plusView == nil) {
        CGFloat fTabW = [UIScreen mainScreen].bounds.size.width/3;
        CGFloat fTabH = 49;
        _plusView = [[UIView alloc] initWithFrame:CGRectMake(fTabW, 0, fTabW, fTabH)];
        _plusView.backgroundColor = [UIColor whiteColor];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, _plusView.frame.size.height-20, _plusView.frame.size.width, 20)];
        lab.textAlignment = 1;
        [lab setTextColor:[UIColor redColor]];
        lab.font = [UIFont systemFontOfSize:10];
        lab.text = @"发布课程";
        
        _plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_plusBtn setBackgroundColor:[UIColor orangeColor]];
        _plusBtn.frame = CGRectMake(0, 0, 40, 40);
        [_plusBtn addTarget:self action:@selector(releaseCourse:) forControlEvents:UIControlEventTouchUpInside];
        [_plusBtn setBackgroundImage:[[UIImage imageNamed:@"post_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:0];
        _plusBtn.centerY = self.plusView.centerY - 20;
        _plusBtn.centerX = self.plusView.width/2;
        [_plusView addSubview:_plusBtn];
        [_plusView addSubview:lab];
    }
    return _plusView;
}

- (void)releaseCourse:(UIButton*)btn {
    NSLog(@"发布课程");
}

@end
