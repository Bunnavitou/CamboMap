//
//  TPlaceListDetailViewCell.swift
//  CamboMap
//
//  Created by Yoman on 8/19/15.
//  Copyright (c) 2015 AlwayAtHome. All rights reserved.
//

import UIKit

class TPlaceListDetailViewCell: UICollectionViewCell {
    
    var imageName : String?
    var imageViewContent : UIImageView = UIImageView()
    
    var lblNames : String?
    var lblName : UILabel = UILabel()
    
    var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
        contentView.addSubview(imageViewContent)
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageViewContent.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        imageViewContent.image = UIImage(named: imageName!)
        


    
        visualEffectView.clipsToBounds = true
        imageViewContent.addSubview(visualEffectView)
        

        lblName.text = lblNames
        lblName.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        lblName.textColor = UIColor.whiteColor()
        lblName.textAlignment = NSTextAlignment.Center
        lblName.numberOfLines = 5
        imageViewContent.addSubview(lblName)
        
        
        if(UIScreen.mainScreen().bounds.size.width == 320){
            visualEffectView.frame = CGRectMake(frame.size.width / 2 - 60, frame.size.height / 2 - 60 , 120, 120)
            lblName.frame = CGRectMake(frame.size.width / 2 - 60, frame.size.height / 2 - 60 , 120, 120)
            visualEffectView.layer.cornerRadius = 60
        }else{
            visualEffectView.frame = CGRectMake(frame.size.width / 2 - 75, frame.size.height / 2 - 75 , 150, 150)
            lblName.frame = CGRectMake(frame.size.width / 2 - 75, frame.size.height / 2 - 75 , 150, 150)
            visualEffectView.layer.cornerRadius = 75
        }
    }
}


