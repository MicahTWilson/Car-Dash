//
//  SongCollectionCell.swift
//  Car Dash
//
//  Created by Micah Wilson on 7/14/15.
//  Copyright (c) 2015 Micah Wilson. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SongCollectionCell: UICollectionViewCell {
    let songAlbumCover = UIImageView(frame: CGRectZero)
    let songTitleLabel = UILabel(frame: CGRectZero)
    lazy var context: NSManagedObjectContext = {
        var cntx = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        return cntx
        }()
    override func layoutSubviews() {
        self.addSubview(self.songAlbumCover)
        self.addSubview(self.songTitleLabel)
        
        self.songAlbumCover.constrainUsing(constraints: [
            .LeftToLeft : (of: self, multiplier: 1.0, offset: 0),
            .TopToTop : (of: self, multiplier: 1.0, offset: 0),
            .RightToRight : (of: self, multiplier: 1.0, offset: 0),
            .Height : (of: nil, multiplier: 1.0, offset: self.frame.width)])
        //self.songAlbumCover.image = UIImage(named: "SampleArtwork")
        self.songAlbumCover.layer.shouldRasterize = true
        self.songAlbumCover.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        self.songTitleLabel.constrainUsing(constraints: [
            .LeftToLeft : (of: self, multiplier: 1.0, offset: 0),
            .BottomToBottom : (of: self, multiplier: 1.0, offset: 0),
            .RightToRight : (of: self, multiplier: 1.0, offset: 0),
            .Height : (of: nil, multiplier: 1.0, offset: 30)])
        self.songTitleLabel.textAlignment = .Center
        self.songTitleLabel.textColor = UIColor(red:0.98, green:0.82, blue:0.09, alpha:1)
        self.songTitleLabel.font = UIFont(name: "Avenir-Medium", size: 22)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}