//
//  CSJ_NavGestureViewController.m
//  CSJToolsDemo
//
//  Created by 曹 盛杰 on 14-2-22.
//  Copyright (c) 2014年 曹 盛杰. All rights reserved.
//

#import "CSJ_NavGestureViewController.h"

#define KEY_WINDOW  [[UIApplication sharedApplication] keyWindow]
#define TOP_VIEW    (KEY_WINDOW.rootViewController.view)

@interface CSJ_NavGestureViewController ()
{
    dispatch_once_t onceToken;
}
@property (nonatomic, strong) NSMutableArray *snapshotStack;
@property (nonatomic, strong) UIImageView *snapshotImageView;
@property (nonatomic, strong) UIView *alphaView;
@property (nonatomic, assign) CGFloat lastTouchX;
@end


@implementation CSJ_NavGestureViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setupGestureIfNeed {
    dispatch_once(&onceToken, ^{
        UIPanGestureRecognizer *panPopGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        panPopGesture.delegate = self;
        [self.view addGestureRecognizer:panPopGesture];
        _snapshotStack = [NSMutableArray array];
    });
}

-(void)viewWillAppear:(BOOL)animated
{
    [self addShadowForView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - capture last view's snapshot

- (UIImage *)takeSnapshot
{
    UIGraphicsBeginImageContextWithOptions(TOP_VIEW.bounds.size, TOP_VIEW.opaque, 0.0);
    [TOP_VIEW.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshot;
}

#pragma mark - override push

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        [self setupGestureIfNeed];
        
        //存储照片
        UIImage *image = [self takeSnapshot];
        [self.snapshotStack addObject:image];
    }
    /*
    if (!self.snapshotStack) {
        self.snapshotStack = [[NSMutableArray alloc] initWithCapacity:0];
    }
    UIImage *snapshot = [self takeSnapshot];
    if (snapshot) [self.snapshotStack addObject:snapshot];
    */
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    [self.snapshotStack removeLastObject];
    return [super popViewControllerAnimated:animated];
}
#pragma mark - handlePanGesture

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGestureRecognizer
{
    if (self.viewControllers.count <= 1) return ;
    
    CGPoint point = [panGestureRecognizer locationInView:KEY_WINDOW];
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [self initSnapshot];
        self.snapshotImageView.image = [self.snapshotStack lastObject];
        self.snapshotImageView.hidden = NO;
        [TOP_VIEW.superview insertSubview:self.snapshotImageView belowSubview:TOP_VIEW];
        self.lastTouchX = point.x;
        //        [self addShadowForView];
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGRect frame = TOP_VIEW.frame;
        //61.5 = 239 - 177.5 + 0
        CGFloat newX = (point.x - self.lastTouchX) + frame.origin.x;
        if (newX < 0) {
            return;
        }
        frame.origin.x = newX;
        TOP_VIEW.frame = frame;
        self.lastTouchX = point.x;
        [self offsetImageViewForX:newX];
    } else {
        [self judgeToPushOrPop];
    }
}

- (void)initSnapshot
{
    if (!self.snapshotImageView) {
        self.snapshotImageView = [[UIImageView alloc] initWithFrame:TOP_VIEW.bounds];
    }
    CGRect imageViewFrame = TOP_VIEW.bounds;
    imageViewFrame.origin.x = -TOP_VIEW.bounds.size.width / 3 * 2;
    self.snapshotImageView.frame = imageViewFrame;
}

#pragma mark - judgeToPushOrPop

- (void)judgeToPushOrPop
{
    __block CGRect frame = TOP_VIEW.frame;
    //238 > 320/3
    //    NSLog(@"frame.origin.x = %f,frame.size.width = %f",frame.origin.x,frame.size.width/6);
    if (frame.origin.x > (frame.size.width / 6)) {
        [UIView animateWithDuration:0.3 animations:^{
            frame.origin.x = frame.size.width;
            TOP_VIEW.frame = frame;
            [self offsetImageViewForX:frame.origin.x];
        } completion:^(BOOL finished) {
            [self popViewControllerAnimated:NO];
            self.snapshotImageView.hidden = YES;
            frame.origin.x = 0;
            TOP_VIEW.frame = frame;
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            frame.origin.x = 0;
            TOP_VIEW.frame = frame;
            [self offsetImageViewForX:frame.origin.x];
        } completion:^(BOOL finished) {
            self.snapshotImageView.hidden = YES;
        }];
    }
}

- (void)offsetImageViewForX:(CGFloat)x {
    CGFloat imageViewX = x / 3 * 2  -TOP_VIEW.bounds.size.width / 3 * 2;
    CGRect imageViewFrame = self.snapshotImageView.frame;
    imageViewFrame.origin.x = imageViewX;
    self.snapshotImageView.frame = imageViewFrame;
}

- (void)addShadowForView {
    UIView *shadowedView = self.view;
    UIBezierPath* newShadowPath = [UIBezierPath bezierPathWithRect:shadowedView.bounds];
    shadowedView.layer.masksToBounds = NO;
    shadowedView.layer.shadowRadius = 10;
    shadowedView.layer.shadowOpacity = 1;
    shadowedView.layer.shadowColor = [[UIColor blackColor] CGColor];
    shadowedView.layer.shadowOffset = CGSizeZero;
    shadowedView.layer.shadowPath = [newShadowPath CGPath];
}

@end
