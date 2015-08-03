//
//  ChooseOptionViewController.swift
//  CamboMap
//
//  Created by Yoman on 7/29/15.
//  Copyright (c) 2015 AlwayAtHome. All rights reserved.
//


import UIKit

class ChooseOptionViewController: YomanViewController,UIScrollViewDelegate {

    @IBOutlet var mainScrollView: UIScrollView!
    
    var Page :CustomPageControl!
    
    var TittleArray  : NSArray = []
    var Tittle1Array : NSArray = []
    var ImageArray   : NSArray = []
    
    
    //MARK: - View Life Cycle
    //MARK: --------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mainScrollView.pagingEnabled                      = true
        mainScrollView.showsHorizontalScrollIndicator     = false
  
        TittleArray  = ["YOMAN 1","YOMAN 2"]
        Tittle1Array = ["How are you man ? Just ask for fun only.","where are you man ? Just ask for fun only."]
        ImageArray   = ["Yo_memberChoose.png","Yo_turistChoose.png"]
        let screenWidth   = UIScreen.mainScreen().bounds.size.width
        let scrollheight  = mainScrollView.bounds.size.height
        
        mainScrollView.contentSize   = CGSizeMake(screenWidth * CGFloat(TittleArray.count), screenWidth)
        
        for(var i=0;i<TittleArray.count;i++){
            
            //======First Tittle
            let lblTittle           = UILabel()
            lblTittle.textColor     = UIColor(red: 80/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1.0)
            lblTittle.text          = "\(TittleArray.objectAtIndex(i))"
            lblTittle.textAlignment = NSTextAlignment.Center
            lblTittle.font          = UIFont(name: lblTittle.font.fontName, size: 32)
            lblTittle.frame         = CGRectMake(screenWidth * CGFloat(i) + screenWidth / 2 - 150 , 50, 300, 30)
            mainScrollView.addSubview(lblTittle)
            
            //======Second Tittle
            let lblTittle1           = UILabel()
            lblTittle1.textAlignment = NSTextAlignment.Center
            lblTittle1.text          = "\(Tittle1Array.objectAtIndex(i))"
            lblTittle1.textColor     = UIColor(red: 32/255.0, green: 32/255.0, blue: 32/255.0, alpha: 1.0)
            lblTittle1.font          = UIFont(name: lblTittle.font.fontName, size: 15)
            lblTittle1.frame         = CGRectMake(screenWidth * CGFloat(i) + screenWidth / 2 - 150 , 90, 300, 30)
            mainScrollView.addSubview(lblTittle1)
            
            
            //======Button Login
            let BtnLogin            = UIButton()
            BtnLogin.setTitle("Choosee to Activation ", forState: UIControlState.Normal)
            BtnLogin.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            BtnLogin.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
            BtnLogin.setTitleColor(UIColor.blackColor(), forState: UIControlState.Selected)
            BtnLogin.layer.cornerRadius = 5
            BtnLogin.layer.borderColor  = UIColor.lightGrayColor().CGColor
            BtnLogin.layer.borderWidth  = 1
            BtnLogin.addTarget(self, action:"BtnLoginAction:", forControlEvents: UIControlEvents.TouchUpInside)
            BtnLogin.frame  = CGRectMake(screenWidth * CGFloat(i) + screenWidth/2 - 100 ,  175 , 200, 35)
            mainScrollView.addSubview(BtnLogin)
            
            
            //======Image Show
            let IMV     = UIImageView()
            IMV.image   = UIImage(named: "\(ImageArray.objectAtIndex(i))")
            if(UIScreen .mainScreen().bounds.size.height < 500){
                IMV.frame   = CGRectMake(screenWidth * CGFloat(i) + 55 , 265 , screenWidth - 100, UIScreen.mainScreen().bounds.size.height-265)
            }else{
                IMV.frame   = CGRectMake(screenWidth * CGFloat(i) + 25 , 265 , screenWidth - 50, UIScreen.mainScreen().bounds.size.height-400)
            }
            mainScrollView.addSubview(IMV)
            
        }
        //=====Create PageController
        Page                                = CustomPageControl()
        Page.pageIndicatorTintColor         = UIColor.lightGrayColor()
        Page.currentPageIndicatorTintColor  = UIColor.blackColor()
        Page.inactiveImage                  = UIImage(named: "rolling_default.png")
        Page.activeImage                    = UIImage(named: "rolling_select.png")
        Page.currentPage                    = 0
        Page.numberOfPages                  = ImageArray.count
        Page.frame                          = CGRectMake(screenWidth / 2-35, 150, 60, 20)
        self.view.addSubview(Page)
        
      
    }
    //MARK: - Scroll Dalegate Method
    //MARK: --------------------------------------
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var pageWidth : CGFloat=mainScrollView.bounds.size.width
        var page = Int(floor((mainScrollView.contentOffset.x - pageWidth / 2.0) / pageWidth) + 1.0)
        Page.currentPage=page
    }
    
    //MARK: - Button Action Method
    //MARK: -------------------------------------
    func BtnLoginAction(sender: AnyObject) {
        if(Page.currentPage == 0 ){  // Go to MemberShip
            self.performSegueWithIdentifier("AsMemberLog", sender: nil)
           
        }else{                       // Go to TuristShip
            self.performSegueWithIdentifier("touristMap", sender: nil)
        }
        
    }
    
    @IBAction func BtnActionInfo(sender: AnyObject) {
        
        println("YOMAN is here")
        
        self.performSegueWithIdentifier("tutorialpagesegue", sender: nil)
        
        
    }
    
    
}
