//
//  TabItem.m
//  mybox
//
//  Created by nice on 5/13/14.
//  Copyright (c) 2014 yes. All rights reserved.
//

#import "TabItem.h"


@interface TabItem()

@property (nonatomic, strong) UIImage *nomalImg;
@property (nonatomic, strong) UIImage *hightLImg;

@end


@implementation TabItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _itemBtn = [[UIButton alloc] initWithFrame:self.bounds];//self.bounds
        _itemBtn.opaque = YES;
        [_itemBtn setBackgroundColor:[UIColor whiteColor]];
        _itemBtn.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, 0);
        [self addSubview:_itemBtn];
        _itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 15, self.bounds.size.width, 10)];
        _itemLabel.backgroundColor = [UIColor whiteColor];
        _itemLabel.textColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0f];
        _itemLabel.textAlignment = NSTextAlignmentCenter;
        _itemLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:_itemLabel];
        [self setExclusiveTouch:YES];//单点触控 陈+
        _iconImgV = [[UIImageView alloc]initWithFrame:CGRectMake((self.bounds.size.width-20)/2, 10, 20, 20)];

        [self addSubview:_iconImgV];
        
        
    }
    return self;
}

- (void) setSelect:(BOOL)isSelect {
    if (isSelect) {
        [self animationSelf];
        _iconImgV.image = _hightLImg;
        [self.itemBtn setSelected:YES];
        [self.itemBtn setUserInteractionEnabled:NO];
        [self.itemLabel setTextColor:[UIColor colorWithRed:288/255.0f green:58/255.0f blue:61/255.0f alpha:1.0f]];
    }else {
        _iconImgV.image = _nomalImg;
        [self.itemBtn setSelected:NO];
        [self.itemBtn setUserInteractionEnabled:YES];
        [self.itemLabel setTextColor:[UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0f]];
    }
}

-(void)setNomalIconStr:(NSString *)nomalIconStr {
    _nomalIconStr = nomalIconStr;
    _nomalImg = [[UIImage imageNamed:_nomalIconStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

-(void)setHightIconStr:(NSString *)hightIconStr {
    _hightIconStr = hightIconStr;
    _hightLImg = [[UIImage imageNamed:hightIconStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)animationSelf {
    /* 放大缩小 */
    
    // 设定为缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    // 动画选项设定
    animation.duration = 0.2; // 动画持续时间
    animation.repeatCount = 1; // 重复次数
    animation.autoreverses = YES; // 动画结束时执行逆动画
    
    // 缩放倍数
    animation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
//    animation.byValue = [NSNumber numberWithFloat:2.0]; // 结束时的倍率
     animation.toValue = [NSNumber numberWithFloat:1.3];
    // 添加动画
    [self.iconImgV.layer addAnimation:animation forKey:@"scale-layer"];
}


@end
