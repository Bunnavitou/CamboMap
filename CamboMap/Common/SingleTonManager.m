//
//  SingleTonManager.m
//  JobFood
//
//  Created by Yoman on 6/25/15.
//  Copyright (c) 2015 Yoman. All rights reserved.
//

#import "SingleTonManager.h"

@interface SingleTonManager()

@end

@implementation SingleTonManager

@synthesize IsCheck         = _IsCheck;
@synthesize IsLogin         = _IsLogin;
@synthesize IsSyncView      = _IsSyncView;

@synthesize arrSyncData     = _arrSyncData;

@synthesize strUserID       = _strUserID;
@synthesize strUserPW       = _strUserPW;

@synthesize intDayCount     = _intDayCount;
@synthesize intWeekCount    = _intWeekCount;
@synthesize intMonthCount   = _intMonthCount;

@synthesize dateStart       = _dateStart;
@synthesize dateEnd         = _dateEnd;


#pragma mark - Class Object Alloc -
static SingleTonManager *singleMgr = nil;

+ (SingleTonManager *)ShareSingleTonManager {
    if (singleMgr == nil)
        singleMgr = [[SingleTonManager alloc] init];
    
    return singleMgr;
}
- (id)init                                  {
    self = [super init];
    if (self != nil) {
        
        _IsLogin    = NO;
        _IsCheck    = NO;
        _IsSyncView = NO;
        
        _arrSyncData    = [[NSMutableArray alloc]init];
        
        _strUserID      = [[NSString alloc]init];
        _strUserPW      = [[NSString alloc]init];
        
        _intDayCount    = 0;
        _intWeekCount   = 0;
        _intMonthCount  = 0;
        
        _dateStart      = [[NSDate alloc]init];
        _dateEnd        = [[NSDate alloc]init];
    }
    return self;
}
- (id)copyWithZone:(NSZone *)zone           {
    return self;
}



@end
