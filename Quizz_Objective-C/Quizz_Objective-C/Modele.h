//
//  Modele.h
//  Quizz_Objective-C
//
//  Created by m2sar on 31/01/2017.
//  Copyright © 2017 UPMC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Modele : NSObject

@property(nonatomic,readwrite,retain) NSString* myName;
@property(nonatomic,readwrite,retain) NSString* myClass;
@property(nonatomic,readwrite,retain) UIImageView *myImgView;
@property(nonatomic,readwrite) int hearthP;
@property(nonatomic,readwrite) int def;
@property(nonatomic,readwrite) int level;
@property(nonatomic,readwrite) int pt;
@property(nonatomic,readwrite) int expe;

-(NSString*) toString;
-(void) levelUP;
-(int) attack;
-(void) setImg:(NSString*)name;

@end
