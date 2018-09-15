//
//  Slide.m
//  SlideNavigationBar
//
//  Created by 区振轩 on 2018/9/7.
//  Copyright © 2018年 区振轩. All rights reserved.
//

#import "ZXFollowSlide.h"
#import "ZXNavCell.h"
#import "ZXContentCell.h"


#define ShowItemCount 5 //显示的导航item个数
#define WIDTH self.frame.size.width
#define NAVTITLENUM 10 //显示的导航item个数


@interface ZXFollowSlide() <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSIndexPath * pervious; //记录之前的cell的indexpath
@property (nonatomic, assign) NSInteger currentIndex;// 当前选中的item
@property (nonatomic,strong) UICollectionView * contentView;
@property (nonatomic,strong) UICollectionView * navView;
@property (nonatomic,strong) UIView * wavyLine;

@property (nonatomic, strong) NSMutableArray *titleArr;
@end



@implementation ZXFollowSlide

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initTheView];
        self.pervious = [NSIndexPath indexPathForRow:0 inSection:0];
        self.titleArr = [NSMutableArray arrayWithObjects:@"要闻",@"头条",@"订阅",@"体育",@"财经",@"科技",@"独家",@"健康", @"航空",@"历史", nil];
        [self createKVOAction];
    }
    return self;
}

- (void)initTheWavyLine{
    
}

- (void)initTheView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height - 55);
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.contentView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 55, self.frame.size.width , self.frame.size.height - 55) collectionViewLayout:layout];
    [self addSubview:self.contentView];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.delegate = self;
    self.contentView.dataSource = self;
    self.contentView.showsHorizontalScrollIndicator = NO;
    self.contentView.pagingEnabled = YES;
    [self.contentView registerClass:[ZXContentCell class] forCellWithReuseIdentifier:@"content"];
    
    UICollectionViewFlowLayout *layout1 = [[UICollectionViewFlowLayout alloc]init];
    layout1.itemSize = CGSizeMake(self.frame.size.width / ShowItemCount, 50);
    layout1.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    layout1.minimumLineSpacing = 0;
    self.navView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 5, self.frame.size.width, 50) collectionViewLayout:layout1];
    [self addSubview:self.navView];
    self.navView.backgroundColor = [UIColor whiteColor];
    self.navView.delegate = self;
    self.navView.dataSource = self;
    [self.navView registerClass:[ZXNavCell class] forCellWithReuseIdentifier:@"nav"];
    self.navView.showsHorizontalScrollIndicator = NO;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (collectionView == self.contentView) {
        ZXContentCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"content" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0f green:arc4random() % 256 / 255.0f blue:arc4random() % 256 / 255.0f alpha:1.0f];
        
        cell.label.text = self.titleArr[indexPath.row];
        
        return cell;
    }else{
        ZXNavCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"nav" forIndexPath:indexPath];
        
        cell.label.textAlignment = 1;
        if (indexPath.row == self.currentIndex) {
            cell.label.textColor = [UIColor redColor];
            cell.label.font = [UIFont systemFontOfSize:18];
        }else {
            cell.label.font = [UIFont systemFontOfSize:15];
            cell.label.textColor = [UIColor blackColor];
        }
        if (indexPath.row == _pervious.row) {
            cell.label.textColor = [UIColor redColor];
            cell.label.font = [UIFont systemFontOfSize:18];
        }else {
            cell.label.font = [UIFont systemFontOfSize:15];
            cell.label.textColor = [UIColor blackColor];
            
        }
        cell.label.text = _titleArr[indexPath.item];
        return cell;
    }
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.navView) {
        [self.contentView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        ZXNavCell *cell = (ZXNavCell *)[_navView cellForItemAtIndexPath:indexPath];
        cell.label.textColor = [UIColor redColor];
        cell.label.font = [UIFont systemFontOfSize:18];
        ZXNavCell *pastCell = (ZXNavCell *)[_navView cellForItemAtIndexPath:_pervious];
        if (indexPath != _pervious) {
            pastCell.label.textColor = [UIColor blackColor];
            pastCell.label.font = [UIFont systemFontOfSize:15];
        }
        _pervious = indexPath;
        self.currentIndex = _pervious.item;
    }
}


- (void)createKVOAction {
    [self.contentView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:@"nil"];
}

// 添加观察者之后 自动调用此方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    CGFloat x = [[change objectForKey:@"new"] CGPointValue].x;
    
    CGFloat titleWidth =  WIDTH / ShowItemCount/1.0;
    NSLog(@"%ld",self.currentIndex);
    int centerNum = ShowItemCount / 2  ;

    
    if (x >= WIDTH*centerNum && x<=WIDTH*(NAVTITLENUM - 1 - centerNum)) { //-1是因为index从0开始
        double offsetx =   (x/WIDTH/1.0- centerNum) * titleWidth;
        self.navView.contentOffset = CGPointMake(offsetx , 0);
    }else if(x < WIDTH*centerNum){
        [UIView animateWithDuration:0.23 animations:^{
            self.navView.contentOffset = CGPointMake(0, 0);
        }];
    }else if(x>WIDTH*(NAVTITLENUM - 1 - centerNum)){
        NSIndexPath * endPath = [NSIndexPath indexPathForItem:NAVTITLENUM -1 inSection:0];
        [self.navView scrollToItemAtIndexPath:endPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }
}
#pragma mark scrollView的代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == self.contentView) {
        // 当前大collectionView 第几个item
        //1.根据偏移量判断一下应该显示第几个item
        CGFloat offSetX = scrollView.contentOffset.x;
        CGFloat itemWidth = WIDTH;
        //item的宽度+行间距 = 页码的宽度
        NSInteger pageWidth = itemWidth;
        //根据偏移量计算是第几页
        NSInteger currentItemCount = (offSetX+pageWidth/2)/pageWidth;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentItemCount inSection:0];
        ZXNavCell *currentCell = (ZXNavCell *)[_navView cellForItemAtIndexPath:indexPath];
        currentCell.label.textColor = [UIColor redColor];
        currentCell.label.font = [UIFont systemFontOfSize:18];
        NSIndexPath *indexPathPast = self.pervious;
        
        if (indexPath != indexPathPast) {
            // 根据indexPath获取当前的小collectionViewCell
            
            ZXNavCell *pastCell = (ZXNavCell *)[_navView cellForItemAtIndexPath:indexPathPast];
            pastCell.label.textColor = [UIColor blackColor];
            pastCell.label.font = [UIFont systemFontOfSize:15];
        }
        self.currentIndex = currentItemCount;
        self.pervious = indexPath;
        
    }
    
}

- (void) scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
}

@end
