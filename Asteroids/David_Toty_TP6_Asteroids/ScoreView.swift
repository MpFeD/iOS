//
//  ScoreView.swift
//  David_Toty_TP6_Asteroids
//
//  Created by m2sar on 05/11/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

import Foundation
import UIKit

class ScoreView : UIView, UITextFieldDelegate {
    
    let meilleurScore = UILabel()
    let votreScore = UILabel()
    let score = UILabel()
    let scoreTab = UILabel()
    var flou : UIVisualEffectView?
    let buttonDone = UIButton()
    let monTextField = UITextField()
    let entrezVotreNom = UILabel()
    
    var monPrenom : String
    
    var pseudoRecord : [String]
    var valeurRecord : [String]
    
    override init(frame:CGRect){
        
        meilleurScore.text=("Meilleurs scores")
        votreScore.text=("Votre score")
        entrezVotreNom.text=("Vous êtes dans le top 5 ! Entrez votre nom pour continuer")
        score.text=("0")
        
        pseudoRecord = ["???","???","???","???","???"]
        valeurRecord = ["0","0","0","0","0"]
        
        scoreTab.text=("\(pseudoRecord[0]) : \(valeurRecord[0])\n\(pseudoRecord[1]) : \(valeurRecord[1])\n\(pseudoRecord[2]) : \(valeurRecord[2])\n\(pseudoRecord[3]) : \(valeurRecord[3])\n\(pseudoRecord[4]) : \(valeurRecord[4])\n")
        
        monTextField.backgroundColor = UIColor(red: 0.98, green: 0.94, blue: 0.54, alpha: 0.5)
        monTextField.keyboardType = .default
        monTextField.borderStyle = .roundedRect
        monTextField.returnKeyType = .send
        monTextField.keyboardAppearance = .dark
        
        monPrenom = "???"
    
        
        meilleurScore.textAlignment = .center
        votreScore.textAlignment = .center
        score.textAlignment = .center
        scoreTab.textAlignment = .center
        entrezVotreNom.textAlignment = .center
        
        scoreTab.numberOfLines=6
        
        meilleurScore.textColor = UIColor.white
        votreScore.textColor = UIColor.white
        score.textColor = UIColor.white
        scoreTab.textColor = UIColor.white
        entrezVotreNom.textColor = UIColor.white
        
        buttonDone.setTitle("Done", for: .normal)
        buttonDone.addTarget( ViewController(), action: #selector(ViewController.actionDone), for: .touchDown)
        buttonDone.setTitleColor(UIColor.blue, for: .normal)
        
        super.init(frame: frame)
        monTextField.delegate = self
        
        var imgView = UIImageView()
        imgView = UIImageView(image: #imageLiteral(resourceName: "fond-asteroides"))
        self.addSubview(imgView)
        
        let flouSombre = UIBlurEffect(style: .dark)
        flou = UIVisualEffectView(effect: flouSombre)
        self.addSubview(flou!)
        
        monTextField.isHidden=true
        entrezVotreNom.isHidden=true
        
        self.addSubview(entrezVotreNom)
        self.addSubview(meilleurScore)
        self.addSubview(votreScore)
        self.addSubview(score)
        self.addSubview(scoreTab)
        self.addSubview(buttonDone)
        self.addSubview(monTextField)
        
        self.DessineDansFormat(format: frame.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if monTextField.text!.characters.count > 5 {
            resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        monTextField.text = ""
        
        meilleurScore.isHidden=true
        votreScore.isHidden=true
        score.isHidden=true
        scoreTab.isHidden=true
        
        
        monTextField.frame = CGRect(x:Int(frame.size.width/2)-Int(frame.size.width/6),y:0 , width:Int(frame.size.width/3), height:Int(frame.size.height/6));
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        monPrenom = textField.text!
        
        meilleurScore.isHidden=false
        votreScore.isHidden=false
        score.isHidden=false
        scoreTab.isHidden=false
        buttonDone.isHidden=false
        entrezVotreNom.isHidden=true
        
        monTextField.frame = CGRect(x:Int(frame.size.width/2)-Int(frame.size.width/6),y:Int(frame.size.height/2)+Int(frame.size.height/6) , width:Int(frame.size.width/3), height:Int(frame.size.height/6));
        
        
        
        ViewController().updateScore()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func majTab(){
        scoreTab.text=("\(pseudoRecord[0]) : \(valeurRecord[0])\n\(pseudoRecord[1]) : \(valeurRecord[1])\n\(pseudoRecord[2]) : \(valeurRecord[2])\n\(pseudoRecord[3]) : \(valeurRecord[3])\n\(pseudoRecord[4]) : \(valeurRecord[4])\n")
    }
    
    func DessineDansFormat(format:CGSize){
        
        
        votreScore.frame = CGRect(x:Int(format.width/2)-Int(format.width/6),y:Int(format.height/2)-Int(format.height/5), width:Int(format.width/3), height:Int(format.height/4));
        
        meilleurScore.frame = CGRect(x:Int(format.width/2)-Int(format.width/6),y:0, width:Int(format.width/3), height:Int(format.height/6));
        
        scoreTab.frame = CGRect(x:Int(format.width/2)-Int(format.width/6),y:Int(format.height/10), width:Int(format.width/3), height:Int(format.height/3));
        
        buttonDone.frame = CGRect(x:Int(format.width)-Int(format.width/6),y:0, width:Int(format.width/6), height:Int(format.height/6));
        
        flou?.frame = CGRect(x:0,y:0, width:Int(format.width), height:Int(format.height));
        
        score.frame = CGRect(x:Int(format.width/2)-Int(format.width/6),y:Int(format.height/2)-Int(format.height/6), width:Int(format.width/3), height:Int(format.height/3));
        
        entrezVotreNom.frame = CGRect(x:0,y:Int(format.height/2), width:Int(format.width), height:Int(format.height/6));
        
        monTextField.frame = CGRect(x:Int(format.width/2)-Int(format.width/6),y:Int(format.height/2)+Int(format.height/6) , width:Int(format.width/3), height:Int(format.height/6));
        
    }
    
}
