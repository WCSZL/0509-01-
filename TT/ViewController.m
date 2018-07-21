//
//  ViewController.m
//  TestScrollview
//
//  Created by wxw on 2018/5/8.
//  Copyright © 2018年 wxw. All rights reserved.
//

#import "ViewController.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic,assign) CGFloat contentOffsetX;
@property (nonatomic,strong) NSMutableArray *arrM;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    
    CGFloat preX = 5;
    CGFloat jianju = 5;
    NSInteger count = 6;
    CGFloat viewWidth = (width-2*jianju - 2*preX) / 3.0;
    
    [self addMiddomLineInView:self.view];
    
    UIScrollView *s = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 200, width, 80)];
    [self.view addSubview:s];
    s.contentSize = CGSizeMake(viewWidth * count + preX * 2 + jianju * (count - 1), 80);
    s.bounces = NO;
    s.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < count; i++) {
        CGRect rect = CGRectMake(preX + (viewWidth+jianju) * i , 0, viewWidth, 80);
        UIView *view = [[UIView alloc]initWithFrame:rect];
        view.backgroundColor = randomColor;
        [s addSubview:view];
        [self addMiddomLineInView:view];
        [self.arrM addObject:view];
    }
    s.delegate = self;
    
    //[s setContentOffset:CGPointMake(preX, 0)];
    
}
- (void)addMiddomLineInView:(UIView *)view{
    CGFloat x = view.bounds.size.width*0.5 - 0.5;
    CGFloat h = view.bounds.size.height;
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(x, 0, 1, h)];
    line.backgroundColor = [UIColor blackColor];
    [view addSubview:line];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    UIView *v1 = _arrM[0];
    CGFloat viewwidth = v1.bounds.size.width;

    NSInteger aa = scrollView.contentOffset.x / (viewwidth + 5) + 0.5;
    
    NSLog(@"scrollView.contentOffset.x===%f",scrollView.contentOffset.x / (viewwidth + 5) );
    NSLog(@"aa===%li",aa);
    self.contentOffsetX = aa * (viewwidth+5);
    
}

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    NSLog(@"Current method: %@",NSStringFromSelector(_cmd));
//}
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0){
//    NSLog(@"Current method: %@",NSStringFromSelector(_cmd));
//}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"Current method: %@",NSStringFromSelector(_cmd));
//
//    NSLog(@"%f",scrollView.contentOffset.x);

    [scrollView setContentOffset:CGPointMake(self.contentOffsetX, 0) animated:YES];




}

//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    NSLog(@"Current method: %@",NSStringFromSelector(_cmd));
//    [scrollView setContentOffset:CGPointMake(self.contentOffsetX, 0) animated:YES];
//}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //NSLog(@"Current method: %@",NSStringFromSelector(_cmd));
    
    [UIView animateWithDuration:0.5 animations:^{
        [scrollView setContentOffset:CGPointMake(self.contentOffsetX, 0) animated:NO];
    }];
    
    
}
//
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//    NSLog(@"Current method: %@",NSStringFromSelector(_cmd));
//}
//
//- (void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView API_AVAILABLE(ios(11.0), tvos(11.0)){
//    NSLog(@"Current method: %@",NSStringFromSelector(_cmd));
//}
- (NSMutableArray *)arrM{
    if (!_arrM) {
        _arrM = [NSMutableArray array];
    }
    return _arrM;
}

@end

