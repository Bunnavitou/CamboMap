//
//  DGAaimaView.m
//  animaByIdage
//
//  Created by chuangye on 15-3-11.
//  Copyright (c) 2015年 chuangye. All rights reserved.
//

#import "DGAaimaView.h"
#import "DGEarthView.h"
@implementation DGAaimaView
{
    

}
-(void)DGAaimaView:(DGAaimaView*)animView earthSepped:(CGFloat)eCS huojianSepped:(CGFloat)hCS {
    _ainmeView.EarthSepped=eCS;
    _ainmeView.huojiansepped=hCS;
}
- (void)awakeFromNib{
    [self animaInit];
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self animaInit];
    }
    return self;
}
-(void)animaInit{

    self.backgroundColor =[UIColor clearColor];

    DGEarthView * ainmeView =[[DGEarthView alloc]initWithFrame:self.bounds];
    [self addSubview:ainmeView];
    
}



@end
