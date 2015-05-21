//
//  LeftMenuViewController.swift
//  AirDrawerMenuViewController
//
//  Created by Cem Olcay on 21/05/15.
//  Copyright (c) 2015 Cem Olcay. All rights reserved.
//

import UIKit

class LeftMenuViewController: AirDrawerMenuLeftViewController {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.yellowColor()
    }
    
    @IBAction func buttonPressed (sender: UIButton) {
        
        airDrawerMenu?.closeMenu(completion: {
            let newvc = UIViewController ()
            newvc.title = "new"
            newvc.view.backgroundColor = UIColor.randomColor()
            
            self.airDrawerMenu?.moveViewControllerAtIndex(sender.tag)
        })
    }
    
    
    // MARK: AirDrawerMenuLeftViewControllerDelegate
    
    override func reloadLeftMenu() {
        
    }
    
    override func openLeftMenuAnimation(completion: (() -> Void)?) {
        
        view.alpha = 0
        view.setScale(1.2, y: 1.2)
        
        view.animate (
            AirDrawerMenuViewControllerAnimationDuration,
            animations: { [unowned self] in
                self.view.alpha = 1
                self.view.setScale(1, y: 1)
            })
    }
    
    override func closeLeftMenuAnimation(completion: (() -> Void)?) {
        
        view.alpha = 1
        view.setScale(1, y: 1)
        
        view.animate (
            AirDrawerMenuViewControllerAnimationDuration,
            animations: { [unowned self] in
                self.view.alpha = 0
                self.view.setScale(1.2, y: 1.2)
            })
    }
}
