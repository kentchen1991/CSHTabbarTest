//
//  TabView.h
//  mybox
//
//  Created by nice on 5/13/14.
//  Copyright (c) 2014 yes. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TabViewDelegate <NSObject>

- (void) touchTabViewAtIndex:(NSInteger) index;

@end

@interface TabView : UIView

@property (nonatomic, weak) id <TabViewDelegate> delegate;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSArray *array;


@property (nonatomic, strong) UIView *plusView;
@property (nonatomic, strong) UIButton *plusBtn;

- (void) setTabItem:(NSArray *) array;
- (void) setItemClickAtIndex:(NSInteger) index;


@end
