//
//  DGAaimaView.h
//  animaByIdage
//
//  Created by chuangye on 15-3-11.
//  Copyright (c) 2015年 chuangye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGEarthView.h"
@interface DGAaimaView : UIView

@property(nonatomic,strong)DGEarthView *ainmeView;
-(void)DGAaimaView:(DGAaimaView*)animView earthSepped:(CGFloat)eCS huojianSepped:(CGFloat)hCS ;

@end
