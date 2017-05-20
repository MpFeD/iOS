//
//  Modele.m
//  Quizz_Objective-C
//
//  Created by m2sar on 31/01/2017.
//  Copyright © 2017 UPMC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Modele.h"
#import <UIKit/UIKit.h>

@implementation Modele

int str;
int dmg;

NSArray* imgTab;


-(id) init{
    self = [super init];
    if(self){
        _level = 1;
        _expe = 1000;
        _hearthP = 1000;
        _myClass = @"Paysan";
        _myName = [[NSString alloc]init];
        _myName = @"TheHero";
        imgTab = [[NSArray alloc] init];
        dmg=5;
        str=10;
        _def=10;
    }
    return self;
}

-(int) attack{
    return dmg + (dmg * str / 100);
}


-(NSString*) toString{
    NSMutableString *mystr = [NSMutableString stringWithFormat:@"Hello! : %@ my level : %d my class : %@ str %d def %d dmg%d pt%d expe%d", _myName, _level,_myClass, str, _def, dmg, _pt, _expe];
    
    return mystr;
}

-(void) levelUP{
    _level = _level + 1;
    _pt=0;
    _expe += _expe/10;
    int r = arc4random() % 5;
    str+=r;
    r = arc4random() % 5;
    _def+=r;
    dmg ++;
    _hearthP+=_hearthP/10;
}

-(void) setImg:(NSString*)name{
    if(_myImgView != nil){
        [_myImgView release];
        _myImgView = nil;
    }
        
    _myImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
}

@end
