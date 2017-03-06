//
//  Modele.swift
//  David_Toty_TP6_Asteroids
//
//  Created by Knu on 07/11/16.
//  Copyright © 2016 UPMC. All rights reserved.
//

import Foundation


class Modele {
    var score:[Int]
    var difficulte:Int
    var mouvementDroit:Bool
    var mouvementGauche:Bool
    var currentScore:Int
    var asteroidePattern:[Int]
    var asteroideBouge:[Bool]
    var listePseudo : [String]
    
    
    init(){
        score=[0,0,0,0,0]
        listePseudo=["???","???","???","???","???"]
        difficulte=1
        mouvementDroit=false
        mouvementGauche=false
        currentScore=0
        asteroideBouge=[false,false,false,false,false,false,false,false] //8 asteroides possible à l'écran, true = en mouvement
        asteroidePattern = [0,0,0,0,0,0,0,0]
        
    }
    
    
}
