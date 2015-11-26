//
//  MapViewController.m
//  KVOTest
//
//  Created by danggui on 15/11/23.
//  Copyright © 2015年 danggui. All rights reserved.
//

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "WGS84TOGCJ02.h"
#import <MapKit/MapKit.h>


#define kDistanceCalculationInterval 10 // the interval (seconds) at which we calculate the user's distance
#define kNumLocationHistoriesToKeep 5 // the number of locations to store in history so that we can look back at them and determine which is most accurate
#define kValidLocationHistoryDeltaInterval 3 // the maximum valid age in seconds of a location stored in the location history
#define kMinLocationsNeededToUpdateDistance 3 // the number of locations needed in history before we will even update the current distance
#define kRequiredHorizontalAccuracy 40.0f // the required accuracy in meters for a location. anything above this number will be discarded



@interface MapViewController ()<MAMapViewDelegate, TrackingDelegate,CLLocationManagerDelegate,MKMapViewDelegate,AMapLocationManagerDelegate>
{
    NSMutableArray *locations;
    NSMutableArray *locationsArr;
    NSMutableArray *alldistance;
    
    NSMutableArray *locationsLat;
    NSMutableArray *locationslon;
    
    NSInteger noUpdates;
    CLLocationManager *locationMgr;
    MAPolyline *routeLine;
    MAMapRect routeRect;
    MAPolylineView *routeLineView;
    UILabel *lab ;
    
    CLLocation *_startingLocation;
    float _speed;
    float speedDistance;
    
    
    UIButton *btn;
    
}

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) Tracking *tracking;

@property (nonatomic, strong) AMapLocationManager *locationManager;


@end

@implementation MapViewController
@synthesize mapView  = _mapView;
@synthesize tracking = _tracking;



#pragma mark - Setup

/* 构建mapView. */
- (void)setupMapView
{
    [MAMapServices sharedServices].apiKey = @"d925b1acdd5daa89d7d00c3123551493";
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    
    _mapView.mapType = MAMapTypeStandard;
    //显示路况
    _mapView.showTraffic= NO;
    
    _mapView.logoCenter = CGPointMake(CGRectGetWidth(self.view.bounds)-55, 450);
    _mapView.showsCompass= YES; // 设置成NO表示关闭指南针；YES表示显示指南针
    _mapView.compassOrigin= CGPointMake(_mapView.compassOrigin.x, 22); //设置指南针位置
    
    _mapView.showsScale= YES;  //设置成NO表示不显示比例尺；YES表示显示比例尺
    
    _mapView.scaleOrigin= CGPointMake(_mapView.scaleOrigin.x, 22);  //设置比例尺位置
    
    _mapView.showsScale = NO;
    _mapView.showsCompass = NO;
    //    _mapView.showsLabels = NO;
    _mapView.rotateEnabled= NO;
    _mapView.rotateCameraEnabled= NO;
    _mapView.showsUserLocation = YES;    //YES 为打开定位，NO为关闭定位
    
    
    [_mapView setUserTrackingMode: MAUserTrackingModeNone animated:YES]; //地图跟着位置移动
    [self.view addSubview:self.mapView];
    
    [_mapView setZoomLevel:18.0];

}

/**
 *  ViewDidLoad
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [AMapLocationServices sharedServices].apiKey =@"d925b1acdd5daa89d7d00c3123551493";
    speedDistance =0;
    noUpdates = 0;
    locations = [[NSMutableArray alloc] init];
    locationsLat = [[NSMutableArray alloc] init];
    locationslon = [[NSMutableArray alloc] init];
     alldistance = [[NSMutableArray alloc]init];
    locationsArr = [[NSMutableArray alloc]init];
//    locationMgr = [[CLLocationManager alloc] init];
//    locationMgr.delegate = self;
//    locationMgr.desiredAccuracy =kCLLocationAccuracyBestForNavigation;
//    locationMgr.distanceFilter  = 5.0f;
//    [locationMgr startUpdatingLocation];
    
    
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
            //定位功能可用，开始定位
            self.locationManager = [[AMapLocationManager alloc] init];
            self.locationManager.delegate = self;
            self.locationManager.distanceFilter = 5;
            [self.locationManager setPausesLocationUpdatesAutomatically:NO];
            
            [self.locationManager setAllowsBackgroundLocationUpdates:YES];//iOS9(含)以上系统需设置

            
            [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
//            if ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)
//            {
//                [locationMgr requestAlwaysAuthorization];//添加这句
//            }
//            [locationMgr startUpdatingLocation];
        }
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"定位服务" message:@"您未开启定位服务，请到 设置--隐私--定位服务 中打开定位服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alt show];
    }

    
    [self setupMapView];
    
    
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
        }
        
        NSLog(@"location:%@", location);
        
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);

        }
    }];
    
    
    lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, 200, 30)];
    lab.text = @"距离";
    lab.backgroundColor = [UIColor redColor];
    [self.mapView addSubview:lab];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 80, 30)];
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:@"开始" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview:btn];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barStyle    = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;


}
- (void)Action:(UIButton *)sender
{
    if (sender.selected ==NO) {
        btn.selected = YES;
        [btn setTitle:@"停止" forState:UIControlStateNormal];
        [self.locationManager startUpdatingLocation];
    }
    else{
        btn.selected = NO;
        [btn setTitle:@"开始" forState:UIControlStateNormal];
        [self.locationManager stopUpdatingLocation];
    }
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.mapView.frame = self.view.bounds;
}

- (void)viewDidAppear:(BOOL)animated
{
    _mapView.centerCoordinate = _mapView.userLocation.location.coordinate;
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{

    
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);

    if (locationsArr.count >1) {
        speedDistance = [location distanceFromLocation:[locationsArr objectAtIndex:locationsArr.count-1]];
        
    }
    [locationsArr addObject:location];

    
    
    NSString* currentPointString = [locations lastObject];
    NSArray* latLonArr = [currentPointString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
    
    CLLocationDegrees latitude = [[latLonArr objectAtIndex:0] doubleValue];
    CLLocationDegrees longitude = [[latLonArr objectAtIndex:1] doubleValue];
    NSLog(@"%@",[NSString stringWithFormat:@"%.4f",latitude]);
    NSLog(@"%@",[NSString stringWithFormat:@"%.4f",longitude]);
    
    NSLog(@"%@",[NSString stringWithFormat:@"%.4f",_mapView.userLocation.location.coordinate.latitude]);
    NSLog(@"%@",[NSString stringWithFormat:@"%.4f",_mapView.userLocation.location.coordinate.longitude]);
    
    
    
    if ([[NSString stringWithFormat:@"%.4f",latitude] isEqualToString:[NSString stringWithFormat:@"%.4f",_mapView.userLocation.location.coordinate.latitude]]&&
        [[NSString stringWithFormat:@"%.4f",longitude] isEqualToString:[NSString stringWithFormat:@"%.4f",_mapView.userLocation.location.coordinate.longitude]])
    {
        NSLog(@"不加数组");
    }
    else
    {
        [locations addObject: [NSString stringWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude]];
        
        [locationsLat addObject:[NSString stringWithFormat:@"%f", _mapView.userLocation.location.coordinate.latitude]];
        [locationslon addObject:[NSString stringWithFormat:@"%f", _mapView.userLocation.location.coordinate.longitude]];
        
    }
    
    if (routeLine!=nil) {
        routeLine =nil;
    }
    if(routeLine!=nil)
        [self.mapView removeOverlay:routeLine];
    routeLine =nil;
    // create the overlay
    [self loadRoute];
    
    
    // add the overlay to the map
    if (nil != routeLine) {
        [self.mapView addOverlay:routeLine];
    }
    
    for (int i= 1 ; i<locations.count; i++) {
        
        if (locations.count<2) {
            return;
        }
        float lat1 = [[locationsLat objectAtIndex:i-1] floatValue];
        float lon1 = [[locationslon objectAtIndex:i-1] floatValue];
        float lat2 = [[locationsLat objectAtIndex:i] floatValue];
        float lon2 = [[locationslon objectAtIndex:i] floatValue];
        
        
        MAMapPoint point1 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(lat1,lon1));
        MAMapPoint point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(lat2,lon2));
        
        //2.计算距离
        CLLocationDistance distance = MAMetersBetweenMapPoints(point2,point1);
        [alldistance addObject:[NSString stringWithFormat:@"%.2f",distance]];
        speedDistance = speedDistance+fabs(distance);
        if (fabs(distance)<0) {
            exit(0);
        }
        lab.text = [NSString stringWithFormat:@"速度:%.2f,距离:%.2f",location.speed,speedDistance];
        
    }

}




- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id )overlay
{
//    MAOverlayView* polylineView = nil;

    MAPolylineView *polylineView;

    if(overlay == routeLine)
    {
//        MKPolyline *polyline = overlay;
        polylineView = [[MAPolylineView alloc] initWithPolyline:routeLine];
        polylineView.strokeColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.8];
        polylineView.lineWidth = 2.5;

    }
      return polylineView;


}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    
    
}

-(void) loadRoute
{
    
//    NSString*documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
//    NSString*newFielPath = [documentsPath stringByAppendingPathComponent:@"route.cvs"];
//    NSError*error =nil;
//    NSArray* pointStrings = [NSArray arrayWithContentsOfFile:newFielPath];
    
    MAMapPoint northEastPoint;
    MAMapPoint southWestPoint;
    
    // create a c array of points.
    MAMapPoint* pointArr = malloc(sizeof(CLLocationCoordinate2D) * locations.count);
    
    for(int idx = 0; idx < locations.count; idx++)
    {
        // break the string down even further to latitude and longitude fields.
        NSString* currentPointString = [locations objectAtIndex:idx];
        NSArray* latLonArr = [currentPointString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        
        CLLocationDegrees latitude = [[latLonArr objectAtIndex:0] doubleValue];
        CLLocationDegrees longitude = [[latLonArr objectAtIndex:1] doubleValue];

        
        
        
        // create our coordinate and add it to the correct spot in the array
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        
        MAMapPoint point = MAMapPointForCoordinate(coordinate);
        
        
        

              //
        // adjust the bounding box
        //
        
        // if it is the first point, just use them, since we have nothing to compare to yet.
        if (idx == 0) {
            northEastPoint = point;
            southWestPoint = point;
        }
        else
        {
            if (point.x > northEastPoint.x)
                northEastPoint.x = point.x;
            if(point.y > northEastPoint.y)
                northEastPoint.y = point.y;
            if (point.x < southWestPoint.x)
                southWestPoint.x = point.x;
            if (point.y < southWestPoint.y)
                southWestPoint.y = point.y;
        }
        
        pointArr[idx] = point;
        
    }
    
    // create the polyline based on the array of points.
    routeLine = [MAPolyline polylineWithPoints:pointArr count:locations.count];
    
    routeRect = MAMapRectMake(southWestPoint.x, southWestPoint.y, northEastPoint.x - southWestPoint.x, northEastPoint.y - southWestPoint.y);
    
    // clear the memory allocated earlier for the points
    free(pointArr);
    
}



@end
