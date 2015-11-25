
//  ViewController.m
//  demo
//
//  Created by wangdaoqinqiyi on 15/9/7.
//  Copyright (c) 2015年 wangdaoqinqiyi. All rights reserved.
//

#import "RootViewController.h"
#import "BaseViewController.h"
#import "CustomAnnotationView.h"
#import "CDRTranslucentSideBar.h"
#import "ChanceRoleView.h"
#import <ASIHTTPRequest/ASIHTTPRequest.h>
#import "CellDataObj.h"
#import "CardManage.h"
#import "CardDataObj.h"
#import "CCEaseRefresh.h"
@interface RootViewController ()<CDRTranslucentSideBarDelegate,ASIHTTPRequestDelegate,BaseCardDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView *ssTableView;
    CCEaseRefresh *refreshView;
}

@property(nonatomic,strong)NSArray * leftdata;
@property (nonatomic, strong)UIButton *left_UserInfo;
@property (nonatomic, strong)UIButton *right_MessageInfo;
@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;
@property(nonatomic,strong)NSMutableArray* dataArray;
@property (nonatomic,strong)ASIHTTPRequest*homeRequest;
@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataArray=[NSMutableArray array];
    ChanceRoleView*view=[[ChanceRoleView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.teacherHandler=^(ChanceRoleView*view)
    {
     dispatch_async(dispatch_get_main_queue(), ^{
        [view removeFromSuperview];
        [self makeTeacherView];
     });
        
    };
    view.studentHandler=^(ChanceRoleView*view){
        dispatch_async(dispatch_get_main_queue(), ^{
            [view removeFromSuperview];
            [self makeStudentView];
        });
        
    };
    [self.view addSubview:view];
}
-(void)viewDidAppear:(BOOL)animated {
    //_mapView.delegate = self;
    // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    //_mapView.delegate = nil; // 不用时，置nil
    [refreshView endRefreshing];
}
-(void)makeStudentView
{
        [self initTableView];
        [self initTopBar];
        [self initLefbar];
        [self requestHomeData];
}
-(void)makeTeacherView
{
    
    
}


-(void)initTopBar
{
    UIView *topbar=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, NavgationBar)];
    topbar.backgroundColor=[UIColor colorWithWhite:245.0/255.0 alpha:1.0];
    [self.view addSubview:topbar];
    UIView * line=[[UIView alloc] initWithFrame:CGRectMake(0, NavgationBar-1,[UIScreen mainScreen].bounds.size.width , 1)];
    line.backgroundColor=[UIColor colorWithWhite:220/255.0 alpha:1];
    [topbar addSubview:line];
    
    self.left_UserInfo=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.left_UserInfo setBackgroundImage:[UIImage imageNamed:@"round_menu_btn_normal"] forState:UIControlStateNormal];
    [self.left_UserInfo addTarget:self action:@selector(openLeftButton) forControlEvents:UIControlEventTouchUpInside];
    self.left_UserInfo.frame=CGRectMake(10, 25, 31, 31);
    [topbar addSubview:self.left_UserInfo];
    
    self.right_MessageInfo=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.right_MessageInfo setBackgroundImage:[UIImage imageNamed:@"topbar_bell_icon"] forState:UIControlStateNormal];
    [self.right_MessageInfo addTarget:self action:@selector(openRightButton) forControlEvents:UIControlEventTouchUpInside];
    self.right_MessageInfo.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-10-30, 25, 30, 30);
    [topbar addSubview:self.right_MessageInfo];
}
-(void)initLefbar
{
    self.leftdata = @[
                      @{@"title":@"我的课程",@"imagename":@"menu_icon_order"},
                      @{@"title":@"我的钱包",@"imagename":@"menu_icon_wallet"},
                      @{@"title":@"消息中心",@"imagename":@"menu_icon_message"},
                      @{@"title":@"推荐有奖",@"imagename":@"menu_icon_invitation"},
                      @{@"title":@"老师招募",@"imagename":@"menu_icon_game"},
                      @{@"title":@"设置",@"imagename":@"menu_setting"}];
    
    self.sideBar = [[CDRTranslucentSideBar alloc] initWithData:self.leftdata Direction:NO];
    self.sideBar.sideBarWidth = 200;
    self.sideBar.delegate = self;
    self.sideBar.tag = 0;
}
-(void)initTableView
{
    ssTableView=[[UITableView alloc] initWithFrame:CGRectMake(0,NavgationBar, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-NavgationBar)];
    [ssTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    ssTableView.delegate=self;
    ssTableView.dataSource=self;
    
    [self.view addSubview:ssTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    refreshView = [[CCEaseRefresh alloc] initInScrollView:ssTableView];
    [refreshView addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
}

- (void)dropViewDidBeginRefreshing:(CCEaseRefresh *)refreshControl {
    [self requestHomeData];
}


-(void)openLeftButton
{
     [self.sideBar show];
}
-(void)openRightButton
{
    
}
-(void)requestHomeData
{
    if (self.homeRequest) {
        [self.homeRequest cancel];
        self.homeRequest.delegate=nil;
        self.homeRequest=nil;
    }
    NSString *string=@"http://localhost/lulu/web/index.php?r=page&view=1";
     self.homeRequest=[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:string]];
     DNSLog(@"请求URL：%@",string);
    self.homeRequest.delegate=self;
    [self.homeRequest startAsynchronous];

}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *resPonseString=request.responseString;
    [self parseData:resPonseString];
     dispatch_async(dispatch_get_main_queue(), ^{
         [ssTableView reloadData];
         [refreshView endRefreshing];
     });
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
     dispatch_async(dispatch_get_main_queue(), ^{
    [refreshView endRefreshing];
     });
}
-(void)parseData:(NSString*)resPonseString
{
    if (self.dataArray.count>0) {
      [self.dataArray removeAllObjects];
    }
    
    NSDictionary*dic=(NSDictionary*)[resPonseString JSONSerializationValue];
    if ([[dic objectForKey:@"code"] isEqualToString:@"A00000"]) {
        DNSLog(@"请求到的数据为：%@",dic);
    }
    else
    {
        [SSToastView showToastWithMessage:@"更新数据失败" superView:self.view];
    }
    NSDictionary*dataDic=[dic objectForKey:@"data"];
    
    for (NSDictionary* oneCard in dataDic)
    {
        CellDataObj*instance=[CellDataObj fillDataFormDirectry:oneCard];
        [self.dataArray addObject:instance];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows=[self.dataArray count];
    return rows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellDataObj *obj=[self.dataArray objectAtIndex:indexPath.row];
    float height=[obj.height floatValue];
    return  height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellDataObj *obj=[self.dataArray objectAtIndex:indexPath.row];
    BaseCard*card=[[CardManage shardManage] createCardWith:obj delegate:self];
//    card.backgroundColor=RGBCOLOR(20+indexPath.row*40, 20+indexPath.row*40, 20+indexPath.row*40);
    return card;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}
-(void)didPressCardData:(CardDataObj *)obj
{
}
@end
