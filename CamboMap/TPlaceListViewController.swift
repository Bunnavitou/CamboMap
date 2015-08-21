//
//  TPlaceListViewController.swift
//  CamboMap
//
//  Created by Yoman on 8/3/15.
//  Copyright (c) 2015 AlwayAtHome. All rights reserved.
//

import UIKit

class TPlaceListViewController: YomanViewController {


    var arrData = NSMutableArray()
    
    @IBOutlet var mainTableView: UITableView!
    
    // MARK: - View LifeCycle Method Area -
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "List"
        self.navigationController?.navigationBarHidden  = false
        
        arrData.addObject("Asia")
        arrData.addObject("Cambodia")
        arrData.addObject("South Korea")
     
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    // MARK: - UITableView Method Area -
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrData.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier) as UITableViewCell
            
            if(indexPath.row==1){
                var vline   = UIView()
                vline.frame = CGRectMake(20, 44, self.mainTableView.frame.size.width-20, 1)
                vline.backgroundColor=UIColor.whiteColor()
                cell?.contentView.addSubview(vline)
            }
        }
        
       
        cell!.textLabel?.font        = UIFont.systemFontOfSize(15)
       
        if(indexPath.row==0){
            cell!.textLabel?.textColor   = UIColor(red: 102 / 255, green: 102 / 255, blue: 153 / 255, alpha: 1)
        }else{
            
            
            cell!.backgroundColor=UIColor(red: 51 / 255, green: 153 / 255, blue: 255 / 255, alpha: 1)
            cell!.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
            cell!.textLabel?.textColor   = UIColor(red: 80 / 255, green: 80 / 255, blue: 80 / 255, alpha: 1)
        }
        
        //        if(indexPath.row % 2 != 0){
        //            cell?.backgroundColor=UIColor.lightGrayColor()
        //        }
        
        cell?.textLabel?.text=arrData[indexPath.row] as? String
        

        
        return cell!
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!
        
        
        self.performSegueWithIdentifier("placeDetailSegue", sender: nil)
    }
    
    // MARK: - Button Action -
    @IBAction func btnBackAction(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
   
    // MARK: - Navigation -
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }


}
