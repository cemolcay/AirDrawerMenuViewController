//
//  AirDrawerMenuContentViewController.swift
//  AirDrawerMenuViewController
//
//  Created by Cem Olcay on 12/03/15.
//  Copyright (c) 2015 Cem Olcay. All rights reserved.
//

import UIKit

class AirDrawerMenuContentViewController: UIViewController {

    // MARK: Properties
    
    var currentViewController: UIViewController!
    
    var viewControllers: [UIViewController]! {
        didSet {
            self.moveFirstViewController()
        }
    }
    
    
    // MARK: Menu Navigation
    
    func moveFirstViewController () {
        currentViewController = viewControllers[0]
        
        currentViewController.willMoveToParentViewController(self)
        addChildViewController(currentViewController)
        currentViewController.view.frame = view.frame
        view.addSubview(currentViewController.view)
        currentViewController.didMoveToParentViewController(self)
    }
    
    func moveViewController (to: UIViewController, completion: (() -> Void)? = nil) {
        
        if to == currentViewController {
            return
        }
        
        addChildViewController(to)
        currentViewController!.willMoveToParentViewController(nil)
        
        to.view.frame = currentViewController.view.frame
        
        transitionFromViewController (currentViewController,
            toViewController: to,
            duration: 0,
            options: .TransitionNone,
            animations: { [unowned self] () -> Void in
                
            },
            completion: { [unowned self] finished -> Void in
                self.currentViewController.removeFromParentViewController()
                self.currentViewController = to
                to.didMoveToParentViewController(self)
                completion? ()
            })
    }
    
    
    // MARK: Animations

    func openAnimation (completion: (() -> Void)?) {
        
        UIView.animateWithDuration(
            AirDrawerMenuViewControllerAnimationDuration,
            delay: 0,
            options: ( .CurveEaseInOut | .AllowUserInteraction ),
            animations: {
                [unowned self] in
                
                self.currentViewController.view.center.x = self.view.frame.width
                let layer = self.currentViewController.view.layer
                
                let transform1 = CATransform3DMakeScale(0.6, 0.6, 1)
                var transform2 = CATransform3DIdentity
                transform2.m34 = -1.0 / 700.0
                transform2 = CATransform3DRotate(transform2, -1, 0, 1, 0)
                layer.transform = CATransform3DConcat(transform1, transform2)

            },
            completion: {
                finished in
                completion? ()
            })
    }
    
    func closeAnimation (completion: (() -> Void)?) {
        UIView.animateWithDuration(
            AirDrawerMenuViewControllerAnimationDuration,
            delay: 0,
            options: ( .CurveEaseInOut | .AllowUserInteraction ),
            animations: {
                [unowned self] in
                
                self.currentViewController.view.frame = self.view.frame
                let layer = currentViewController.view.layer
                
                var transform2 = CATransform3DIdentity
                transform2.m34 = -1.0 / 2000.0
                transform2 = CATransform3DRotate(transform2, 1, 0, 0, 0)
                layer.transform = transform2
            },
            completion: {
                finished in
                completion? ()
        })
    }
}
