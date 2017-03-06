//
//  MaVue.swift
//  David_Toty_TP7_iSouvenir
//
//  Created by m2sar on 24/11/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit
import Contacts
import ContactsUI

class MaVue : UIView, CLLocationManagerDelegate, MKMapViewDelegate, CNContactPickerDelegate, CNContactViewControllerDelegate {

    fileprivate let CLmngr = CLLocationManager()
    fileprivate let carte = MKMapView()
    fileprivate let cameraBasique = MKMapCamera()
    fileprivate let nbEpingle = UILabel()
    fileprivate let labelToolbar = UILabel()
    fileprivate let segControl = UISegmentedControl()
    fileprivate let buttonAdd = UIBarButtonItem(barButtonSystemItem: .add , target: self, action: #selector(ajouterEpingle(sender:)))
    fileprivate let buttonTrash = UIBarButtonItem(barButtonSystemItem: .trash , target: self, action: #selector(supprimerEpingle(sender:)))
    fileprivate let buttonRefresh = UIBarButtonItem(barButtonSystemItem: .refresh , target: self, action: #selector(calculePosition(sender:)))
    fileprivate let buttonBooks = UIBarButtonItem(barButtonSystemItem: .bookmarks , target: self, action: #selector(chercher))
    fileprivate let buttonCamera = UIBarButtonItem(barButtonSystemItem: .camera , target: self, action: #selector(test(sender:)))
    fileprivate let buttonOrganize = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(test(sender:)))
    fileprivate let smallSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action:nil)
    fileprivate let monToolBar = UIToolbar()
    fileprivate var cpt = 0
    fileprivate var couleur = UIColor.orange
    fileprivate var latitude = 0.0
    fileprivate var longitude = 0.0
    fileprivate var camera = MKMapCamera()
    
    fileprivate var contactcS = CNContactPickerViewController()
    fileprivate var contactsS = CNContactStore()
    fileprivate var contactVC : CNContactViewController?
    var myController : UIViewController?
    var nomContact = String()
    var prenomContact = String()
    
    var epingleSelectionnee : UneAnnotation?
    
    override init(frame:CGRect){
        
        carte.isScrollEnabled = true
        carte.isZoomEnabled = true
        CLmngr.distanceFilter = 1.0
        CLmngr.requestWhenInUseAuthorization()
        
        super.init(frame:frame)
        self.backgroundColor = UIColor.white
        nbEpingle.text=("Epingles : 0")
        
        segControl.insertSegment(withTitle: "3D", at: 0, animated: true)
        segControl.insertSegment(withTitle: "Carte", at: 1, animated: true)
        segControl.insertSegment(withTitle: "Satelite", at: 2, animated: true)
        segControl.insertSegment(withTitle: "Hybride", at: 3, animated: true)
        segControl.tintColor = UIColor.black
        segControl.selectedSegmentIndex=1
        segControl.addTarget(self, action: #selector(changeMap(sender:)), for: .valueChanged)
        
        carte.delegate = self
        CLmngr.delegate = self
        
        var items = [UIBarButtonItem]()
        items.append(buttonAdd)
        items.append(smallSpace)
        items.append(buttonTrash)
        items.append(smallSpace)
        items.append(buttonRefresh)
        items.append(smallSpace)
        items.append(buttonBooks)
        items.append(smallSpace)
        items.append(buttonCamera)
        items.append(smallSpace)
        items.append(buttonOrganize)
        
        monToolBar.setItems(items, animated: true)
        
        self.addSubview(carte)
        self.addSubview(monToolBar)
        self.addSubview(nbEpingle)
        self.addSubview(labelToolbar)
        self.addSubview(segControl)
        self.dessineDansFormat(size:UIScreen.main.bounds.size)
        self.afficheContact(contact: nil)
        contactcS.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        contactcS.delegate = self
    }
    
    func test(sender:UIBarButtonItem){
    }
    
    func chercher(){
        
       contactsS.requestAccess(for: .contacts){ (b:Bool, e: Error?) in
            if !b {
                let alert = UIAlertController(title: "Erreur", message: e?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.myController?.present(alert, animated: true, completion: nil)
            }else{
                
                self.myController?.present(self.contactcS, animated: true, completion: nil)
                
                
            }
        }
    }
    
    func afficheContact(contact : CNContact?){
        if contact != nil{
            
            if (contact!.isKeyAvailable(CNContactFamilyNameKey)){
                nomContact = contact!.familyName
            }
            
            if (contact!.isKeyAvailable(CNContactGivenNameKey)){
                nomContact = contact!.givenName
            }
            
            if (epingleSelectionnee != nil){
                epingleSelectionnee?.setSubTitle(s: "\(contact!.givenName) \(contact!.familyName)")
                self.setNeedsDisplay()
            }
        }else{
            nomContact=""
            prenomContact=""
        }
    }
    
    func changeMap(sender:UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            carte.mapType = .standard
            let pointDeVue = CLLocationCoordinate2DMake(latitude-50/1000,longitude-50/1000)
            camera = MKMapCamera(lookingAtCenter: carte.centerCoordinate, fromEyeCoordinate: pointDeVue, eyeAltitude: 50)
            camera.heading = 120
            carte.setCamera(camera, animated: true)
            carte.mapType = .satellite
        }
        if sender.selectedSegmentIndex == 1 {
            let pointDeVue = CLLocationCoordinate2DMake(latitude,longitude)
            camera = MKMapCamera(lookingAtCenter: carte.centerCoordinate, fromEyeCoordinate: pointDeVue, eyeAltitude: 50)
            camera.heading = 0
            carte.setCamera(camera, animated: false)
            carte.mapType = .standard
        }
        if sender.selectedSegmentIndex == 2 {
            carte.mapType = .satellite
        }
        if sender.selectedSegmentIndex == 3 {
            carte.mapType = .hybrid
        }
    }
    
    required init?(coder aDecoder:NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    func dessineDansFormat(size : CGSize){
        monToolBar.frame = CGRect(x:0, y:size.height-size.height/12, width:size.width, height:size.height/12)
        nbEpingle.frame = CGRect(x:size.width-size.width/4, y:size.height-size.height/10, width:size.width/4, height:size.height/20)
        labelToolbar.frame = CGRect(x:size.width-3*size.width/4, y:size.height-size.height/10, width:size.width/2, height:size.height/20)
        segControl.frame = CGRect(x:size.width/8, y:size.height/15, width:size.width-size.width/4, height:size.height/15)
        carte.frame = CGRect(x:0,y:0,width:size.width,height:size.height)
    }
    
    func calculePosition(sender: UIButton){
        CLmngr.startUpdatingLocation()
    }
    
    func ajouterEpingle(sender:UIButton){
        let a = UneAnnotation(c: carte.centerCoordinate, t:String(format:"Contact %d",cpt),st:"Pas de contact")
        cpt+=1
        carte.addAnnotation(a)
        nbEpingle.text=String(format:"Epingles : %d",cpt)
    }
    
    func supprimerEpingle(sender:UIButton){
        
        if(epingleSelectionnee != nil) {
            cpt-=1
            carte.removeAnnotation(epingleSelectionnee!)
            epingleSelectionnee = nil
            nbEpingle.text=String(format:"Epingles : %d",cpt)
        }
        
    }
    
    func couleurSuivante(c:UIColor)->UIColor{
        if c == UIColor.orange {
            return UIColor.red
        }else if c == UIColor.red {
            return UIColor.blue
        }else { return UIColor.orange }
    }
    
    
    //protocole CCLocationManagerDElegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        latitude = (manager.location?.coordinate.latitude)!
        longitude = (manager.location?.coordinate.longitude)!
        NSLog(String(format:"Lattitude : %2.3f", (manager.location?.coordinate.latitude)!))
        NSLog(String(format:"Longitude : %2.3f", (manager.location?.coordinate.longitude)!))
        CLmngr.stopUpdatingLocation()
        let span = MKCoordinateSpanMake(0.035, 0.035)
        let region = MKCoordinateRegionMake((manager.location?.coordinate)!, span)
        carte.setRegion(region, animated: true)
        carte.showsUserLocation = true
        if segControl.selectedSegmentIndex == 0 {
            carte.mapType = .standard
            let pointDeVue = CLLocationCoordinate2DMake(latitude-50/1000,longitude-50/1000)
            camera = MKMapCamera(lookingAtCenter: carte.centerCoordinate, fromEyeCoordinate: pointDeVue, eyeAltitude: 50)
            camera.heading = 120
            carte.setCamera(camera, animated: true)
            carte.mapType = .satellite
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NSLog(String(format:"Erreur"))
    }
    
    
    //protocole MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let epingle = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "ppm")
        epingle.pinTintColor = couleur
        couleur = couleurSuivante(c:couleur)
        epingle.canShowCallout = true
        epingle.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return epingle
    }
    
    //petit i a droite
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
    }
    
    //appuie sur épingle
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        labelToolbar.text = String(format:"Epinglé sur %.2f, %.2f", (view.annotation?.coordinate.latitude)!,(view.annotation?.coordinate.longitude)!)
        
        epingleSelectionnee = view.annotation as! UneAnnotation?
        
        self.setNeedsDisplay()
    }
    
    
    //CNContactPickerDelegate
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        
        self.afficheContact(contact: contact)
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        self.afficheContact(contact: nil)
    }
    
    //CNContactViewControllerDelegate
    func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) {
        contactVC?.dismiss(animated: true, completion: nil)
        contactVC=nil
        self.afficheContact(contact: contact)
    }
    
    
}
