//
//  MaVue.h
//  David_Toty_TP5_1_Imagier
//
//  Created by Knu on 01/11/16.
//  Copyright © 2016 Knu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaVue : UIView <UIScrollViewDelegate,UIToolbarDelegate>;


@property(readwrite,nonatomic,retain) UISlider* MonSlider;
@property(readwrite,nonatomic,retain) UIImageView* monImage;
@property(readwrite,nonatomic,retain) UIScrollView* monScrollView;
@property(readwrite,nonatomic,retain) UIToolbar* monToolBar;
@property(readwrite,nonatomic,retain) UIBarButtonItem *buttonBack;
@property(readwrite,nonatomic,retain) UIBarButtonItem *buttonNext;
@property(readwrite,nonatomic,retain) UIImage *imgRaw;

- (id) initWithFrame:(CGRect)frame andTitre:(NSString*)titre;

@end

