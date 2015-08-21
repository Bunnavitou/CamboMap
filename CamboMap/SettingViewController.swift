//
//  SettingViewController.swift
//  CamboMap
//
//  Created by Yoman on 7/30/15.
//  Copyright (c) 2015 AlwayAtHome. All rights reserved.
//

import UIKit

class SettingViewController: YomanViewController {
    
    
    
    // MARK: - View LifeCyle -
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title="Setting"
        self.navigationController?.navigationBarHidden  = false
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
        
    }

    // MARK: - Button Action -
    @IBAction func btnBackAction(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func btnLogoutAction(sender: UIButton) {

        let i = self.navigationController?.viewControllers.count
        self.navigationController?.popToViewController(self.navigationController?.viewControllers[i!-3] as! UIViewController, animated: false)
        
    }
    
}
