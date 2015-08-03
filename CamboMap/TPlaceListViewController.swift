//
//  TPlaceListViewController.swift
//  CamboMap
//
//  Created by Yoman on 8/3/15.
//  Copyright (c) 2015 AlwayAtHome. All rights reserved.
//

import UIKit

class TPlaceListViewController: YomanViewController {

    
    
    @IBOutlet var mainTableView: UITableView!
    
    // MARK: - View LifeCycle Method Area -
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "List"
        self.navigationController?.navigationBarHidden  = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    // MARK: - UITableView Method Area -
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier) as UITableViewCell
        
        }
        
        cell!.textLabel?.font        = UIFont.systemFontOfSize(15)
        cell!.textLabel?.textColor   = UIColor(red: 80 / 255, green: 80 / 255, blue: 80 / 255, alpha: 1)
        cell!.detailTextLabel?.font  = UIFont.systemFontOfSize(12)
        cell!.detailTextLabel?.textColor = UIColor(red: 150 / 255, green: 150 / 255, blue: 150 / 255, alpha: 1)
        
        cell!.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        
        if(indexPath.row % 2 != 0){
            cell?.backgroundColor=UIColor.lightGrayColor()
        }

      
        cell?.textLabel?.text="YOMAN"
        
        return cell!
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!
        
        
        
    }

   
    // MARK: - Navigation -
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }


}
