//
//  ViewController.swift
//  David_Toty_TP6_Asteroids
//
//  Created by m2sar on 05/11/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

import UIKit


let gameView = GameView(frame:UIScreen.main.bounds)
let preferencesView = PreferencesView(frame:UIScreen.main.bounds)
let scoresView = ScoreView(frame:UIScreen.main.bounds)
var modele = Modele()

class ViewController: UIViewController {
    
    
    let grandTerminal = UIDevice.current.userInterfaceIdiom == .pad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = gameView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        //Inutile car affichage forcé en portrait
    }
    
    func actionJouer(sender:UIButton){
        
        gameView.DessineDansFormat(format: UIScreen.main.bounds.size)
        
        gameView.jouerBoutton.isHidden=true
        gameView.scoresBoutton.isHidden=true
        gameView.prefBoutton.isHidden=true
        gameView.niveau.isHidden=false
        gameView.score.isHidden=false
        gameView.niveau.text=("Niveau : \(modele.difficulte)")
        gameView.buttonD.isHidden=false
        gameView.buttonG.isHidden=false
        gameView.chasseur.isHidden=false
        scoresView.monTextField.isHidden=true
        
        for i in 0...7{
            gameView.asteroides[i].isHidden=false
            gameView.asteroides[i].center = CGPoint(x:0, y:-50)
        }
        
        gameView.t?.invalidate()
        gameView.t=nil
        
        gameView.t = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(apparitionAsteroide), userInfo: nil, repeats: true)
    }
    
    func actionScore(sender:UIButton){
        self.view=scoresView
        scoresView.monTextField.isHidden=true
        scoresView.votreScore.isHidden=true
        scoresView.score.isHidden=true
    }
    
    func actionPreferences(sender:UIButton){
        self.view=preferencesView
    }

    func actionDone(sender:UIButton){
        self.view=gameView
        modele.difficulte=preferencesView.difficulte
        scoresView.buttonDone.isHidden = false
        scoresView.entrezVotreNom.isHidden = true
        scoresView.monTextField.isHidden = true
    }
    
    
    func updateScore(){
        NSLog(modele.score.description)
        NSLog("\(modele.currentScore)")
        var i = 0
        var j = 4
        while(i<5){
            //Si dans top 5, on insère le score et on décale les autres
            if(modele.currentScore > modele.score[i]){
                while(j != i){
                    modele.score[j] = modele.score[j-1]
                    modele.listePseudo[j] = modele.listePseudo[j-1]
                    scoresView.pseudoRecord[j] = scoresView.pseudoRecord[j-1]
                    scoresView.valeurRecord[j] = scoresView.valeurRecord[j-1]
                    j-=1
                }
                modele.score[i] = modele.currentScore
                modele.listePseudo[i]=scoresView.monPrenom
                scoresView.pseudoRecord[i]=modele.listePseudo[i]
                scoresView.valeurRecord[i]="\(modele.score[i])"
                
                break
            }
            i+=1
        }
        
        NSLog(modele.score.description)
        
        
        scoresView.majTab()
        scoresView.monTextField.isHidden = true
        modele.currentScore = 0
    }
    
    func actionDone2(sender:UIButton){
        self.view=gameView
        modele.difficulte=preferencesView.difficulte
    }
    
    func actionDirection(sender:UIButton){
        
        if(sender == gameView.buttonG){
            modele.mouvementGauche=true
        }else{
            modele.mouvementDroit=true
        }
    }
    
    func actionRelache(sender : UIButton){
        if (sender == gameView.buttonG){
            modele.mouvementGauche=false
        }else{
            modele.mouvementDroit=false
        }
    }
    
    func sortFunc(n: Int, m: Int) -> Bool {
        return n < m
    }
    
    func apparitionAsteroide(t:Timer){
        gameView.angle = gameView.angle + 0.0628
        if(gameView.angle > 6.28){
            gameView.angle = 0.0
        }
        if(modele.mouvementDroit){
            gameView.chasseur.center = CGPoint(x: gameView.chasseur.center.x+1, y: gameView.chasseur.center.y)
        }
        if(modele.mouvementGauche){
            gameView.chasseur.center = CGPoint(x: gameView.chasseur.center.x-1, y: gameView.chasseur.center.y)
        }
        
        if(arc4random()%50 == 1){
            let a = Int(arc4random()%8)
            if (modele.asteroideBouge[a]==false){
                gameView.asteroides[a].center = CGPoint(x:Int(arc4random())%Int(UIScreen.main.bounds.maxX), y:-20 )
                modele.asteroideBouge[a]=true
                modele.asteroidePattern[a] = -1 + Int(arc4random()%3)
            }
        }
        
        for i in 0...7 {
            if(modele.asteroideBouge[i]){
                let posX = Int(gameView.asteroides[i].center.x) + (modele.asteroidePattern[i])
                let posY = Int(gameView.asteroides[i].center.y) + Int(modele.difficulte+1)
                gameView.asteroides[i].center=CGPoint(x: posX, y: posY)
                gameView.asteroides[i].transform = CGAffineTransform(rotationAngle: gameView.angle)
            }
        }
        //Game Over
        for i in 0...7 {
        if(gameView.asteroides[i].center.y >= (gameView.chasseur.center.y-UIScreen.main.bounds.maxY/16) && ((gameView.asteroides[i].center.x) > (gameView.chasseur.center.x-UIScreen.main.bounds.maxY/16) && ((gameView.asteroides[i].center.x) < (gameView.chasseur.center.x+UIScreen.main.bounds.maxY/16)))){
            
                for i in 0...7{
                    gameView.asteroides[i].isHidden=true
                    gameView.asteroides[i].center = CGPoint(x:0, y:-50)
                    modele.asteroideBouge[i]=false
                }
            
                self.view=scoresView
            
                gameView.buttonD.isHidden = true
                gameView.buttonG.isHidden = true
                gameView.chasseur.isHidden = true
                gameView.score.isHidden = true
                gameView.niveau.isHidden = true
            
                gameView.jouerBoutton.isHidden=false
                gameView.scoresBoutton.isHidden=false
                gameView.prefBoutton.isHidden=false
            
                gameView.t?.invalidate()
                gameView.t=nil
                gameView.score.text=("Score : 0")
            
            
                scoresView.votreScore.isHidden = false
                scoresView.score.isHidden = false
                scoresView.score.text=("\(modele.currentScore)")
            
            
                modele.mouvementDroit=false
                modele.mouvementGauche=false
            
            
                //Si vous êtes dans le top 5, vous devez entrez votre nom
                var i = 0
                while(i<5){
                    if(modele.currentScore > modele.score[i]){
                        scoresView.buttonDone.isHidden = true
                        scoresView.monTextField.isHidden = false
                        scoresView.entrezVotreNom.isHidden = false
                        break
                    }
                    i+=1
                }
            }
        }
        
        for i in 0...7 {
            if(gameView.asteroides[i].center.y>UIScreen.main.bounds.maxY) {
                gameView.asteroides[i].center = CGPoint(x:UIScreen.main.bounds.maxX/2, y:-20 )
                modele.currentScore+=1
                gameView.score.text=("Score : \(modele.currentScore)")
                modele.asteroideBouge[i]=false
            }
        }
        
        
        
        
    }

}

