//
//  ViewController.m
//  UIScrollView的基本使用
//
//  Created by apple on 16/4/29.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 可以把UIScrollView控件看成一个具有上下两层的控件，上面一层是显示层，可以把它看成是一个窗户，作用是用来显示的、给用户看的，下面一层是内容层，是指UIScrollView控件的内容大小，如果内容层的大小大于显示层的大小的话，则UIScrollView控件会自动具有滚动功能，用来滚动显示内容层的内容。
 
 UIScrollView控件的几个重要属性：
 1、contentSize：上述UIScrollView控件的显示层（上层）的大小由此控件的frame属性里面的size属性来决定，而内容层（下层）的大小则由此控件的contentSize属性来决定，如果想禁止某个方向的滚动，则可以在contentSize属性里面设置这个方向的值为0即可；
 2、contentOffset：内容层（下层）的左上角坐标与显示层（上层）的左上角坐标的差值就是contentOffset的值。如果内容层凸出显示层并且内容层往显示层的左边凸，则contentOffset的x值是正数，而且越往左边凸则x的值越大；如果内容层凸出显示层并且内容层往显示层的上边凸，则contentOffset的y值是正数，而且越往上边凸则y的值越大；如果内容层凹进显示层并且内容层往显示层的右边凹，则contentOffset的x值是负数，而且越往右边凹则x的值越小（负数，绝对值越大）；如果内容层凹进显示层并且内容层往显示层的下边凹，则contentOffset的y值是负数，而且越往下边凹则y值越小（负数，绝对值越大）；
 3、contentInset：这个属性能够在UIScrollView控件的四周增加额外的滚动区域，一般用来避免UIScrollView控件里面的内容被其他控件遮挡。
 */
#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     初始化UIImageView控件的方法1：
     */
//    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.image = [UIImage imageNamed:@"香港大学的民主墙"];
//    imageView.frame = CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height);  //UIImageView控件的宽和高取决于它里面的图片的宽和高
    
    /**
     初始化UIImageView控件的方法2：
     作用相当于方法1，一般采用这种方法。
     */
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"香港大学的民主墙"]];
    [self.scrollView addSubview:imageView];
    
    //设置UIScrollView控件的内容层（下层）的大小
    self.scrollView.contentSize = imageView.frame.size;
    
    //设置UIScrollView控件的contentInset属性
    self.scrollView.contentInset = UIEdgeInsetsMake(80, 0, 0, 0);
}

#pragma mark ————— 点击最左按钮 —————
- (IBAction)left:(id)sender
{
    /**
     设置动画的方法1：block方式
     */
    [UIView animateWithDuration:2.0 animations:^{
        self.scrollView.contentOffset = CGPointMake(0, self.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        NSLog(@"动画执行完毕");
    }];
}

#pragma mark ————— 点击最上按钮 —————
- (IBAction)top:(id)sender
{
    /**
     设置动画的方法2：
     因为setContentOffset方法只在UIScrollView控件中有，所以这种设置动画的方法只能在UIScrollView控件中使用。
     */
    CGPoint offset = CGPointMake(self.scrollView.contentOffset.x, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark ————— 点击最下按钮 —————
- (IBAction)bottom:(id)sender
{
    CGFloat offsetY = self.scrollView.contentSize.height - self.scrollView.frame.size.height;
    self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, offsetY);
    
    /**
     OC语法规定：不能直接修改OC对象的结构体属性里面的成员的值；
     所以不能直接写成self.scrollView.contentOffset.y = offsetY，只能写成上面的代码才可以。
     */
    
    //完成此效果的另外一种方法：
//    CGPoint offset = self.scrollView.contentOffset;
//    offset.y = offsetY;
//    self.scrollView.contentOffset = offset;
}

#pragma mark ————— 点击最右按钮 —————
- (IBAction)right:(id)sender
{
    /**
     设置动画的方法3：
     */
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];  //设置动画的执行时间
    [UIView setAnimationDelegate:self];  //只有设置了代理，并且撰写了下面的两句代码才会在动画开始和结束的时候执行指定的方法，如果不设置代理的话则下面的两句代码没有意义，所以在动画开始和结束的时候就不会执行指定的方法了。下面的两句代码是依赖于这句设置代理的语句的。
    [UIView setAnimationWillStartSelector:@selector(start)];  //在动画开始的时候调用start方法
    [UIView setAnimationDidStopSelector:@selector(stop)];  //在动画结束的时候调用stop方法
    
    //把需要动画执行的语句夹在设置动画的语句中间。
    CGFloat offsetX = self.scrollView.contentSize.width - self.scrollView.frame.size.width;
    self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    
    [UIView commitAnimations];  //提交动画
}

#pragma mark ————— 动画开始时调用的方法 —————
-(void)start
{
    NSLog(@"start");
}

#pragma mark ————— 动画结束时调用的方法 —————
-(void)stop
{
    NSLog(@"stop");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
