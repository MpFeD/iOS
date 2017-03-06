//
//  DetailViewController.swift
//  David_Toty_TP8_MesActivites
//
//  Created by Knu on 30/11/16.
//  Copyright © 2016 Knu. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    var lTitle = UILabel()
    let lPriority = UILabel()
    var seg = UISegmentedControl()
    var termType = terminalType.undefined
    var maCelulle = UneCellule(p:0,b:"")
    var monMaitre : MasterViewController?
    let texttv = UITextField()
    
    override func viewDidLoad() {
        self.view = UIView(frame: UIScreen.main.bounds)
        self.view.addSubview(UIImageView(image:UIImage(named: "fond-alu")))
        lTitle.text = "Title :"
        lTitle.textColor = UIColor.black
        lPriority.text = "Priority :"
        lPriority.textColor = UIColor.black
        
        seg.insertSegment(withTitle: "0", at: 0, animated: true)
        seg.insertSegment(withTitle: "1", at: 1, animated: true)
        seg.insertSegment(withTitle: "2", at: 2, animated: true)
        seg.insertSegment(withTitle: "3", at: 3, animated: true)
        seg.insertSegment(withTitle: "4", at: 4, animated: true)
        seg.addTarget(self, action: #selector(segValChange), for: .valueChanged)
        seg.tintColor = UIColor.white
        
        texttv.background = UIImage(named:"bg-tableview-cell")
        texttv.keyboardType = .asciiCapable
        texttv.returnKeyType = .send
        texttv.keyboardAppearance = .dark
        texttv.delegate = self
        texttv.text = "Entrer un nouveau titre ici"
        
        self.view.addSubview(texttv)
        self.view.addSubview(lPriority)
        self.view.addSubview(seg)
        self.view.addSubview(lTitle)
        self.dessineDansFormat(size: UIScreen.main.bounds.size)
    }
    
    func segValChange(){
        maCelulle.priorite = seg.selectedSegmentIndex
        monMaitre?.tableView.reloadData()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.dessineDansFormat(size: size)
    }
    
    func dessineDansFormat(size:CGSize){
        switch termType{
        case .iphone35, .iphone40, .iphone47:
            lTitle.frame = CGRect(x: UIScreen.main.bounds.size.width/50, y: UIScreen.main.bounds.size.height/8, width: UIScreen.main.bounds.size.width - UIScreen.main.bounds.size.width/50, height: 40)
            texttv.frame = CGRect(x: UIScreen.main.bounds.size.width/6 , y: UIScreen.main.bounds.size.height/8, width: UIScreen.main.bounds.size.width/2, height: UIScreen.main.bounds.size.height/16)
            lPriority.frame = CGRect(x: UIScreen.main.bounds.size.width/50, y: 3*UIScreen.main.bounds.size.height/16, width: UIScreen.main.bounds.size.width - UIScreen.main.bounds.size.width/50, height: 40)
            seg.frame = CGRect(x: UIScreen.main.bounds.size.width/50, y: UIScreen.main.bounds.size.height/4, width: UIScreen.main.bounds.size.width - UIScreen.main.bounds.size.width/50, height: 40)
        default:
            lTitle.frame = CGRect(x: UIScreen.main.bounds.size.width/50, y: UIScreen.main.bounds.size.height/8, width: UIScreen.main.bounds.size.width/2, height: UIScreen.main.bounds.size.height/16	)
            texttv.frame = CGRect(x: UIScreen.main.bounds.size.width/6 , y: UIScreen.main.bounds.size.height/8, width: UIScreen.main.bounds.size.width/2, height: UIScreen.main.bounds.size.height/16)
            lPriority.frame = CGRect(x: UIScreen.main.bounds.size.width/50, y: 3*UIScreen.main.bounds.size.height/16, width: UIScreen.main.bounds.size.width - UIScreen.main.bounds.size.width/2, height: 40)
            seg.frame = CGRect(x: UIScreen.main.bounds.size.width/50, y: UIScreen.main.bounds.size.height/4, width: UIScreen.main.bounds.size.width - UIScreen.main.bounds.size.width/2, height: 40)
        }
        self.view?.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        texttv.text = ""
        maCelulle.but = ""
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        maCelulle.but += string
        monMaitre?.tableView.reloadData()
        return true
    }
}
