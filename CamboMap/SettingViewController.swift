//
//  SettingViewController.swift
//  CamboMap
//
//  Created by Yoman on 7/30/15.
//  Copyright (c) 2015 AlwayAtHome. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title="Setting"
        self.navigationController?.navigationBarHidden  = false
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
        
        


    }

    
    @IBAction func btnLogoutAction(sender: UIButton) {
        self.removeObserver(self, forKeyPath: "myLocation", context: nil)
        
        let i = self.navigationController?.viewControllers.count
        self.navigationController?.popToViewController(self.navigationController?.viewControllers[i!-3] as! UIViewController, animated: false) // 현재 페이지에서 -2page
        
        
    }
    
    
    
    
    
}
