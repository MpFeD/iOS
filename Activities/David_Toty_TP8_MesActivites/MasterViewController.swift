//
//  MasterViewController.swift
//  David_Toty_TP8_MesActivites
//
//  Created by Knu on 30/11/16.
//  Copyright © 2016 Knu. All rights reserved.
//

import Foundation
import UIKit

class MasterViewController: UITableViewController, UISplitViewControllerDelegate {
    
    var svc : UISplitViewController?
    var termType = terminalType.undefined
    var monDetail : DetailViewController?
    fileprivate var contenu = [[UneCellule]]()
    fileprivate var section=0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewStyle){
        super.init(style: style)
        self.tableView.sectionFooterHeight = 0.0
        self.tableView.separatorColor = UIColor.clear
        self.tableView.backgroundView = UIImageView(image:UIImage(named: "fond-alu"))
        
        var dansSection = [UneCellule]()
        dansSection += [UneCellule(p:4, b:"S'occuper des vacances")]
        contenu+=[dansSection]
        
        dansSection = [UneCellule(p:2, b:"Faire les courses")]
        contenu+=[dansSection]
        
        dansSection = [UneCellule(p:3, b:"Me faire un cadeau")]
        contenu+=[dansSection]
        
        dansSection = [UneCellule(p:0, b:"Boire mon café")]
        dansSection += [UneCellule(p:1, b:"Faire ma sieste")]
        contenu+=[dansSection]
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ajoutCellule))
        
        self.dessineDansFormat(size: UIScreen.main.bounds.size)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Liste des tâches"
    }
    
    func ajoutCellule(){
        self.contenu[1].insert(UneCellule(p:0,b:"Nouvelle tâche"), at: 0)
        self.tableView.reloadData()
    }
    
    func dessineDansFormat(size:CGSize){
        self.view.frame = CGRect(x: 0, y: 70, width: size.width, height: size.height)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.dessineDansFormat(size: size)
    }
    
    func splitViewController(_ svc: UISplitViewController, willChangeTo displayMode: UISplitViewControllerDisplayMode) {
        let access = monDetail?.navigationController?.topViewController?.navigationItem
        
        if displayMode == .primaryHidden {
            access?.setLeftBarButton(svc.displayModeButtonItem, animated: true)
        } else {
            access?.setLeftBarButton(nil, animated: true)
        }
    }
    
    func targetDisplayModeForAction(in svc: UISplitViewController) -> UISplitViewControllerDisplayMode {
        switch termType {
        case .iphone35, .iphone40, .iphone47:
            return .automatic
        default:
            return .allVisible
        }
    }
    
    //protocole tableView Delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return contenu.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contenu[section].count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 61.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hv = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height/15, width: UIScreen.main.bounds.width, height: 100))
        hv.addSubview(UIImageView(image:UIImage(named: "bg-header")))
        let l = UILabel(frame: CGRect(x: UIScreen.main.bounds.width/8, y:UIScreen.main.bounds.height/50, width: UIScreen.main.bounds.width-UIScreen.main.bounds.width/8, height: UIScreen.main.bounds.height/50))
        l.textColor = UIColor.white
        l.font = UIFont.boldSystemFont(ofSize: UIScreen.main.bounds.height/50)
        
        if section == 0 {
            l.text = "Vacances"
            self.section+=1
        }
        if section == 1 {
            l.text = "Personel"
            self.section+=1
        }
        if section == 2 {
            l.text = "Urgent"
            self.section+=1
        }
        if section == 3 {
            l.text = "Aujourd'hui"
        }
        
        hv.addSubview(l)
        self.dessineDansFormat(size: UIScreen.main.bounds.size)
        return hv
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "")
        if cell === nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "")
        }
        let cont = contenu[indexPath.section][indexPath.row]
        cell!.textLabel?.text = cont.but
        cell!.detailTextLabel?.text = "Priorité actuelle : \(cont.priorite)"
        cell!.backgroundView = UIImageView(image:(UIImage(named:"bg-tableview-cell")))
        var img : UIImage?
        if cont.priorite == 0 {
            img = UIImage(named: "prio-0")
        }
        if cont.priorite == 1 {
            img = UIImage(named: "prio-1")
        }
        if cont.priorite == 2 {
            img = UIImage(named: "prio-2")
        }
        if cont.priorite == 3 {
            img = UIImage(named: "prio-3")
        }
        if cont.priorite == 4 {
            img = UIImage(named: "prio-4")
        }
        
        cell!.imageView?.image = img!
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.contenu[indexPath.section].remove(at: indexPath.row)
        } else if editingStyle == .insert {
            //
        }
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        monDetail?.seg.selectedSegmentIndex=contenu[indexPath.section][indexPath.row].priorite
        monDetail?.texttv.text = "\(contenu[indexPath.section][indexPath.row].but)"
        monDetail?.maCelulle = contenu[indexPath.section][indexPath.row]
        monDetail?.monMaitre = self
        
        switch termType {
        case .iphone35, .iphone40, .iphone47:
            svc?.showDetailViewController(monDetail!.navigationController!, sender: self)
        default:
            ()
        }
    }
}
