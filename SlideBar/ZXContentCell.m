//
//  ZXContentCell.m
//  SlideNavigationBar
//
//  Created by 区振轩 on 2018/9/7.
//  Copyright © 2018年 区振轩. All rights reserved.
//

#import "ZXContentCell.h"

@implementation ZXContentCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc]init];
        self.label.frame = CGRectMake(0, 0, 100, 50);
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.center = self.center;
        [self.contentView addSubview:_label];
    }
    return self;
}
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    
}

@end
