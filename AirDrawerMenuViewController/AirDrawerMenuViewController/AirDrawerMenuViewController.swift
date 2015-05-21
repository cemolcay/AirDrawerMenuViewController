//
//  AirDrawerMenuViewController.swift
//  AirDrawerMenuViewController
//
//  Created by Cem Olcay on 12/03/15.
//  Copyright (c) 2015 Cem Olcay. All rights reserved.
//

import UIKit

let AirDrawerMenuViewControllerAnimationDuration: NSTimeInterval = 0.5

extension UIViewController {

    var airDrawerMenu: AirDrawerMenuViewController? {
        get {
            if let parent = parentViewController {
                if parent is AirDrawerMenuViewController {
                    return parent as? AirDrawerMenuViewController
                } else if parent.parentViewController is AirDrawerMenuViewController {
                    return parent.parentViewController as? AirDrawerMenuViewController
                } else if parent.parentViewController?.parentViewController is AirDrawerMenuViewController {
                    return parentViewController?.parentViewController?.parentViewController as? AirDrawerMenuViewController
                } else {
                    return nil
                }
            } else {
                return nil
            }
        }
    }
}

protocol AirDrawerMenuViewControllerDataSource {
    
    func AirDrawerMenuViewControllerNumberOfViewControllersInContentView () -> Int
    func AirDrawerMenuViewController (viewControllerAtIndex: Int) -> UIViewController

}

@objc protocol AirDrawerMenuViewControllerDelegate {

    optional func AirDrawerMenuViewControllerWillOpenMenu ()
    optional func AirDrawerMenuViewControllerDidOpenMenu ()
    
    optional func AirDrawerMenuViewControllerWillCloseMenu ()
    optional func AirDrawerMenuViewControllerDidCloseMenu ()
    
}

class AirDrawerMenuViewController: UIViewController {

    
    // MARK: Properties
    
    var contentViewController: AirDrawerMenuContentViewController!
    var leftMenuViewController: AirDrawerMenuLeftViewController! {
        didSet {
            leftMenuViewController.willMoveToParentViewController(self)
            addChildViewController(leftMenuViewController)
            leftMenuViewController.view.frame = view.frame
            view.addSubview(leftMenuViewController.view)
            leftMenuViewController.didMoveToParentViewController(self)
            view.sendSubviewToBack(leftMenuViewController.view)
        }
    }
    
    var dataSource: AirDrawerMenuViewControllerDataSource?
    var drawerDelegate: AirDrawerMenuViewControllerDelegate?

    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentViewController = AirDrawerMenuContentViewController ()
        contentViewController.willMoveToParentViewController(self)
        addChildViewController(contentViewController)
        contentViewController.view.frame = view.frame
        view.addSubview(contentViewController.view)
        contentViewController.didMoveToParentViewController(self)
    }
    
    
    // MARK: Drawer
    
    func reloadDrawer () {
        if let ds = dataSource {
            
            leftMenuViewController.reloadLeftMenu()
            
            let count = ds.AirDrawerMenuViewControllerNumberOfViewControllersInContentView()
            var viewControllers: [UIViewController] = []
            for i in 0..<count {
                viewControllers.append(ds.AirDrawerMenuViewController(i))
            }
            
            contentViewController.viewControllers = viewControllers
        }
    }

    
    // MARK: Interaction
    
    func openMenu (completion: (() -> Void)? = nil) {
    
        drawerDelegate?.AirDrawerMenuViewControllerWillOpenMenu? ()
        
        contentViewController.view.userInteractionEnabled = false
        leftMenuViewController.openLeftMenuAnimation(nil)
        contentViewController.openAnimation {
            self.drawerDelegate?.AirDrawerMenuViewControllerDidOpenMenu? ()
            completion? ()
        }
        
    }
    
    func closeMenu (completion: (() -> Void)? = nil) {
        
        drawerDelegate?.AirDrawerMenuViewControllerWillCloseMenu? ()
        
        contentViewController.view.userInteractionEnabled = true
        
        leftMenuViewController.closeLeftMenuAnimation(nil)
        contentViewController.closeAnimation {
            self.drawerDelegate?.AirDrawerMenuViewControllerDidCloseMenu? ()
            completion? ()
        }
    }
    
    
    func moveViewControllerAtIndex (index: Int, completion: (() -> Void)? = nil) {
        if let vc = contentViewController.viewControllers?[index] {
            moveViewController(vc, completion: completion)
        }
    }
    
    func moveViewController (viewController: UIViewController, completion: (() -> Void)? = nil) {
        if contains(contentViewController.viewControllers, viewController) {
            contentViewController.moveViewController(viewController, completion: completion)
        }
    }
    
}
