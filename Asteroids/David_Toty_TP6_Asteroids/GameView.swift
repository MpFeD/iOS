//
//  GameView.swift
//  David_Toty_TP6_Asteroids
//
//  Created by m2sar on 05/11/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

import Foundation
import UIKit
    
class GameView : UIView {
    
    let jouerBoutton = UIButton()
    let prefBoutton = UIButton()
    let scoresBoutton = UIButton()
    let buttonD = UIButton()
    let buttonG = UIButton()
    let score = UILabel()
    let niveau = UILabel()
    
    var imgView = UIImageView()
    var chasseur = UIImageView()
    var asteroides : [UIImageView]
    var angle : CGFloat
    var t : Timer?
    
    override init(frame:CGRect){
        angle = 0.0
        jouerBoutton.setTitle("Jouer", for: .normal)
        prefBoutton.setTitle("Préférences", for: .normal)
        scoresBoutton.setTitle("Scores", for: .normal)
        
        score.text=("Score : 0")
        buttonD.setTitle("->", for: .normal)
        buttonG.setTitle("<-", for: .normal)
        jouerBoutton.addTarget( ViewController(), action: #selector(ViewController.actionJouer), for: .touchDown)
        scoresBoutton.addTarget( ViewController(), action: #selector(ViewController.actionScore), for: .touchDown)
        prefBoutton.addTarget( ViewController(), action: #selector(ViewController.actionPreferences), for: .touchDown)
        buttonD.addTarget( ViewController(), action: #selector(ViewController.actionDirection), for: .touchDown)
        buttonG.addTarget( ViewController(), action: #selector(ViewController.actionDirection), for: .touchDown)
        
        buttonD.addTarget( ViewController(), action: #selector(ViewController.actionRelache), for: .touchUpInside)
        buttonG.addTarget( ViewController(), action: #selector(ViewController.actionRelache), for: .touchUpInside)
        
        score.textAlignment = .center
        niveau.textAlignment = .center
        
        niveau.textColor = UIColor.white
        score.textColor = UIColor.white
        
        asteroides = [UIImageView(image:#imageLiteral(resourceName: "asteroide-100-1")),
                      UIImageView(image:#imageLiteral(resourceName: "asteroide-100-2")),
                      UIImageView(image:#imageLiteral(resourceName: "asteroide-100-3")),
                      UIImageView(image:#imageLiteral(resourceName: "asteroide-100-4")),
                      UIImageView(image:#imageLiteral(resourceName: "asteroide-120-1")),
                      UIImageView(image:#imageLiteral(resourceName: "asteroide-120-2")),
                      UIImageView(image:#imageLiteral(resourceName: "asteroide-120-3")),
                      UIImageView(image:#imageLiteral(resourceName: "asteroide-120-4"))]
        
        
        jouerBoutton.titleLabel!.font = UIFont(name: "HelveticaNeue-Thin", size: UIScreen.main.bounds.size.width/9)
        
        super.init(frame: frame)
        
        imgView = UIImageView(image: #imageLiteral(resourceName: "fond-asteroides"))
        self.addSubview(imgView)
        
        chasseur = UIImageView(image: #imageLiteral(resourceName: "chasseur-TIE"))
        self.addSubview(chasseur)
        
        
            

        for i in 0...7 {
            self.addSubview(asteroides[i])
            asteroides[i].isHidden = true
        }
        
        
        self.addSubview(jouerBoutton)
        self.addSubview(prefBoutton)
        self.addSubview(scoresBoutton)
        self.addSubview(buttonD)
        self.addSubview(buttonG)
        self.addSubview(score)
        self.addSubview(niveau)
        
        buttonD.isHidden = true
        buttonG.isHidden = true
        chasseur.isHidden = true
        score.isHidden = true
        niveau.isHidden = true
        
        
        self.DessineDansFormat(format: frame.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        //
    }
    
   
    func DessineDansFormat(format:CGSize){
        jouerBoutton.frame = CGRect(x:Int(format.width/2)-Int(format.width/6),y:Int(format.height/2)-Int(format.height/6), width:Int(format.width/3), height:Int(format.height/4));
        prefBoutton.frame = CGRect(x:Int(format.width-format.width/5),y:0, width:Int(format.width/6), height:Int(format.height/6));
        scoresBoutton.frame = CGRect(x:0,y:0, width:Int(format.width/8), height:Int(format.height/6));
        
        chasseur.frame = CGRect(x:Int(format.width/2)-Int(format.height/16),y:Int(format.height-format.height/8), width:Int(format.height/8), height:Int(format.height/8));
        
        buttonG.frame = CGRect(x:0,y:Int(format.height-format.height/6), width:Int(format.width/8), height:Int(format.height/6));
        buttonD.frame = CGRect(x:Int(format.width-format.width/8),y:Int(format.height-format.height/6), width:Int(format.width/8), height:Int(format.height/6));
        
        
        niveau.frame = CGRect(x:Int(format.width-format.width/5),y:0, width:Int(format.width/6), height:Int(format.height/6));
        score.frame = CGRect(x:0,y:0, width:Int(format.width/6), height:Int(format.height/6));
        
    }
    
    
    
    
}
