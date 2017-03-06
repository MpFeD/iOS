//
//  MaVue.m
//  David_Toty_TP4_2
//
//  Created by m2sar on 26/10/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MaVue.h"


@implementation MaVue : UIView


- (void) drawRect:(CGRect)rect{
    [self dessineDansFormat:rect.size];
}

- (void) dessineDansFormat: (CGSize) format {
    int top=0;
    if (format.width > format.height)
        top=10;
    else
        top=0;
    
    [_MonSlider setFrame:CGRectMake(format.width/14,7*format.height/8, format.width-2*format.width/14, format.height/14)];
    [_monToolBar setFrame:CGRectMake(0,0, format.width, top+50)];
}

- (id) initWithFrame:(CGRect)frame andTitre:(NSString*)titre{
    self = [super initWithFrame:frame];
    
    if(self){
        _imgRaw = [UIImage imageNamed:titre];
        _monImage = [[UIImageView alloc] initWithImage:_imgRaw];
        _monScrollView = [[UIScrollView alloc] initWithFrame:frame];
        [_monScrollView setBackgroundColor:[UIColor whiteColor]];
        [_monScrollView setMaximumZoomScale:1.0];
        [_monScrollView setMinimumZoomScale:0.05];
        [_monScrollView setDelegate:self];
        [_monScrollView addSubview:_monImage];
        [self addSubview:_monScrollView];
        [_monImage release];
        [_imgRaw release];
        [_monScrollView setZoomScale:0.2 animated:true];
        
        _MonSlider = [[UISlider alloc] initWithFrame:frame];
        [_MonSlider setMinimumValue:0.05];
        [_MonSlider setMaximumValue:1];
        [_MonSlider setValue:50];
        [self addSubview:_MonSlider];
        
        _buttonBack = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:nil action:nil];
        
        _buttonNext = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:nil action:nil];
        
        UIBarButtonItem *smallSpace = [[UIBarButtonItem alloc]  initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        NSArray *toolsBarItems = [NSArray arrayWithObjects:_buttonBack,smallSpace,_buttonNext, nil];
        
        _monToolBar = [[UIToolbar alloc]initWithFrame:frame];
        [_monToolBar setBarStyle:UIBarStyleDefault];
        [_monToolBar setDelegate:self];
        [_monToolBar setItems:toolsBarItems];

        [self addSubview:_monToolBar];
        [_monToolBar release];
        [_MonSlider release];
        
    }
    return self;
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _monImage;
}

- (void) scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    [_monScrollView setZoomScale:scale];
}

@end
