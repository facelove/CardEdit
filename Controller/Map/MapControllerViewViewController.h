//
//  MapControllerViewViewController.h
//  demo
//
//  Created by 王道钦 on 15/9/25.
//  Copyright (c) 2015年 wangdaoqinqiyi. All rights reserved.
//

#import "BaseViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import <CoreLocation/CoreLocation.h>
@interface MapControllerViewViewController : BaseViewController<AMapSearchDelegate,MAMapViewDelegate>
{
    MAMapView *_mapView;
    AMapSearchAPI *_search;
}
@end
