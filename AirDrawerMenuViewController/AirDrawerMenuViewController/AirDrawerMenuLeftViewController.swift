//
//  AirDrawerMenuLeftViewController.swift
//  AirDrawerrMenuViewController
//
//  Created by Cem Olcay on 12/03/15.
//  Copyright (c) 2015 Cem Olcay. All rights reserved.
//

import UIKit

protocol AirDrawerMenuLeftViewControllerDelegate {
    
    func reloadLeftMenu ()
    func openLeftMenuAnimation (completion: (() -> Void)?)
    func closeLeftMenuAnimation (completion: (() -> Void)?)
    
}

class AirDrawerMenuLeftViewController: UIViewController, AirDrawerMenuLeftViewControllerDelegate {

    
    // MARK: AirDrawerMenuLeftViewControllerDelegate
    // Override these methods in your subclass

    func reloadLeftMenu() {
        
    }
    
    func openLeftMenuAnimation(completion: (() -> Void)?) {
        
    }
    
    func closeLeftMenuAnimation(completion: (() -> Void)?) {
        
    }
}
