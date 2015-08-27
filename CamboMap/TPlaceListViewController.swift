//
//  TPlaceListViewController.swift
//  CamboMap
//
//  Created by Yoman on 8/3/15.
//  Copyright (c) 2015 AlwayAtHome. All rights reserved.
//

import UIKit

class TPlaceListViewController: YomanViewController ,UITableViewDataSource , UITableViewDelegate{

    var imageNameList  : Array <NSString> = []
    
    var arrData = NSMutableArray()
    
    @IBOutlet var mainTableView: UITableView!

    var cell : UITableViewCell?
    
    let IMV     = UIImageView()
    
    // MARK: - View LifeCycle Method Area -
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "List"
        self.navigationController?.navigationBarHidden  = false
       
        arrData.addObject("Cambodia Kingdam of Wonder")
        arrData.addObject("South Korea")
     
        var index = 1
        while(index < 3){
            let imageName = NSString(format: "z%d.jpg", index)
            imageNameList.append(imageName)
            index++
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    // MARK: - UITableView Method Area -
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        return 180;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrData.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
   
        cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as? UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "reuseIdentifier")


        }
        var TestWidth = textWidthMeasure(arrData[indexPath.row] as! String, constrainedToSize: CGSizeMake(UIScreen.mainScreen().bounds.size.width-16-10,2000), fontSize: 20) as CGFloat
        
        
        let IMV     = UIImageView()
        IMV.image   = UIImage(named: self.imageNameList[indexPath.row] as String)
        IMV.frame   = CGRectMake(0 , 0, cell!.bounds.size.width, cell!.bounds.size.height)
        cell!.contentView.addSubview(IMV)
        
 
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = CGRectMake(cell!.bounds.size.width / 2 - (TestWidth + 15) / 2 , cell!.bounds.size.height / 2 - 25 , TestWidth + 15 , 50)
        cell!.contentView.addSubview(blurView)
        
        let lblTittle           = UILabel()
       
        lblTittle.layer.borderWidth  = 1
        lblTittle.layer.borderColor = UIColor.whiteColor().CGColor
        lblTittle.text          = arrData[indexPath.row] as? String
        lblTittle.textAlignment = NSTextAlignment.Center
        lblTittle.textColor     = UIColor.whiteColor()
        lblTittle.font          = UIFont(name: kDefaultFontName, size: 20)
        lblTittle.frame         = CGRectMake(cell!.bounds.size.width / 2 - TestWidth / 2 , cell!.bounds.size.height / 2 - 20 , TestWidth , 40)
        cell!.contentView.addSubview(lblTittle)
        
        return cell!
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!
        
        if(indexPath.row==0){
            self.performSegueWithIdentifier("placeDetailSegue", sender: nil)
        }else{
            SysUtils.showMessage("Comming Soon man......!")
        }
      
    }
    
    // MARK: - Button Action -
    @IBAction func btnBackAction(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
   
    // MARK: - Navigation -
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }
    
    func textWidthMeasure(str:NSString, constrainedToSize:CGSize, fontSize:CGFloat)->CGFloat{
        return str .boundingRectWithSize(constrainedToSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(fontSize)], context: nil).size.width
    }

}
