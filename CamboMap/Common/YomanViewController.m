//
//  YomanViewController.m
//  JobTesting
//
//  Created by Yoman on 6/30/15.
//  Copyright (c) 2015 AlwasyHome. All rights reserved.
//

#import "YomanViewController.h"

@interface YomanViewController (){
    
    NSString *strTranCode;
}

@end

@implementation YomanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;

    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        self.navigationController.navigationBar.tintColor    = RGB(255,255,255);
        self.navigationController.navigationBar.barTintColor = RGB(0,154,255);
        self.navigationController.navigationBar.translucent  = NO;
        
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.edgesForExtendedLayout = UIRectEdgeBottom;
        
    }else {
        self.navigationController.navigationBar.tintColor = RGB(0,154,255);
        
    }
  
}
- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)sendTransaction:(NSString *)transCode requestDictionary:(NSDictionary *)requestDictionary{
    [[SercurityConnection sharedSecurityConnection] setDelegate:self];
    strTranCode = transCode;
    NSString *strFullURL= [NSString stringWithFormat:@"%@%@/",KServerURL,transCode];
    
    NSLog(@"%@",strFullURL);
    if(![[SercurityConnection sharedSecurityConnection] willConnect:strFullURL query:[requestDictionary JSONRepresentation] method:TRANS_METHOD_POST]){
        [SysUtils showMessage:@"The process of communication. Please try again later."];
        return;
    }
}
-(void)returnResult:(NSString *)returnResult errorCode:(NSInteger)errorCode errorMessage:(NSString *)errorMessage{
    NSDictionary *transResponse	= nil;
    
    if(errorCode==200){
        transResponse = [returnResult JSONValue];
        [self returnTransaction:strTranCode responseDictionary:transResponse success:YES];
    }else{
        [self returnTransaction:strTranCode responseDictionary:transResponse success:NO];
    }
}
-(void)returnTransaction:(NSString *)transCode responseDictionary:(NSDictionary *)responseDictionary success:(BOOL)success{
   
}

@end
