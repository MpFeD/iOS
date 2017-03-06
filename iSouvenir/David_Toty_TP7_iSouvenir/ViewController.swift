//
//  ViewController.swift
//  David_Toty_TP7_iSouvenir
//
//  Created by m2sar on 24/11/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

import UIKit
import CoreLocation

let v = MaVue(frame: UIScreen.main.bounds)

class ViewController: UIViewController {

    	
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if CLLocationManager.locationServicesEnabled() {
            v.myController = self
            self.view = v
        } else  {
            self.view = UIView()
            let alert = UIAlertController(title: "Erreur", message: "Localisation désactivée", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

