//
//  SongsCollectionView.swift
//  Car Dash
//
//  Created by Micah Wilson on 7/14/15.
//  Copyright (c) 2015 Micah Wilson. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer
import AVFoundation
let sectionsString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ#"

enum galleryType {
    case Songs, Artists, Albums, Playlists
    init() {
        self = .Songs
    }
}

class SongsCollectionView: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var songs: [AnyObject]!
    var parent: MainViewController?
    var nowPlayingView: NowPlayingView!
    var contentType = galleryType()
    var previousPosition: UIInterfaceOrientation?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collection = CollectionClass(frame: self.view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        collection.parent = self
        self.collectionView = collection
        self.collectionView?.backgroundColor = UIColor.darkGrayColor()
        self.collectionView?.contentInset = UIEdgeInsets(top: 170, left: 50, bottom: 50, right: 50)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateOrientation", name: UIDeviceOrientationDidChangeNotification, object: nil)
        previousPosition = UIApplication.sharedApplication().statusBarOrientation
    }
    override func viewWillAppear(animated: Bool) {
        self.view.addSubview(self.nowPlayingView)
        self.nowPlayingView.removeConstraints(self.nowPlayingView.constraints())
        self.nowPlayingView.constrainUsing(constraints: [
            .LeftToLeft : (of: self.view, multiplier: 1.0, offset: 0),
            .TopToTop : (of: self.view, multiplier: 1.0, offset: 0),
            .RightToRight : (of: self.view, multiplier: 1.0, offset: 0),
            .Height : (of: nil, multiplier: 1.0, offset: 150)])
        
        self.nowPlayingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "dismissSongView:"))
    }
    
    func updateOrientation() {
        
        let orientation = UIApplication.sharedApplication().statusBarOrientation
        
        switch orientation {
        case .Portrait:
            if previousPosition != .Portrait && previousPosition != .PortraitUpsideDown {
                for (index, item) in enumerate(songs) {
                    if item.isKindOfClass(ExpandableView) {
                        //Move Item back 1 cell
                        let temp: AnyObject = songs[index-1]
                        songs[index-1] = songs[index]
                        songs[index] = temp
                    }
                }
            }
        case .PortraitUpsideDown:
            if previousPosition != .Portrait && previousPosition != .PortraitUpsideDown {
                for (index, item) in enumerate(songs) {
                    if item.isKindOfClass(ExpandableView) {
                        //Move Item back 1 cell
                        let temp: AnyObject = songs[index-1]
                        songs[index-1] = songs[index]
                        songs[index] = temp
                    }
                }
            }
        case .LandscapeRight:
            if previousPosition != .LandscapeRight && previousPosition != .LandscapeLeft {
                for (index, item) in enumerate(songs) {
                    if item.isKindOfClass(ExpandableView) {
                        //Move Item back 1 cell
                        let temp: AnyObject = songs[index+1]
                        songs[index+1] = songs[index]
                        songs[index] = temp
                    }
                }
            }
        case .LandscapeLeft:
            if previousPosition != .LandscapeRight && previousPosition != .LandscapeLeft {
                for (index, item) in enumerate(songs) {
                    if item.isKindOfClass(ExpandableView) {
                        //Move Item back 1 cell
                        let temp: AnyObject = songs[index+1]
                        songs[index+1] = songs[index]
                        songs[index] = temp
                    }
                }
            }
        default:
            break
        }
        self.previousPosition = orientation
        self.collectionView?.reloadData()
    }
    
    func dismissSongView(sender: UITapGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songs!.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if songs![indexPath.row].isKindOfClass(ExpandableView) {
            collectionView.registerClass(ExpandableView.self, forCellWithReuseIdentifier: "expandableCell")
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("expandableCell", forIndexPath: indexPath) as! ExpandableView
            cell.songs = songs![indexPath.row].songs as? [MPMediaItem]
            cell.centerOfCollection = (songs![indexPath.row] as! ExpandableView).centerOfCollection
            cell.mainViewController = (songs![indexPath.row] as! ExpandableView).mainViewController
            cell.collectionView.reloadData()
            cell.setNeedsDisplay()
            return cell
        }
        
        collectionView.registerClass(SongCollectionCell.self, forCellWithReuseIdentifier: "songCell")
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("songCell", forIndexPath: indexPath) as! SongCollectionCell
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        cell.backgroundColor = UIColor.clearColor()
        
        switch self.contentType {
        case .Songs:
            cell.songTitleLabel.text = songs![indexPath.row].representativeItem!.title
            if let artwork = songs![indexPath.row].artwork {
                if artwork == nil {
                    cell.songAlbumCover.image = UIImage(named: "NoArtwork")
                    break
                }
                if let image = artwork.imageWithSize(CGSizeMake(140, 140)) {
                    cell.songAlbumCover.image = image
                } else {
                    cell.songAlbumCover.image = UIImage(named: "NoArtwork")
                }
            } else {
                cell.songAlbumCover.image = UIImage(named: "NoArtwork")
            }
        case .Artists:
            cell.songTitleLabel.text = songs![indexPath.row].representativeItem!.artist
            if let artwork = songs![indexPath.row].representativeItem!.artwork {
                if let image = artwork.imageWithSize(CGSizeMake(140, 140)) {
                    cell.songAlbumCover.image = image
                } else {
                    cell.songAlbumCover.image = UIImage(named: "NoArtwork")
                }
            } else {
                cell.songAlbumCover.image = UIImage(named: "NoArtwork")
            }
        case .Albums:
            cell.songTitleLabel.text = songs![indexPath.row].representativeItem!.albumTitle
            if let artwork = songs![indexPath.row].representativeItem!.artwork {
                if let image = artwork.imageWithSize(CGSizeMake(140, 140)) {
                    cell.songAlbumCover.image = image
                } else {
                    cell.songAlbumCover.image = UIImage(named: "NoArtwork")
                }
            } else {
                cell.songAlbumCover.image = UIImage(named: "NoArtwork")
            }
        case .Playlists:
            cell.songTitleLabel.text = (songs![indexPath.row] as! MPMediaPlaylist).name
            
            if let artwork = (songs![indexPath.row] as! MPMediaPlaylist).representativeItem {
                if let image = artwork.artwork.imageWithSize(CGSizeMake(140, 140)) {
                    cell.songAlbumCover.image = image
                } else {
                    cell.songAlbumCover.image = UIImage(named: "NoArtwork")
                }
            } else {
                cell.songAlbumCover.image = UIImage(named: "NoArtwork")
            }
            
        default:
            break
            
        }
        
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        switch self.contentType {
        case .Songs:
            let allSongs = NSMutableArray(array: songs)
            allSongs.insertObject(songs![indexPath.row], atIndex: 0)
           
            self.parent?.musicPlayer.setQueueWithItemCollection(MPMediaItemCollection(items: allSongs as [AnyObject]))
            self.parent?.musicPlayer.play()
            
            
            self.parent?.updateNowPlaying()
        case .Artists:
            break
            //self.parent?.musicPlayer.setQueueWithItemCollection(songs![indexPath.row] as! MPMediaItemCollection)
        case .Albums:
            break
            //self.parent?.musicPlayer.setQueueWithItemCollection(songs![indexPath.row] as! MPMediaItemCollection)
        case .Playlists:
            break
            //self.parent?.musicPlayer.setQueueWithItemCollection(songs![indexPath.row] as! MPMediaPlaylist)
        default:
            break
        }
        
        if self.contentType != .Songs {
            print(collectionView.cellForItemAtIndexPath(indexPath)!.frame)
            let expandableView = ExpandableView()
            expandableView.songs = self.songs![indexPath.row].items as? [MPMediaItem]
            expandableView.mainViewController = parent
            var removedView = false
            for (index, artist) in enumerate(self.songs) {
                if artist.isKindOfClass(ExpandableView) {
                    self.songs.removeAtIndex(index)
                    collectionView.deleteItemsAtIndexPaths([NSIndexPath(forItem: index, inSection: 0)])
                    if index <= indexPath.row {
                        removedView = true
                    }
                }
            }
            
            var increaseNumber = indexPath.row
            
            if removedView {
                increaseNumber = indexPath.row - 1
            }
            
            expandableView.centerOfCollection = collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: increaseNumber, inSection: 0))!.center
            
            
            let orientation = UIApplication.sharedApplication().statusBarOrientation
            
            if orientation == UIInterfaceOrientation.LandscapeLeft || orientation == UIInterfaceOrientation.LandscapeRight {
                if collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: increaseNumber, inSection: 0))!.frame.origin.x == 0.0 {
                    increaseNumber = 4
                } else if collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: increaseNumber, inSection: 0))!.frame.origin.x == 238.0 {
                    increaseNumber = 3
                } else if collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: increaseNumber, inSection: 0))!.frame.origin.x == 476.0 {
                    increaseNumber = 2
                } else if collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: increaseNumber, inSection: 0))!.frame.origin.x == 714.0 {
                    increaseNumber = 1
                }
            } else if orientation == UIInterfaceOrientation.Portrait || orientation == UIInterfaceOrientation.PortraitUpsideDown {
                if collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: increaseNumber, inSection: 0))!.frame.origin.x == 0.0 {
                    increaseNumber = 3
                } else if collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: increaseNumber, inSection: 0))!.frame.origin.x == 229.0 {
                    increaseNumber = 2
                } else if collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: increaseNumber, inSection: 0))!.frame.origin.x == 458.0 {
                    increaseNumber = 1
                }
            }
            
            
            if removedView {
                increaseNumber--
            }
            
            while indexPath.row + increaseNumber > self.songs.count {
                increaseNumber--
            }
            self.songs.insert(expandableView, atIndex: indexPath.row + increaseNumber)
            
            collectionView.insertItemsAtIndexPaths([NSIndexPath(forItem: indexPath.row + increaseNumber, inSection: indexPath.section)])
            collectionView.reloadData()
            collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: indexPath.row + increaseNumber, inSection: indexPath.section), atScrollPosition: UICollectionViewScrollPosition.CenteredVertically, animated: true)
        }
        
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if songs![indexPath.row].isKindOfClass(ExpandableView) {
            let orientation = UIApplication.sharedApplication().statusBarOrientation
            if orientation == UIInterfaceOrientation.LandscapeLeft || orientation == UIInterfaceOrientation.LandscapeRight {
                return CGSizeMake(924, 310)
            } else {
                return CGSizeMake(693, 310)
            }
            
            
        }
        return CGSizeMake(210, 250)
    }
    
}

class CollectionClass: UICollectionView {
    var parent: SongsCollectionView?
    var startPoint: CGPoint?
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        self.nextResponder()?.touchesBegan(touches, withEvent: event)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)

    }
}