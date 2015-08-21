//
//  SingleTonManager.h
//  JobFood
//
//  Created by Yoman on 6/25/15.
//  Copyright (c) 2015 Yoman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>

@interface SingleTonManager : NSObject{
    ///====1====Bool Declaration======================//
    BOOL _IsCheck;
    BOOL _IsLogin;
    BOOL _IsSyncView;
    
    ///====2====NSMutableArray Declaration============//
    NSMutableArray* _arrSyncData;
    
    
    ///====3====NSString Declaration==================//
    NSString* _strUserID;
    NSString* _strUserPW;
    
    ///====4====NSInteger Declaration=================//
    NSInteger _intDayCount;
    NSInteger _intWeekCount;
    NSInteger _intMonthCount;
    
    ///====5====NSDate Declaration====================//
    NSDate* _dateStart;
    NSDate* _dateEnd;
    
    
    
    //===Other
    
    CLLocationManager *_SlocationMananger;
    
    CGFloat *_latitudeLocation;
    CGFloat *_longitudeLocation;
    
}

///====1====Bool Declaration======================//
@property (nonatomic) BOOL IsCheck;
@property (nonatomic) BOOL IsLogin;
@property (nonatomic) BOOL IsSyncView;



///====2====NSMutableArray Declaration============//
@property (nonatomic, retain) NSMutableArray* arrSyncData;



///====3====NSString Declaration==================//
@property (nonatomic, retain) NSString* strUserID;
@property (nonatomic, retain) NSString* strUserPW;



///====4====NSInteger Declaration=================//
@property (nonatomic)   NSInteger intDayCount;
@property (nonatomic)   NSInteger intWeekCount;
@property (nonatomic)   NSInteger intMonthCount;


///====5====NSDate Declaration====================//
@property (nonatomic, copy)   NSDate* dateStart;
@property (nonatomic, copy)   NSDate* dateEnd;

//===Other
@property (nonatomic)  CLLocationManager * SlocationMananger;


@property (nonatomic)  CGFloat * latitudeLocation;
@property (nonatomic)  CGFloat * longitudeLocation;

+ (SingleTonManager *)ShareSingleTonManager;


@end
