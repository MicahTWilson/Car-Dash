//
//  ExpandableView.swift
//  Car Dash
//
//  Created by Micah Wilson on 7/15/15.
//  Copyright (c) 2015 Micah Wilson. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

class ExpandableView: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: FlowLayout())
    let arrowIndicator = UIImageView(frame: CGRectZero)
    var songs: [MPMediaItem]!
    var centerOfCollection: CGPoint!
    var mainViewController: MainViewController!
    override func layoutSubviews() {
        self.backgroundColor = UIColor.clearColor()
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = false
        self.addSubview(self.collectionView)
        
        var layout = FlowLayout()
        layout.scrollDirection = .Horizontal
        self.collectionView.collectionViewLayout = layout
        self.collectionView.constrainUsing(constraints: [
            .TopToTop : (of: self, multiplier: 1.0, offset: 25.0),
            .LeftToLeft : (of: self, multiplier: 1.0, offset: 0.0),
            .RightToRight : (of: self, multiplier: 1.0, offset: 0.0),
            .BottomToBottom : (of: self, multiplier: 1.0, offset: 0.0)])
        self.collectionView.backgroundColor = UIColor.lightGrayColor()
        self.collectionView.layer.cornerRadius = 10.0
        self.collectionView.layer.shadowOpacity = 0.8
        self.collectionView.layer.shadowOffset = CGSizeMake(0, 0)
        self.collectionView.layer.shadowRadius = 3
        self.collectionView.layer.shadowColor = UIColor.blackColor().CGColor
        self.collectionView.contentInset = UIEdgeInsetsMake(25, 10, 10, 25)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songs.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        collectionView.registerClass(SongCollectionCell.self, forCellWithReuseIdentifier: "collectionSongCell")
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionSongCell", forIndexPath: indexPath) as! SongCollectionCell
        cell.backgroundColor = .clearColor()
        cell.songTitleLabel.text = songs![indexPath.row].title
        if let artwork = songs![indexPath.row].artwork {
            if let image = artwork.imageWithSize(CGSizeMake(140, 140)) {
                cell.songAlbumCover.image = image
            } else {
                cell.songAlbumCover.image = UIImage(named: "NoArtwork")
            }
        } else {
            cell.songAlbumCover.image = UIImage(named: "NoArtwork")
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let allSongs = NSMutableArray(array: self.songs)
        allSongs.insertObject(self.songs![indexPath.row], atIndex: 0)
        
        self.mainViewController?.musicPlayer.setQueueWithItemCollection(MPMediaItemCollection(items: allSongs as [AnyObject]))
        self.mainViewController?.musicPlayer.play()
        self.mainViewController?.updateNowPlaying()
    }
    
    override func drawRect(rect: CGRect) {
        var arrowRect = CGRectMake(self.centerOfCollection.x - 25, 0, 50, 35)
        
        var ctx = UIGraphicsGetCurrentContext()
        CGContextBeginPath(ctx)
        CGContextMoveToPoint(ctx, CGRectGetMinX(arrowRect), CGRectGetMaxY(arrowRect))
        CGContextAddLineToPoint(ctx, CGRectGetMidX(arrowRect), CGRectGetMinY(arrowRect))
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(arrowRect), CGRectGetMaxY(arrowRect))
        CGContextClosePath(ctx)
        CGContextSetShadowWithColor(ctx, CGSizeMake(0, 0), 3, UIColor.blackColor().CGColor)
        CGContextSetRGBFillColor(ctx, 2/3, 2/3, 2/3, 1)
        CGContextFillPath(ctx)
    }
}

class FlowLayout: UICollectionViewFlowLayout {
    override var scrollDirection: UICollectionViewScrollDirection {
        set {
            super.scrollDirection = .Horizontal
        }
        get {
            return UICollectionViewScrollDirection.Horizontal
        }
    }
    
    override var itemSize: CGSize {
        set {
        }
        get {
            return CGSizeMake(210, 250)
        }
    }
}