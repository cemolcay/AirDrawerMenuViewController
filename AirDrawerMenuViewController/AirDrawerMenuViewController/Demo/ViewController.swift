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

    func airDrawerMenuViewControllerNumberOfViewControllersInContentView(airDrawerMenuViewController: AirDrawerMenuViewController) -> Int {
        return containerViewControllers.count
    }
    
    func airDrawerMenuViewControllerViewControllerAtIndex(airDrawerMenuViewController: AirDrawerMenuViewController, index: Int) -> UIViewController {
        return containerViewControllers[index]
    }
}

