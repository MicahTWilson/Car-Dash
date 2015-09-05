//
//  MainView.swift
//  Car Dash
//
//  Created by Micah Wilson on 7/13/15.
//  Copyright © 2015 Micah Wilson. All rights reserved.
//

import Foundation
import UIKit

class MainView: UIView {
    let songsButton = DashButton(frame: CGRectZero)
    let artistsButton = DashButton(frame: CGRectZero)
    let albumsButton = DashButton(frame: CGRectZero)
    let playlistButton = DashButton(frame: CGRectZero)
    let voiceButton = DashButton(frame: CGRectZero)
    let settingsButton = DashButton(frame: CGRectZero)
    var startPoint: CGPoint?
    var parent: MainViewController?
    
    override func layoutSubviews() {
        self.backgroundColor = UIColor.darkGrayColor()
        self.addSubview(self.songsButton)
        self.addSubview(self.artistsButton)
        self.addSubview(self.albumsButton)
        self.addSubview(self.playlistButton)
        self.addSubview(self.voiceButton)
        self.addSubview(self.settingsButton)
        
        self.deviceDidRotate()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "deviceDidRotate", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
    }
    
    func updateLandscapeConstraints() {

        self.songsButton.constrainUsing(constraints: [
            .TopToTop : (of: self, multiplier: 1.0, offset: 170),
            .LeftToLeft : (of: self, multiplier: 1.0, offset: 59),
            .Width : (of: nil, multiplier: 1.0, offset: 270),
            .Height : (of: nil, multiplier: 1.0, offset: 270)])
        self.songsButton.setBackgroundImage(UIImage(named: "SongsIcon"), forState: .Normal)
        
        self.artistsButton.constrainUsing(constraints: [
            .TopToTop : (of: self, multiplier: 1.0, offset: 170),
            .CenterXToCenterX : (of: self, multiplier: 1.0, offset: 0),
            .Width : (of: nil, multiplier: 1.0, offset: 270),
            .Height : (of: nil, multiplier: 1.0, offset: 270)])
        self.artistsButton.setBackgroundImage(UIImage(named: "ArtistsIcon"), forState: .Normal)
        
        self.albumsButton.constrainUsing(constraints: [
            .TopToTop : (of: self, multiplier: 1.0, offset: 170),
            .RightToRight : (of: self, multiplier: 1.0, offset: -59),
            .Width : (of: nil, multiplier: 1.0, offset: 270),
            .Height : (of: nil, multiplier: 1.0, offset: 270)])
        self.albumsButton.setBackgroundImage(UIImage(named: "AlbumsIcon"), forState: .Normal)
        
        self.playlistButton.constrainUsing(constraints: [
            .TopToBottom : (of: self.songsButton, multiplier: 1.0, offset: 38),
            .LeftToLeft : (of: self, multiplier: 1.0, offset: 59),
            .Width : (of: nil, multiplier: 1.0, offset: 270),
            .Height : (of: nil, multiplier: 1.0, offset: 270)])
        self.playlistButton.setBackgroundImage(UIImage(named: "PlaylistsIcon"), forState: .Normal)
        
        self.voiceButton.constrainUsing(constraints: [
            .TopToBottom : (of: self.artistsButton, multiplier: 1.0, offset: 38),
            .CenterXToCenterX : (of: self, multiplier: 1.0, offset: 0),
            .Width : (of: nil, multiplier: 1.0, offset: 270),
            .Height : (of: nil, multiplier: 1.0, offset: 270)])
        self.voiceButton.setBackgroundImage(UIImage(named: "VoiceIcon"), forState: .Normal)
        
        self.settingsButton.constrainUsing(constraints: [
            .TopToBottom : (of: self.albumsButton, multiplier: 1.0, offset: 38),
            .RightToRight : (of: self, multiplier: 1.0, offset: -59),
            .Width : (of: nil, multiplier: 1.0, offset: 270),
            .Height : (of: nil, multiplier: 1.0, offset: 270)])
        self.settingsButton.setBackgroundImage(UIImage(named: "SettingsIcon"), forState: .Normal)
    }
    
    func updatePortraitConstraints() {
        
        self.songsButton.constrainUsing(constraints: [
            .TopToTop : (of: self, multiplier: 1.0, offset: 170),
            .LeftToLeft : (of: self, multiplier: 1.0, offset: 59),
            .Width : (of: nil, multiplier: 1.0, offset: 270),
            .Height : (of: nil, multiplier: 1.0, offset: 270)])
        self.songsButton.setBackgroundImage(UIImage(named: "SongsIcon"), forState: .Normal)
        
        self.artistsButton.constrainUsing(constraints: [
            .TopToTop : (of: self, multiplier: 1.0, offset: 170),
            .RightToRight : (of: self, multiplier: 1.0, offset: -59),
            .Width : (of: nil, multiplier: 1.0, offset: 270),
            .Height : (of: nil, multiplier: 1.0, offset: 270)])
        self.artistsButton.setBackgroundImage(UIImage(named: "ArtistsIcon"), forState: .Normal)
        
        self.albumsButton.constrainUsing(constraints: [
            .TopToBottom : (of: self.songsButton, multiplier: 1.0, offset: 18),
            .LeftToLeft : (of: self, multiplier: 1.0, offset: 59),
            .Width : (of: nil, multiplier: 1.0, offset: 270),
            .Height : (of: nil, multiplier: 1.0, offset: 270)])
        self.albumsButton.setBackgroundImage(UIImage(named: "AlbumsIcon"), forState: .Normal)
        
        self.playlistButton.constrainUsing(constraints: [
            .TopToBottom : (of: self.artistsButton, multiplier: 1.0, offset: 18),
            .RightToRight : (of: self, multiplier: 1.0, offset: -59),
            .Width : (of: nil, multiplier: 1.0, offset: 270),
            .Height : (of: nil, multiplier: 1.0, offset: 270)])
        self.playlistButton.setBackgroundImage(UIImage(named: "PlaylistsIcon"), forState: .Normal)
        
        self.voiceButton.constrainUsing(constraints: [
            .TopToBottom : (of: self.albumsButton, multiplier: 1.0, offset: 18),
            .LeftToLeft : (of: self, multiplier: 1.0, offset: 59),
            .Width : (of: nil, multiplier: 1.0, offset: 270),
            .Height : (of: nil, multiplier: 1.0, offset: 270)])
        self.voiceButton.setBackgroundImage(UIImage(named: "VoiceIcon"), forState: .Normal)
        
        self.settingsButton.constrainUsing(constraints: [
            .TopToBottom : (of: self.playlistButton, multiplier: 1.0, offset: 18),
            .RightToRight : (of: self, multiplier: 1.0, offset: -59),
            .Width : (of: nil, multiplier: 1.0, offset: 270),
            .Height : (of: nil, multiplier: 1.0, offset: 270)])
        self.settingsButton.setBackgroundImage(UIImage(named: "SettingsIcon"), forState: .Normal)
    }
    
    func deviceDidRotate() {
        if UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation) {
            self.updateLandscapeConstraints()
        } else if UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation) {
            self.updatePortraitConstraints()
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in touches {
            self.startPoint = (touch as! UITouch).locationInView(self)
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in touches {
            let point = (touch as! UITouch).locationInView(self)
            let distanceHorizontal = point.x - startPoint!.x
            let distanceVertical = point.y - startPoint!.y
            
            
            if abs(distanceHorizontal) > abs(distanceVertical) {
                if distanceHorizontal > 200 {
                    print("Next Song")
                    self.parent?.skipToNextTrack()
                } else if distanceHorizontal < -200 {
                    print("Previous Song")
                    self.parent?.skipToPreviousTrack()
                }
            } else {
                if distanceVertical > 200 {
                    //Move Volume up a notch
                    print("Move Volume down a Notch \n")
                    self.parent?.decreaseVolume()
                } else if distanceVertical < -200 {
                    //Move Volume down a notch
                    print("Move Volume up a Notch \n")
                    self.parent?.increaseVolume()
                }
            }
            
        }
    }
}
