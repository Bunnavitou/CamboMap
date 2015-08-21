//
//  TutorialPageViewController.swift
//  CamboMap
//
//  Created by Yoman on 7/29/15.
//  Copyright (c) 2015 AlwayAtHome. All rights reserved.
//

import UIKit
import MediaPlayer

class TutorialPageViewController: UIViewController {

    @IBOutlet var mainScroll: UIScrollView!
    
    var TittleArray  : NSArray = []
    
    var moviePlayer:MPMoviePlayerController!
    
    //MARK: - View Life Cycle
    //MARK: --------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        self.navigationController?.navigationBarHidden  = true
        //====for play moive
        var url:NSURL = NSURL(string: "http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v")!
        moviePlayer = MPMoviePlayerController(contentURL: url)
        moviePlayer.view.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height)
        self.view.addSubview(moviePlayer.view)
        self.view.insertSubview(moviePlayer.view, atIndex: 0)
        moviePlayer.fullscreen = true
        moviePlayer.controlStyle = MPMovieControlStyle.None
        
        
        mainScroll.pagingEnabled                      = true
        mainScroll.showsHorizontalScrollIndicator     = false
        
        TittleArray  = ["YOMAN 1","YOMAN 2"]
    
        let screenWidth   = UIScreen.mainScreen().bounds.size.width
        let scrollheight  = mainScroll.bounds.size.height
        
        mainScroll.contentSize   = CGSizeMake(screenWidth * CGFloat(TittleArray.count), screenWidth)
        
        for(var i=0;i<TittleArray.count;i++){
            
            //======First Tittle
            let lblTittle           = UILabel()
            lblTittle.textColor     = UIColor(red: 80/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1.0)
            lblTittle.text          = "\(TittleArray.objectAtIndex(i))"
            lblTittle.textAlignment = NSTextAlignment.Center
            lblTittle.font          = UIFont(name: lblTittle.font.fontName, size: 32)
            lblTittle.frame         = CGRectMake(screenWidth * CGFloat(i) + screenWidth / 2 - 150 , 50, 300, 30)
            mainScroll.addSubview(lblTittle)
            
            //======Button Login
            let BtnLogin            = UIButton()
            BtnLogin.setTitle("Close Me  ", forState: UIControlState.Normal)
            BtnLogin.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            BtnLogin.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
            BtnLogin.setTitleColor(UIColor.blackColor(), forState: UIControlState.Selected)
            BtnLogin.layer.cornerRadius = 5
            BtnLogin.layer.borderColor  = UIColor.lightGrayColor().CGColor
            BtnLogin.layer.borderWidth  = 1
            BtnLogin.addTarget(self, action:"BtnLoginAction:", forControlEvents: UIControlEvents.TouchUpInside)
            BtnLogin.frame  = CGRectMake(screenWidth * CGFloat(i) + screenWidth/2 - 100 ,  150 , 200, 35)
            mainScroll.addSubview(BtnLogin)
            
        }
    }
    
    //MARK: - Button Action Method
    //MARK: -------------------------------------
    func BtnLoginAction(sender: AnyObject) {
        self.navigationController?.navigationBarHidden  = false
        self.dismissViewControllerAnimated(false, completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
}
