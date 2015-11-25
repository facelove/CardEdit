//
//  CDRTranslucentSideBar.m
//  CDRTranslucentSideBar
//
//  Created by UetaMasamichi on 2014/06/16.
//  Copyright (c) 2014年 nscallop. All rights reserved.
//



#import "CDRTranslucentSideBar.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface CDRTranslucentSideBar ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * leftTableview;
    UILabel * userNameLable;
    UILabel * telephoneNumber;
}
@property (nonatomic, strong) UIToolbar *translucentView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property CGPoint panStartPoint;
@end

@implementation CDRTranslucentSideBar

- (id)initWithData:(NSArray*)data
{
    self = [super init];
    if (self) {
        self.dataArray=data;
        [self initCDRTranslucentSideBar];
    }
    return self;
}

- (id)initWithData:(NSArray*)data   Direction:(BOOL)showFromRight
{
    self = [super init];
    if (self) {
        self.dataArray=data;
        _showFromRight = showFromRight;
        [self initCDRTranslucentSideBar];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

#pragma mark - Custom Initializer
- (void)initCDRTranslucentSideBar
{
    _hasShown = NO;
    self.isCurrentPanGestureTarget = NO;

    self.sideBarWidth = 200;
    self.animationDuration = 0.25f;

    [self initTranslucentView];

    self.view.backgroundColor = [UIColor clearColor];
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    self.tapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    self.panGestureRecognizer.minimumNumberOfTouches = 1;
    self.panGestureRecognizer.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:self.panGestureRecognizer];
    
    
    leftTableview=[[UITableView alloc] initWithFrame:CGRectMake(0,0, self.sideBarWidth, [UIScreen mainScreen].bounds.size.height-NavgationBar)];
    leftTableview.backgroundColor=[UIColor whiteColor];
    leftTableview.delegate=self;
    leftTableview.dataSource=self;
    [leftTableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self setContentViewInSideBar:leftTableview];
    
}

- (void)initTranslucentView
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        CGRect translucentFrame =
            CGRectMake(self.showFromRight ? self.view.bounds.size.width : -self.sideBarWidth, 0, self.sideBarWidth, self.view.bounds.size.height);
        self.translucentView = [[UIToolbar alloc] initWithFrame:translucentFrame];
        self.translucentView.frame = translucentFrame;
        self.translucentView.contentMode = _showFromRight ? UIViewContentModeTopRight : UIViewContentModeTopLeft;
        self.translucentView.clipsToBounds = YES;
        self.translucentView.barStyle = UIBarStyleDefault;
        [self.view.layer insertSublayer:self.translucentView.layer atIndex:0];
    }
}

#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)loadView
{
    [super loadView];
}

#pragma mark - Layout
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];

    if ([self isViewLoaded] && self.view.window != nil) {
        [self layoutSubviews];
    }
}

- (void)layoutSubviews
{
    CGFloat x = self.showFromRight ? self.parentViewController.view.bounds.size.width - self.sideBarWidth : 0;

    if (self.contentView != nil) {
        self.contentView.frame = CGRectMake(x, 0, self.sideBarWidth, self.parentViewController.view.bounds.size.height);
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 120;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *clearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.sideBarWidth, 120)];
    clearView.backgroundColor = [UIColor whiteColor];
    
    UIImageView * imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60,60)];
    imageView.image=[UIImage imageNamed:@"userhead.png"];
    imageView.layer.cornerRadius=30;
    imageView.clipsToBounds=YES;
    [clearView addSubview:imageView];
    imageView.center=clearView.center;
    sx(imageView, 20);
    
    userNameLable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 15)];
    userNameLable.backgroundColor=[UIColor clearColor];
    userNameLable.textColor=[UIColor blackColor];
    userNameLable.font=[UIFont systemFontOfSize:14];
    userNameLable.text=@"王道钦";
    [clearView addSubview:userNameLable];
    sy(userNameLable, gy(imageView)+10);
    sx(userNameLable, gr(imageView)+10);
    
    
    
    telephoneNumber=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 15)];
    telephoneNumber.backgroundColor=[UIColor clearColor];
    telephoneNumber.textColor=[UIColor blackColor];
    telephoneNumber.font=[UIFont systemFontOfSize:14];
    telephoneNumber.text=@"18610448035";
    [clearView addSubview:telephoneNumber];
    sx(telephoneNumber, gx(userNameLable));
    sy(telephoneNumber, gb(userNameLable)+5);
    
    
    
    
    
    
    UILabel * bline=[[UILabel alloc] initWithFrame:CGRectMake(0, gh(clearView)-1, self.sideBarWidth, 1)];
    bline.backgroundColor=RGBCOLOR(230, 230, 230);
    [clearView addSubview:bline];
    
    return clearView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.backgroundColor = [UIColor clearColor];
    }
    NSDictionary *dic=[self.dataArray objectAtIndex:indexPath.row];
    cell.imageView.image=[UIImage imageNamed:dic[@"imagename"]];
    cell.textLabel.text=dic[@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}





#pragma mark - Accessor
- (void)setTranslucentStyle:(UIBarStyle)translucentStyle
{
    self.translucentView.barStyle = translucentStyle;
}

- (UIBarStyle)translucentStyle
{
    return self.translucentView.barStyle;
}

- (void)setTranslucent:(BOOL)translucent
{
    self.translucentView.translucent = translucent;
}

- (BOOL)translucent
{
    return self.translucentView.translucent;
}

- (void)setTranslucentAlpha:(CGFloat)translucentAlpha
{
    self.translucentView.alpha = translucentAlpha;
}

- (CGFloat)translucentAlpha
{
    return self.translucentView.alpha;
}

- (void)setTranslucentTintColor:(UIColor *)translucentTintColor
{
    self.translucentView.tintColor = translucentTintColor;
}

- (UIColor *)translucentTintColor
{
    return self.translucentView.tintColor;
}

#pragma mark - Show
- (void)showInViewController:(UIViewController *)controller animated:(BOOL)animated
{
    if ([self.delegate respondsToSelector:@selector(sideBar:willAppear:)]) {
        [self.delegate sideBar:self willAppear:animated];
    }

    [self addToParentViewController:controller callingAppearanceMethods:YES];
    self.view.frame = controller.view.bounds;

    CGFloat parentWidth = self.view.bounds.size.width;
    CGRect sideBarFrame = self.view.bounds;
    sideBarFrame.origin.x = self.showFromRight ? parentWidth : -self.sideBarWidth;
    sideBarFrame.size.width = self.sideBarWidth;

    if (self.contentView != nil) {
        self.contentView.frame = sideBarFrame;
    }
    sideBarFrame.origin.x = self.showFromRight ? parentWidth - self.sideBarWidth : 0;

    void (^animations)() = ^{
        if (self.contentView != nil) {
            self.contentView.frame = sideBarFrame;
        }
        self.translucentView.frame = sideBarFrame;
    };
    void (^completion)(BOOL) = ^(BOOL finished)
    {
        _hasShown = YES;
        self.isCurrentPanGestureTarget = YES;
        if (finished && [self.delegate respondsToSelector:@selector(sideBar:didAppear:)]) {
            [self.delegate sideBar:self didAppear:animated];
        }
    };

    if (animated) {
        [UIView animateWithDuration:self.animationDuration delay:0 options:kNilOptions animations:animations completion:completion];
    } else {
        animations();
        completion(YES);
    }
}

- (void)showAnimated:(BOOL)animated
{
    UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (controller.presentedViewController != nil) {
        controller = controller.presentedViewController;
    }
    [self showInViewController:controller animated:animated];
}

- (void)show
{
    [self showAnimated:YES];
}

#pragma mark - Show by Pangesture
- (void)startShow:(CGFloat)startX
{
    UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (controller.presentedViewController != nil) {
        controller = controller.presentedViewController;
    }
    [self addToParentViewController:controller callingAppearanceMethods:YES];
    self.view.frame = controller.view.bounds;

    CGFloat parentWidth = self.view.bounds.size.width;

    CGRect sideBarFrame = self.view.bounds;
    sideBarFrame.origin.x = self.showFromRight ? parentWidth : -self.sideBarWidth;
    sideBarFrame.size.width = self.sideBarWidth;
    if (self.contentView != nil) {
        self.contentView.frame = sideBarFrame;
    }
    self.translucentView.frame = sideBarFrame;
}

- (void)move:(CGFloat)deltaFromStartX
{

    CGRect sideBarFrame = self.translucentView.frame;
    CGFloat parentWidth = self.view.bounds.size.width;

    if (self.showFromRight) {
        CGFloat x = deltaFromStartX;
        if (deltaFromStartX >= self.sideBarWidth) {
            x = self.sideBarWidth;
        }
        sideBarFrame.origin.x = parentWidth - x;
    } else {
        CGFloat x = deltaFromStartX - _sideBarWidth;
        if (x >= 0) {
            x = 0;
        }
        sideBarFrame.origin.x = x;
    }

    if (self.contentView != nil) {
        self.contentView.frame = sideBarFrame;
    }
    self.translucentView.frame = sideBarFrame;
}

- (void)showAnimatedFrom:(BOOL)animated deltaX:(CGFloat)deltaXFromStartXToEndX
{
    if ([self.delegate respondsToSelector:@selector(sideBar:willAppear:)]) {
        [self.delegate sideBar:self willAppear:animated];
    }

    CGRect sideBarFrame = self.translucentView.frame;
    CGFloat parentWidth = self.view.bounds.size.width;

    sideBarFrame.origin.x = self.showFromRight ? parentWidth - sideBarFrame.size.width : 0;

    void (^animations)() = ^{
        if (self.contentView != nil) {
            self.contentView.frame = sideBarFrame;
        }

        self.translucentView.frame = sideBarFrame;
    };
    void (^completion)(BOOL) = ^(BOOL finished)
    {
        _hasShown = YES;
        if (finished && [self.delegate respondsToSelector:@selector(sideBar:didAppear:)]) {
            [self.delegate sideBar:self didAppear:animated];
        }
    };

    if (animated) {
        [UIView animateWithDuration:self.animationDuration delay:0 options:kNilOptions animations:animations completion:completion];
    } else {
        animations();
        completion(YES);
    }
}

#pragma mark - Dismiss
- (void)dismiss
{
    [self dismissAnimated:YES];
}

- (void)dismissAnimated:(BOOL)animated
{
    if ([self.delegate respondsToSelector:@selector(sideBar:willDisappear:)]) {
        [self.delegate sideBar:self willDisappear:animated];
    }

    void (^completion)(BOOL) = ^(BOOL finished)
    {
        [self removeFromParentViewControllerCallingAppearanceMethods:YES];
        _hasShown = NO;
        self.isCurrentPanGestureTarget = NO;
        if ([self.delegate respondsToSelector:@selector(sideBar:didDisappear:)]) {
            [self.delegate sideBar:self didDisappear:animated];
        }
    };

    if (animated) {
        CGRect sideBarFrame = self.translucentView.frame;
        CGFloat parentWidth = self.view.bounds.size.width;
        sideBarFrame.origin.x = self.showFromRight ? parentWidth : -self.sideBarWidth;
        [UIView animateWithDuration:self.animationDuration
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             if (self.contentView != nil) {
                                 self.contentView.frame = sideBarFrame;
                             }
                             self.translucentView.frame = sideBarFrame;
                         }
                         completion:completion];
    } else {
        completion(YES);
    }
}

#pragma mark - Dismiss by Pangesture
- (void)dismissAnimated:(BOOL)animated deltaX:(CGFloat)deltaXFromStartXToEndX
{
    if ([self.delegate respondsToSelector:@selector(sideBar:willDisappear:)]) {
        [self.delegate sideBar:self willDisappear:animated];
    }

    void (^completion)(BOOL) = ^(BOOL finished)
    {
        [self removeFromParentViewControllerCallingAppearanceMethods:YES];
        _hasShown = NO;
        self.isCurrentPanGestureTarget = NO;
        if ([self.delegate respondsToSelector:@selector(sideBar:didDisappear:)]) {
            [self.delegate sideBar:self didDisappear:animated];
        }
    };

    if (animated) {
        CGRect sideBarFrame = self.translucentView.frame;
        CGFloat parentWidth = self.view.bounds.size.width;
        sideBarFrame.origin.x = self.showFromRight ? parentWidth : -self.sideBarWidth + deltaXFromStartXToEndX;

        [UIView animateWithDuration:self.animationDuration
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             if (self.contentView != nil) {
                                 self.contentView.frame = sideBarFrame;
                             }
                             self.translucentView.frame = sideBarFrame;
                         }
                         completion:completion];
    } else {
        completion(YES);
    }
}

#pragma mark - Gesture Handler
- (void)handleTapGesture:(UITapGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:self.view];
    if (!CGRectContainsPoint(self.translucentView.frame, location)) {
        [self dismissAnimated:YES];
    }
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer
{
    if (!self.isCurrentPanGestureTarget) {
        return;
    }

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.panStartPoint = [recognizer locationInView:self.view];
    }

    if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint currentPoint = [recognizer locationInView:self.view];
        if (!self.showFromRight) {
            [self move:self.sideBarWidth + currentPoint.x - self.panStartPoint.x];
        } else {
            [self move:self.sideBarWidth + self.panStartPoint.x - currentPoint.x];
        }
    }

    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint endPoint = [recognizer locationInView:self.view];

        if (!self.showFromRight) {
            if (self.panStartPoint.x - endPoint.x < self.sideBarWidth / 3) {
                [self showAnimatedFrom:YES deltaX:endPoint.x - self.panStartPoint.x];
            } else {
                [self dismissAnimated:YES deltaX:endPoint.x - self.panStartPoint.x];
            }
        } else {
            if (self.panStartPoint.x - endPoint.x >= self.sideBarWidth / 3) {
                [self showAnimatedFrom:YES deltaX:self.panStartPoint.x - endPoint.x];
            } else {
                [self dismissAnimated:YES deltaX:self.panStartPoint.x - endPoint.x];
            }
        }
    }
}

- (void)handlePanGestureToShow:(UIPanGestureRecognizer *)recognizer inView:(UIView *)parentView
{
    if (!self.isCurrentPanGestureTarget) {
        return;
    }

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.panStartPoint = [recognizer locationInView:parentView];
        [self startShow:self.panStartPoint.x];
    }

    if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint currentPoint = [recognizer locationInView:parentView];
        if (!self.showFromRight) {
            [self move:currentPoint.x - self.panStartPoint.x];
        } else {
            [self move:self.panStartPoint.x - currentPoint.x];
        }
    }

    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint endPoint = [recognizer locationInView:parentView];

        if (!self.showFromRight) {
            if (endPoint.x - self.panStartPoint.x >= self.sideBarWidth / 3) {
                [self showAnimatedFrom:YES deltaX:endPoint.x - self.panStartPoint.x];
            } else {
                [self dismissAnimated:YES deltaX:endPoint.x - self.panStartPoint.x];
            }
        } else {
            if (self.panStartPoint.x - endPoint.x >= self.sideBarWidth / 3) {
                [self showAnimatedFrom:YES deltaX:self.panStartPoint.x - endPoint.x];
            } else {
                [self dismissAnimated:YES deltaX:self.panStartPoint.x - endPoint.x];
            }
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (touch.view != gestureRecognizer.view) {
        return NO;
    }
    return YES;
}

#pragma mark - ContentView
- (void)setContentViewInSideBar:(UIView *)contentView
{
    if (self.contentView != nil) {
        [self.contentView removeFromSuperview];
    }
    self.contentView = contentView;
    [self.view addSubview:self.contentView];
}

#pragma mark - Helper
- (void)addToParentViewController:(UIViewController *)parentViewController callingAppearanceMethods:(BOOL)callAppearanceMethods
{
    if (self.parentViewController != nil) {
        [self removeFromParentViewControllerCallingAppearanceMethods:callAppearanceMethods];
    }

    if (callAppearanceMethods) [self beginAppearanceTransition:YES animated:NO];
    [parentViewController addChildViewController:self];
    [parentViewController.view addSubview:self.view];
    [self didMoveToParentViewController:self];
    if (callAppearanceMethods) [self endAppearanceTransition];
}

- (void)removeFromParentViewControllerCallingAppearanceMethods:(BOOL)callAppearanceMethods
{
    if (callAppearanceMethods) [self beginAppearanceTransition:NO animated:NO];
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    if (callAppearanceMethods) [self endAppearanceTransition];
}

@end
