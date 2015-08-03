//
//  YomanViewController.h
//  JobTesting
//
//  Created by Yoman on 6/30/15.
//  Copyright (c) 2015 AlwasyHome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleTonManager.h"
#import "SercurityConnection.h"
#import "WebViewStyleViewController.h"
#import "JSON.h"
#import "Constants.h"
#import "URLUtils.h"

@interface YomanViewController : UIViewController<SecurityConnectionDelegate>{
    
    
}


- (void)sendTransaction:(NSString *)transCode requestDictionary:(NSDictionary *)requestDictionary;
- (void)returnTransaction:(NSString *)transCode responseDictionary:(NSDictionary *)responseDictionary success:(BOOL)success;


@end
