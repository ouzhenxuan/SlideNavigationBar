//
//  ZXNavCell.m
//  SlideNavigationBar
//
//  Created by 区振轩 on 2018/9/7.
//  Copyright © 2018年 区振轩. All rights reserved.
//

#import "ZXNavCell.h"

@implementation ZXNavCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc]init];
        [self.contentView addSubview:_label];
        
    }
    return self;
}
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    self.label.frame = self.contentView.frame;
}

@end
