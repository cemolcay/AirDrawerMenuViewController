//
//  ViewController.swift
//  AirDrawerMenuViewController
//
//  Created by Cem Olcay on 12/03/15.
//  Copyright (c) 2015 Cem Olcay. All rights reserved.
//

import UIKit

class ViewController: AirDrawerMenuViewController, AirDrawerMenuViewControllerDataSource {

    
    // MARK: Properties
    
    var containerViewControllers: [UIViewController] = []
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...3 {
            containerViewControllers.append(vc ("\(i) vc"))
        }
        
        leftMenuViewController = UIStoryboard (name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LeftMenuViewController") as! LeftMenuViewController
        dataSource = self
    }
    
    override func viewDidAppear(animated: Bool) {
        reloadDrawer()
    }
    
    
    // MARK: Setup
    
    func vc (title: String) -> UINavigationController {
        let vc = UIViewController ()
        vc.navigationItem.title = title
        vc.view.backgroundColor = UIColor.randomColor()
        
        let but = UIBarButtonItem (title: "Drawer", style: .Plain, target: self, action: "openMenuPressed:")
        vc.navigationItem.leftBarButtonItem = but
        
        let nav = UINavigationController (rootViewController: vc)
        return nav
    }
    
    func openMenuPressed (sender: AnyObject) {
        openMenu()
    }
    

    // MARK: AirDrawerMenuViewControllerDataSource
    
    func AirDrawerMenuViewControllerNumberOfViewControllersInContentView () -> Int {
        return containerViewControllers.count
    }
    
    func AirDrawerMenuViewController (viewControllerAtIndex: Int) -> UIViewController {
        return containerViewControllers[viewControllerAtIndex]
    }
    
}

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

