//
//  Modele.m
//  Quizz_Objective-C
//
//  Created by m2sar on 31/01/2017.
//  Copyright © 2017 UPMC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Modele.h"

@implementation Modele

int level;
int expe;

-(id) init{
    self = [super init];
    if(self){
        level = 0;
        expe = 0;
        _hearthP = 1000;
        _myClass = @"Paysan";
        _myName = [[NSString alloc]init];
        _myName = @"TheHero";
    }
    return self;
}



-(NSString*) toString{
    NSMutableString *mystr = [NSMutableString stringWithFormat:@"Hello! : %@ my level : %d my class : %@", _myName, level,_myClass];
    
    return mystr;
}

-(void) levelUP{
    level = level + 1;
}

@end
