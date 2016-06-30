//
//  TabItem.h
//  mybox
//
//  Created by nice on 5/13/14.
//  Copyright (c) 2014 yes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabItem : UIView{
    UIImage *_image;
    UIImage *_selected; 
}

@property (nonatomic, strong) UIButton *itemBtn;
@property (nonatomic, strong) UILabel *itemLabel;
@property (nonatomic, strong) UIImageView *iconImgV;
@property (nonatomic, copy) NSString *nomalIconStr;
@property (nonatomic, copy) NSString *hightIconStr;

//- (void) setImage:(NSString *)image highlightedImage:(NSString *)highlightedImage selectedImage:(NSString *)selectedImage text:(NSString *)text;
- (void) setSelect:(BOOL)isSelect;

@end
