//
//  TPlaceListDetailViewController.swift
//  CamboMap
//
//  Created by Yoman on 8/19/15.
//  Copyright (c) 2015 AlwayAtHome. All rights reserved.
//

import UIKit


class TPlaceListDetailViewController: UICollectionViewController  {
    
    let reuseIdentifier = "yomanCell"
    
    var arrData = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.title="Cambodia"
        
        arrData.addObject("Phnom Penh")
        arrData.addObject("Sihanoukville")
        arrData.addObject("Kep")
        arrData.addObject("Siem Reap")
        arrData.addObject("Kampot")
      
        
        let button: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        button.setImage(UIImage(named: "Yo-Back.png"), forState: UIControlState.Normal)
        button.addTarget(self, action: "btnBackAction:", forControlEvents: UIControlEvents.TouchUpInside)
        button.frame    = CGRectMake(0, 0, 25, 25)
        let barButton   = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
       
    }
    
    func btnBackAction(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   
    }

}

extension TPlaceListDetailViewController : UICollectionViewDataSource {
    // MARK: UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier,forIndexPath: indexPath) as! TPlaceListDetailViewCell
     
        cell.imageD.backgroundColor=UIColor.redColor()
        cell.imageD.layer.cornerRadius = cell.mainCellView.bounds.size.width/2 - 10
        cell.lblName.text = arrData[indexPath.row] as? String
        
        return cell
    }
}

extension TPlaceListDetailViewController : UICollectionViewDelegate {
     override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        var cell : UICollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath)!
        
        
    }
}

extension TPlaceListDetailViewController : UICollectionViewDelegateFlowLayout {

    func collectionView(collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return CGSizeMake(170, 170)
        
    }
  
}

