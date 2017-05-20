//
//  CombatView.h
//  Quizz_Objective-C
//
//  Created by Knu on 15/03/17.
//  Copyright © 2017 UPMC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Modele.h"

@interface CombatView : UIView

@property(nonatomic,readwrite,retain) UILabel* heroName;
@property(nonatomic,readwrite,retain) UILabel* monsterName;
@property(nonatomic,readwrite,retain) UILabel* battleInfo;
@property(nonatomic, readwrite,retain) UIButton* buttonEnd;
@property(nonatomic, readwrite,retain) UIButton* buttonStart;
@property(nonatomic,readwrite,retain) UIImageView* bg;
@property (nonatomic, readwrite,retain) UIViewController *myController;
@property (nonatomic, readwrite,retain) UIImageView *heroView;
@property (nonatomic, readwrite,retain) UIImageView *monsterView;
@property (nonatomic, readwrite,retain) Modele *modele;


- (void) setPosition:(CGSize) format;
- (void) setBattle;
@end
