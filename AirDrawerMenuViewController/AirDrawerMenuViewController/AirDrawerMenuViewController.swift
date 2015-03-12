//
//  AirDrawerMenuViewController.swift
//  AirDrawerMenuViewController
//
//  Created by Cem Olcay on 12/03/15.
//  Copyright (c) 2015 Cem Olcay. All rights reserved.
//

import UIKit

let AirDrawerMenuViewControllerAnimationDuration: NSTimeInterval = 0.3

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
    var leftMenuViewController: AirDrawerMenuLeftViewController!
    
    var dataSource: AirDrawerMenuViewControllerDataSource?
    var drawerDelegate: AirDrawerMenuViewControllerDelegate?

    
    // MARK: Init
    
    override init () {
        super.init()
        contentViewController = AirDrawerMenuContentViewController()
    }
    
    required init (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentViewController = AirDrawerMenuContentViewController()
    }
    
    override init (nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        contentViewController = AirDrawerMenuContentViewController()
    }
    
    
    // MARK: Lifecycle
    
    override func viewWillAppear(animated: Bool) {
        
        if leftMenuViewController.parentViewController != self {
            leftMenuViewController.willMoveToParentViewController(self)
            addChildViewController(leftMenuViewController)
            leftMenuViewController.view.frame = view.frame
            view.addSubview(leftMenuViewController.view)
            leftMenuViewController.didMoveToParentViewController(self)
        }
        
        if contentViewController.parentViewController != self {
            contentViewController = AirDrawerMenuContentViewController ()
            contentViewController.willMoveToParentViewController(self)
            addChildViewController(contentViewController)
            contentViewController.view.frame = view.frame
            view.addSubview(contentViewController.view)
            contentViewController.didMoveToParentViewController(self)
        }
    }
    
    
    // MARK: Menu
    
    func openMenu () {
    
        drawerDelegate?.AirDrawerMenuViewControllerWillOpenMenu!()
        
        contentViewController.view.userInteractionEnabled = false
        leftMenuViewController.openLeftMenuAnimation(nil)
        contentViewController.openAnimation {
            self.drawerDelegate?.AirDrawerMenuViewControllerDidOpenMenu!()
        }
        
    }
    
    func closeMenu () {
        
        drawerDelegate?.AirDrawerMenuViewControllerWillCloseMenu!()
        
        contentViewController.view.userInteractionEnabled = true
        
        leftMenuViewController.closeLeftMenuAnimation(nil)
        contentViewController.closeAnimation {
            self.drawerDelegate?.AirDrawerMenuViewControllerDidCloseMenu!()
        }
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

    func moveViewControllerAtIndex (index: Int) {
        if let vc = contentViewController.viewControllers?[index] {
            moveViewController(vc)
        }
    }
    
    func moveViewController (viewController: UIViewController) {
        if contains(contentViewController.viewControllers, viewController) {
            contentViewController.moveViewController(viewController)
        }
    }
    
}

