//
//  TPlaceListDetailViewController.swift
//  CamboMap
//
//  Created by Yoman on 8/19/15.
//  Copyright (c) 2015 AlwayAtHome. All rights reserved.
//

import UIKit

let reuseIdentifier = "yomanCell"

class TPlaceListDetailViewController: UICollectionViewController,CHTCollectionViewDelegateWaterfallLayout  {
    
    var imageNameList  : Array <NSString> = []

    let gridWidths : CGFloat = (UIScreen.mainScreen().bounds.size.width/2)-5.0
    
    var arrDataName = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var index = 0
        while(index < 5){
            let imageName = NSString(format: "NYCity%d.png", index)
            imageNameList.append(imageName)
            index++
        }
        
        self.title="Cambodia"
        
        arrDataName.addObject("Phnom Penh")
        arrDataName.addObject("Sihanoukville")
        arrDataName.addObject("Kep")
        arrDataName.addObject("Siem Reap")
        
        self.view.backgroundColor=UIColor.lightGrayColor()
        self.collectionView!.frame=CGRectMake(10, 10, UIScreen.mainScreen().bounds.size.width - 20, UIScreen.mainScreen().bounds.size.height - 20)
        self.collectionView!.setCollectionViewLayout(CHTCollectionViewWaterfallLayout(), animated: true)
        self.collectionView!.backgroundColor = UIColor.lightGrayColor()
        self.collectionView!.registerClass(TPlaceListDetailViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.reloadData()
        
        
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
        return arrDataName.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var collectionCell: TPlaceListDetailViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! TPlaceListDetailViewCell
        collectionCell.imageName = self.imageNameList[indexPath.row + 1 ] as String
        collectionCell.lblNames  = self.arrDataName[indexPath.row] as? String
        collectionCell.setNeedsLayout()
        return collectionCell;
    }
}

extension TPlaceListDetailViewController : UICollectionViewDelegate {
     override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        var cell : UICollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath)!
        
        println(indexPath.row)
    }

}

extension TPlaceListDetailViewController : UICollectionViewDelegateFlowLayout {

    func collectionView(collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        
        if(indexPath.row==0){
          
             return CGSizeMake(170, 200)
        }else{
             return CGSizeMake(170, 170)
        }
       
        
    }
  
}

