//
//  CombatView.m
//  Quizz_Objective-C
//
//  Created by Knu on 15/03/17.
//  Copyright © 2017 UPMC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Modele.h"
#import "CombatView.h"
#import "ViewController.h"

@interface UIDevice (MyPrivateNameThatAppleWouldNeverUseGoesHere)
- (void) setOrientation:(UIInterfaceOrientation)orientation;
@end

@implementation CombatView: UIView


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (id) initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        _modele = [[Modele alloc]init];
        
        [self setBackgroundColor:[UIColor redColor]];
        _heroName = [[UILabel alloc]init];
        _monsterName = [[UILabel alloc]init];
        _battleInfo = [[UILabel alloc]init];
        _buttonEnd = [UIButton buttonWithType: UIButtonTypeSystem];
        _buttonStart = [UIButton buttonWithType: UIButtonTypeSystem];
        
        _heroName.textAlignment = NSTextAlignmentCenter;
        _heroName.textColor = [UIColor redColor];
        
        _monsterName.text = @"Monster";
        _monsterName.textAlignment = NSTextAlignmentCenter;
        _monsterName.textColor = [UIColor redColor];
        
        
        _battleInfo.textAlignment = NSTextAlignmentCenter;
        _battleInfo.textColor = [UIColor redColor];
        
        [_buttonEnd addTarget:self action:@selector(bEnd) forControlEvents:UIControlEventTouchDown];
        
        [_buttonStart addTarget:self action:@selector(bStart) forControlEvents:UIControlEventTouchDown];
        
        UIImage *img = [UIImage imageNamed:@"droite.png"];
        [_buttonEnd setImage:img forState:UIControlStateNormal];
        
        img = [UIImage imageNamed:@"gauche.png"];
        [_buttonStart setImage:img forState:UIControlStateNormal];
        
        int r = arc4random() % 4;
        if(r==1)
            _monsterView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Monster1"]];
        else if(r==2)
            _monsterView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Monster2"]];
        else
            _monsterView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Monster3"]];

        r = arc4random() % 4;
        if(r==1)
            _bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Bg1"]];
        else if(r==2)
            _bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Bg2"]];
        else
            _bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Bg3"]];
        
        _heroView = [[UIImageView alloc]init];
        
        [self addSubview:_bg];
        [self addSubview:_heroName];
        [self addSubview:_monsterName];
        [self addSubview:_buttonEnd];
        [self addSubview:_buttonStart];
        [self addSubview:_battleInfo];
        [self addSubview:_monsterView];
        
        
        [ _bg release];
        [ _heroName release];
        [ _monsterName release];
        [ _battleInfo release];
        [ _monsterView release];
        [ _heroView release];
        //[ _buttonEnd release];
        
        
    }
    return self;
}

-(void) bEnd{
    ((ViewController*)_myController).view = ((ViewController*)_myController).vue1;
    [[UIDevice currentDevice] setOrientation:UIInterfaceOrientationPortrait];
    [self release];
    self = nil;
}

-(void) bStart{
    
    int r = arc4random() % _modele.level;
    int monsterDmg = 1+r;
    r = arc4random() % _modele.level;
    int monsterLife = 800+r*10;
    int originalLife = _modele.hearthP;
    
    while(monsterLife> 0 && _modele.hearthP>0){
        monsterLife -= [_modele attack];
        _modele.hearthP -= (monsterDmg - monsterDmg*_modele.def/100);
        NSLog(@"%d %d",monsterLife, _modele.hearthP );
        
        if(monsterLife<= 0 && _modele.hearthP<=0){
            NSLog(@"draw");
            _battleInfo.text = [NSString stringWithFormat:@"%@",[_modele toString]];
            break;
        }
        
        if(monsterLife<= 0 ){
            NSLog(@"you win");
            _modele.hearthP=originalLife;
            _modele.pt+=100+(_modele.level/2);
            if (_modele.pt >= _modele.expe){
                [_modele levelUP];
            }
            _battleInfo.text = [NSString stringWithFormat:@"%@",[_modele toString]];
            break;
        }
        
        if(_modele.hearthP <= 0 ){
            NSLog(@"you lose");
            _battleInfo.text = [NSString stringWithFormat:@"%@",[_modele toString]];
            break;
        }
        
    }
    
}



-(void) setPosition:(CGSize)format{
        _heroName.frame = CGRectMake(format.width/6, format.height/16, format.width/8,  format.height/8);
        _monsterName.frame = CGRectMake(format.width-format.width/8-format.width/6,format.height/16,  format.width/8,  format.height/8);
        _buttonStart.frame = CGRectMake(format.width/2, format.height/16, format.width/8,  format.height/8);
        _buttonEnd.frame = CGRectMake(0, format.height/16, format.width/8,     format.height/8);
        _battleInfo.frame = CGRectMake(0, format.height-format.height/8	, format.width,  format.height/8);
        _monsterView.frame = CGRectMake(2*format.width/3, format.height/3	, format.width/3,  format.height/2);
        _modele.myImgView.frame = CGRectMake(0, format.height/3, format.width/3,  format.height/2);
        _bg.frame = CGRectMake(0, 0, format.width,  format.height);
}

-(void) setBattle{
    
    _battleInfo.text = [NSString stringWithFormat:@"%@",[_modele toString]];
    _heroName.text = [NSString stringWithFormat:@"%@",[_modele myName]];
    //_heroView = _modele.myImgView;
   
    [self addSubview:_modele.myImgView];
    [self setPosition:[[UIScreen mainScreen]bounds].size];
    
    
    
}

@end

