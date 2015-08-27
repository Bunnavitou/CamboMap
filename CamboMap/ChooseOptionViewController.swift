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
    
    var btnTest : BTRippleButtton!
    var btnTest2 : BTRippleButtton!
    
    let screenWidth   = UIScreen.mainScreen().bounds.size.width
    let screenHeight  = UIScreen.mainScreen().bounds.size.height
    
    
    var slideContentView : UIView!

    //MARK: - View Life Cycle
    //MARK: --------------------------------------
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true) //or animated: false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        CreateScrollViewTur()
        

        
        mainScrollView.pagingEnabled                      = true
        mainScrollView.showsHorizontalScrollIndicator     = false
  
        TittleArray  = ["Visit Map's Best Place","As Our Member Man"]
        Tittle1Array = ["Easy to find where and where gonna go to","Share with your friend on this App Man"]
        ImageArray   = ["Yo-Intro2.png","Yo-Intro1.png"]
  
        mainScrollView.contentSize   = CGSizeMake(screenWidth * CGFloat(TittleArray.count), screenWidth)
        
        for(var i=0;i<ImageArray.count;i++){
            
            //======Image Show
            let IMV     = UIImageView()
            IMV.image   = UIImage(named: "\(ImageArray[i])")
            IMV.frame   = CGRectMake(screenWidth * CGFloat(i) , 0, screenWidth, screenHeight)
            mainScrollView.addSubview(IMV)
            
            //======First Tittle
            let lblTittle           = UILabel()
            lblTittle.text          = "\(TittleArray.objectAtIndex(i))"
            lblTittle.textAlignment = NSTextAlignment.Center
            lblTittle.font          = UIFont(name: kDefaultFontName, size: 32)
            lblTittle.frame         = CGRectMake(screenWidth * CGFloat(i) + screenWidth / 2 - 150 , 50, 300, 30)
            mainScrollView.addSubview(lblTittle)

            
            //======Second Tittle
            let lblTittle1           = UILabel()
            lblTittle1.textAlignment = NSTextAlignment.Center
            lblTittle1.text          = "\(Tittle1Array.objectAtIndex(i))"
            lblTittle1.font          = UIFont(name: kDefaultFontName, size: 15)
            lblTittle1.frame         = CGRectMake(screenWidth * CGFloat(i) + screenWidth / 2 - 150 , 90, 300, 30)
            mainScrollView.addSubview(lblTittle1)
            
            if(i==0){
                 lblTittle.textColor     = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
                 lblTittle1.textColor     = UIColor.grayColor()
            }else{
                 lblTittle.textColor     = UIColor.grayColor()
                 lblTittle1.textColor     = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
                
            }
            
            
           //=== Display Gif File
//            let resourceUrl = NSBundle.mainBundle().URLForResource("Yo-RadarScreen", withExtension: "gif")
//            let imageURL=UIImageView(frame: CGRectMake(screenWidth * 2 - 300 , screenHeight - 325, 220, 220))
//            imageURL.image = UIImage.animatedImageWithAnimatedGIFURL(resourceUrl)
//            mainScrollView.addSubview(imageURL)

            
        }
        ///=======Animation Earth Rotation
        let btnEathAnimiation = DGAaimaView(frame: CGRectMake(screenWidth / 2 - 110 , screenHeight - 335, 220, 220))
        btnEathAnimiation.DGAaimaView(btnEathAnimiation, earthSepped: 0.5, huojianSepped: 1.0)
        mainScrollView.addSubview(btnEathAnimiation)
        
        //======Radar Animation
        let image1: UIImage = UIImage(named: "test111.png")!
        let bgImage1 = UIImageView(image: image1)
        self.mainScrollView.addSubview(bgImage1)
        
        let image: UIImage = UIImage(named: "test222.png")!
        let bgImage = UIImageView(image: image)
        self.mainScrollView.addSubview(bgImage)
        
        let scaleAnimate = CABasicAnimation(keyPath: "transform.rotation.z")
        scaleAnimate.fromValue = 0
        scaleAnimate.toValue = CGFloat(2.5 * 3.15)
        scaleAnimate.duration = 2
        scaleAnimate.cumulative = true
        scaleAnimate.removedOnCompletion = false
        scaleAnimate.autoreverses = false
        scaleAnimate.repeatCount = .infinity
        bgImage.layer.addAnimation(scaleAnimate, forKey: "animation")
        
        let testUV = DGActivityIndicatorView(type: DGActivityIndicatorAnimationType.TriplePulse, tintColor: UIColor.redColor(), size: 30)
       
        self.mainScrollView.addSubview(testUV)
        testUV.startAnimating()
        
        let testUV1 = DGActivityIndicatorView(type: DGActivityIndicatorAnimationType.TriplePulse, tintColor: UIColor.purpleColor(), size: 30)
      
        self.mainScrollView.addSubview(testUV1)
        testUV1.startAnimating()
        
        let testUV2 = DGActivityIndicatorView(type: DGActivityIndicatorAnimationType.TriplePulse, tintColor: UIColor.cyanColor(), size: 30)
        
        self.mainScrollView.addSubview(testUV2)
        testUV2.startAnimating()
       
 
        if(UIScreen.mainScreen().bounds.size.width == 320){
            bgImage1.frame = CGRectMake(screenWidth * 2 - 265,screenHeight - 325,210,210)
            bgImage.frame = CGRectMake(screenWidth * 2 - 265,screenHeight - 325,210,210)
            testUV.frame=CGRectMake(screenWidth * 2 - 160, screenHeight - 290, 100, 100)
            testUV1.frame=CGRectMake(screenWidth * 2 - 120, screenHeight - 235, 100, 100)
            testUV2.frame=CGRectMake(screenWidth * 2 - 230, screenHeight - 180, 100, 100)
            
            btnTest = BTRippleButtton(image: UIImage(named:"Yo-IntroBtb1.png"), andFrame: CGRectMake(screenWidth/2 - 40, 130, 80, 80), andTarget: "BtnLoginAction:", andID: self)
        }else{
            bgImage1.frame = CGRectMake(screenWidth * 2 - 295,screenHeight - 335,210,210)
            bgImage.frame = CGRectMake(screenWidth * 2 - 295,screenHeight - 335,210,210)
            testUV.frame=CGRectMake(screenWidth * 2 - 240, screenHeight - 335, 100, 100)
            testUV1.frame=CGRectMake(screenWidth * 2 - 200, screenHeight - 265, 100, 100)
            testUV2.frame=CGRectMake(screenWidth * 2 - 300, screenHeight - 220, 100, 100)
            
            btnTest = BTRippleButtton(image: UIImage(named:"Yo-IntroBtb1.png"), andFrame: CGRectMake(screenWidth/2 - 65, 140, 130, 130), andTarget: "BtnLoginAction:", andID: self)
        }
        
        //=====Button Click Log process
        btnTest.setRippeEffectEnabled(true)
        btnTest.setRippleEffectWithColor(UIColor(red: 32/255.0, green: 32/255.0, blue: 32/255.0, alpha: 1.0))
        self.view.addSubview(btnTest)
        
        //=====Create PageController
        Page                                = CustomPageControl()
        Page.pageIndicatorTintColor         = UIColor.lightGrayColor()
        Page.currentPageIndicatorTintColor  = UIColor.whiteColor()
        Page.currentPage                    = 0
        Page.numberOfPages                  = ImageArray.count
        Page.frame                          = CGRectMake(screenWidth / 2-30, screenHeight - 80, 60, 20)
        self.view.addSubview(Page)
        

    }
    //MARK: - Scroll Dalegate Method
    //MARK: --------------------------------------
    func scrollViewDidScroll(scrollView: UIScrollView) {
        println("x - > \(scrollView.contentOffset.x)")
        println(scrollView.contentOffset.y)
        
        if(SysUtils.isNull(scrollView.contentOffset.y)){
            slideContentView.frame = CGRectMake(slideContentView.frame.origin.x,
                self.view.frame.size.height - 50  - scrollView.contentOffset.y,
                slideContentView.frame.size.width,
                slideContentView.frame.size.height + scrollView.contentOffset.y);
            return
        }
  
        var pageWidth : CGFloat=mainScrollView.bounds.size.width
        var page = Int(floor((mainScrollView.contentOffset.x - pageWidth / 2.0) / pageWidth) + 1.0)
        Page.currentPage=page
        
        if(page == 0){
            btnTest.setImage(UIImage(named: "Yo-IntroBtb1.png"))
        }else{
            btnTest.setImage(UIImage(named: "Yo-IntroBtb2.png"))
        }

    }
    
    //MARK: - Button Action Method
    //MARK: -------------------------------------
    func BtnLoginAction(sender: AnyObject) {
        if(Page.currentPage == 0 ){  // Go to TuristShip
            self.performSegueWithIdentifier("touristMap", sender: nil)
        }else{                       // Go to MemberShip
            self.performSegueWithIdentifier("AsMemberLog", sender: nil)
        }
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func BtnActionInfo(sender: AnyObject) {
        println("YOMAN is here")
        
        self.performSegueWithIdentifier("tutorialpagesegue", sender: nil)
        
    }
    
    
    
    func CreateScrollViewTur(){

        var blurredBgImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        blurredBgImage.contentMode=UIViewContentMode.ScaleToFill
        self.view.addSubview(blurredBgImage)
        
        slideContentView = UIView(frame: CGRectMake(0, self.view.frame.size.height - 50 , self.view.frame.size.width, self.view.frame.size.height))
        slideContentView.backgroundColor = UIColor.lightGrayColor()
        self.view.insertSubview(slideContentView, atIndex: 1)
        
        var slideUpLabel = UILabel(frame: CGRectMake(0, 6, self.view.frame.size.width, 50))
        slideUpLabel.text="Author information"
        slideUpLabel.font=UIFont(name: "HelveticaNeue-Light", size: 22)
        slideUpLabel.textAlignment=NSTextAlignment.Center
        slideUpLabel.textColor = UIColor(white: 0, alpha: 0.5)
        slideContentView.addSubview(slideUpLabel)

        var slideUpImage = UIImageView(frame: CGRectMake(self.view.frame.size.width/2 - 12, 4, 24, 22.5))
        slideUpImage.image = UIImage(named: "Yo-up-arrow.png")
        slideContentView.addSubview(slideUpImage)
        
        var detailsText = UITextView(frame: CGRectMake(0, 0, 0, 0))
        detailsText.backgroundColor=UIColor.clearColor()
        detailsText.text="Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        detailsText.font=UIFont(name: "HelveticaNeue-Light", size: 16)
        detailsText.textAlignment=NSTextAlignment.Center
        detailsText.textColor = UIColor(white: 0, alpha: 0.5)
        slideContentView.addSubview(detailsText)
        
    }
}
