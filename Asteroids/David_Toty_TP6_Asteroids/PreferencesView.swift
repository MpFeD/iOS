//
//  PreferencesView.swift
//  David_Toty_TP6_Asteroids
//
//  Created by m2sar on 05/11/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

import Foundation
import UIKit


class PreferencesView : UIView,UIPickerViewDataSource,UIPickerViewDelegate{
    
    let choix = UILabel()
    let monPicker = UIPickerView()
    let buttonDone = UIButton()
    var flou : UIVisualEffectView?
    var tab:[String]
    var difficulte : Int
    override init(frame:CGRect){
        tab = ["Niveau de difficulté 1","Niveau de difficulté 2","Niveau de difficulté 3","Niveau de difficulté 4","Niveau de difficulté 5"]
        difficulte = 1
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.red
        
        monPicker.dataSource=self
        monPicker.delegate=self
        
        choix.text=("Séléctionnez le niveau de difficulté")
        choix.textAlignment = .center
        
        buttonDone.setTitle("Done", for: .normal)
        buttonDone.addTarget( ViewController(), action: #selector(ViewController.actionDone2), for: .touchDown)
        buttonDone.setTitleColor(UIColor.blue, for: .normal)
        
        var imgView = UIImageView()
        imgView = UIImageView(image: #imageLiteral(resourceName: "fond-asteroides"))
        self.addSubview(imgView)
        
        let flouClair = UIBlurEffect(style: .extraLight)
        flou = UIVisualEffectView(effect: flouClair)
        self.addSubview(flou!)
        self.addSubview(monPicker)
        self.addSubview(buttonDone)
        self.addSubview(choix)
        self.DessineDansFormat(format: frame.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return tab.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tab[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        difficulte=row+1
    }
    
    
    func DessineDansFormat(format:CGSize){
        monPicker.frame = CGRect(x:0,y:0, width:Int(format.width), height:Int(format.height));
        choix.frame = CGRect(x:0,y:0, width:Int(format.width), height:Int(format.height / 12));
        buttonDone.frame = CGRect(x:Int(format.width)-Int(format.width/6),y:0, width:Int(format.width/6), height:Int(format.height/6));
        flou?.frame = CGRect(x:0,y:0, width:Int(format.width), height:Int(format.height));
    }
    
}
