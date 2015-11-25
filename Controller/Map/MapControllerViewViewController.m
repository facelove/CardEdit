//
//  MapControllerViewViewController.m
//  demo
//
//  Created by 王道钦 on 15/9/25.
//  Copyright (c) 2015年 wangdaoqinqiyi. All rights reserved.
//

#import "MapControllerViewViewController.h"

@interface MapControllerViewViewController ()
{
    MAPointAnnotation *annotationMy;
    double currentZoom;
    UIImageView *ping;
}
@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;
@end

@implementation MapControllerViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)initMapView
{
    [MAMapServices sharedServices].apiKey = @"a32e1969b8445a24dcd5b1b0e20c7149";
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 65, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-170)];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.pausesLocationUpdatesAutomatically = NO;
    _mapView.showsCompass=NO;
    _mapView.showsScale=NO;
    [_mapView setZoomLevel:17];
    currentZoom=17;
    [self.view addSubview:_mapView];
    
    
    ping=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22, 35)];
    ping.image=[UIImage imageNamed:@"pin_green@2x.png"];
    ping.center=_mapView.center;
    [self.view addSubview:ping];
}


-(void)initSearch
{
    //初始化检索对象
    _search = [[AMapSearchAPI alloc] initWithSearchKey:@"a32e1969b8445a24dcd5b1b0e20c7149" Delegate:self];
    
}

#pragma mark ---map search---
-(void)searchAddressFormAddressName:(NSString*)addressName
{
    if (addressName!=nil)
    {
        //构造 AMapGeocodeSearchRequest 对象,address 为必选项,city 为可选项
        AMapGeocodeSearchRequest *geoRequest = [[AMapGeocodeSearchRequest alloc] init];
        geoRequest.searchType = AMapSearchType_Geocode;
        geoRequest.address = addressName;
        geoRequest.city = @[@"beijing"];
        //发起正向地理编码
        [_search AMapGeocodeSearch: geoRequest];
    }
    
}
-(void)searchAddressFormLocation:(AMapGeoPoint*)location
{
    if (location!=nil)
    {
        //构造 AMapReGeocodeSearchRequest 对象,location 为必选项,radius 为可选项
        AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
        regeoRequest.location = location;
        regeoRequest.searchType = AMapSearchType_ReGeocode;
        regeoRequest.radius = 10000;
        regeoRequest.requireExtension = YES;
        //发起逆地理编码
        [_search AMapReGoecodeSearch: regeoRequest];
        
    }
}

//实现正向地理编码的回调函数
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    if(response.geocodes.count == 0) {
        return;
    }
    //处理搜索结果
    NSString *strCount = [NSString stringWithFormat:@"count: %ld", (long)response.count];
    NSString *strGeocodes = @"";
    for (AMapGeocode *p in response.geocodes)
    {
        strGeocodes = [NSString stringWithFormat:@"%@\ngeocode: (%f,%f)", strGeocodes, p.location.latitude,p.location.longitude];
    }
    NSString *result = [NSString stringWithFormat:@"%@ \n %@", strCount, strGeocodes];
    NSLog(@"Geocode: %@", result);
}
//实现逆地理编码的回调函数
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if(response.regeocode != nil)
    {
        //处理搜索结果
        NSString *result =[NSString stringWithFormat:@"ReGeocode: %@",response.regeocode];
        NSLog(@"ReGeo: %@", result);
    }
}
#pragma mark ---map action---
- (void)clearMapView
{
    _mapView.showsUserLocation = NO;
    [_mapView removeAnnotations:_mapView.annotations];
    _mapView.delegate = nil;
}
//添加标注
-(void)addAnnotationWithCooordinate:(CLLocationCoordinate2D)coordinate
{
    if (annotationMy==nil) {
        annotationMy = [[MAPointAnnotation alloc] init];
    }
    annotationMy.coordinate = coordinate;
    annotationMy.title    = @"地名";
    annotationMy.subtitle = @"如何前往asdasdasdasdsa";
    
    [_mapView addAnnotation:annotationMy];
}
#pragma mark ---map delegate---
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        
        CLLocation *newLocation = userLocation.location;
        
        //判断时间
        
        NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
        
        if (locationAge > 5.0)
            
        {
            
            return;
            
        }
        
        //判断水平精度是否有效
        
        if (newLocation.horizontalAccuracy < 0) {
            
            return;
            
        }
        
        //根据业务需求，进行水平精度判断，获取所需位置信息（100可改为业务所需值）
        
        CLLocationCoordinate2D myCoordinate;
        
        if(newLocation.horizontalAccuracy < 100)
            
        {
            
            //获取定位位置的经纬度
            
            myCoordinate = [newLocation coordinate];
            
            
            
        }
        
        //取出当前位置的坐标
        
        NSLog(@"latitude :%f,longitude: %f",myCoordinate.latitude,myCoordinate.longitude);
        
        _mapView.showsUserLocation=NO;
        
        [_mapView setCenterCoordinate:myCoordinate animated:YES];
    }
}

-(void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    if (mapView.zoomLevel!=currentZoom)
    {
        return;
    }
    ping.hidden=NO;
    [_mapView removeAnnotation:annotationMy];
    
}
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if (mapView.zoomLevel!=currentZoom)
    {
        currentZoom=mapView.zoomLevel;
        return;
    }
    
    NSLog(@"%f,%f",mapView.centerCoordinate.latitude,mapView.centerCoordinate.longitude);
    ping.hidden=YES;
    NSLog(@"paopaoend");
    [self addAnnotationWithCooordinate:mapView.centerCoordinate];
    [mapView selectAnnotation:annotationMy animated:YES];
}


- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.canShowCallout               = YES;
        annotationView.animatesDrop                 = YES;
        annotationView.draggable                    = YES;
        annotationView.rightCalloutAccessoryView    = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.pinColor                     = MAPinAnnotationColorGreen;
        return annotationView;
    }
    else if ([annotation isKindOfClass:[MAUserLocation class]])
    {
        static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:userLocationStyleReuseIndetifier];
            annotationView.frame=CGRectMake(0, 0, 32, 32);
        }
        
        annotationView.image = [UIImage imageNamed:@"pin_green"];
        return annotationView;
    }
    return nil;
    
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    // 放到该方法中用以保证 userlocation 的 annotationView 已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.3];
        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
        pre.image = [UIImage imageNamed:@"pin_green"];
        pre.lineWidth = 3;
        //        pre.lineDashPattern = @[@6, @3];
        
        [_mapView updateUserLocationRepresentation:pre];
        
        view.calloutOffset = CGPointMake(0, 0);
        view.canShowCallout = NO;
        self.userLocationAnnotationView = view;
    }  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
