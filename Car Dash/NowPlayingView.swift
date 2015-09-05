//
//  NowPlayingView.swift
//  Car Dash
//
//  Created by Micah Wilson on 1/7/15.
//  Copyright © 2015 Micah Wilson. All rights reserved.
//

import Foundation
import UIKit

class NowPlayingView: UIView {
    let playButton = UIButton(frame: CGRectZero)
    let songTitleLabel = UILabel(frame: CGRectZero)
    let songAlbumArtistLabel = UILabel(frame: CGRectZero)
    let songArtworkImage = UIImageView(frame: CGRectZero)
    
    override func layoutSubviews() {
        self.layer.borderColor = UIColor(red:0.98, green:0.82, blue:0.09, alpha:1).CGColor
        self.layer.borderWidth = 4
        self.backgroundColor = .darkGrayColor()
        self.addSubview(self.playButton)
        self.addSubview(self.songTitleLabel)
        self.addSubview(self.songAlbumArtistLabel)
        self.addSubview(self.songArtworkImage)
        
        self.playButton.constrainUsing(constraints: [
            .TopToTop : (of: self, multiplier: 1.0, offset: 37),
            .LeftToLeft: (of: self, multiplier: 1.0, offset: 20),
            .BottomToBottom: (of: self, multiplier: 1.0, offset: -15),
            .Width: (of: nil, multiplier: 1.0, offset: 90)])
        //self.playButton.setBackgroundImage(UIImage(named: "PlayIcon"), forState: .Normal)
        
        self.songArtworkImage.constrainUsing(constraints: [
            .TopToTop : (of: self, multiplier: 1.0, offset: 32),
            .RightToRight: (of: self, multiplier: 1.0, offset: -18),
            .BottomToBottom: (of: self, multiplier: 1.0, offset: -15),
            .Width: (of: nil, multiplier: 1.0, offset: 100)])
        //self.songArtworkImage.image = UIImage(named: "SampleArtwork")
        
        self.songTitleLabel.constrainUsing(constraints: [
            .TopToTop : (of: self, multiplier: 1.0, offset: 39),
            .CenterXToCenterX: (of: self, multiplier: 1.0, offset: 0),
            .LeftToRight: (of: self.playButton, multiplier: 1.0, offset: 0),
            .RightToLeft: (of: self.songArtworkImage, multiplier: 1.0, offset: 0),
            .Height: (of: nil, multiplier: 1.0, offset: 50)])
        self.songTitleLabel.textColor = UIColor(red:0.98, green:0.82, blue:0.09, alpha:1)
        self.songTitleLabel.textAlignment = .Center
        self.songTitleLabel.font = UIFont(name: "Avenir-Medium", size: 36)
        //self.songTitleLabel.text = "Airplanes (Feat. Hayley Williams)"
        
        self.songAlbumArtistLabel.constrainUsing(constraints: [
            .TopToBottom : (of: self.songTitleLabel, multiplier: 1.0, offset: 2),
            .CenterXToCenterX: (of: self, multiplier: 1.0, offset: 0),
            .LeftToRight: (of: self.playButton, multiplier: 1.0, offset: 0),
            .RightToLeft: (of: self.songArtworkImage, multiplier: 1.0, offset: 0),
            .Height: (of: nil, multiplier: 1.0, offset: 33)])
        self.songAlbumArtistLabel.textColor = UIColor(red:0.98, green:0.82, blue:0.09, alpha:1)
        self.songAlbumArtistLabel.textAlignment = .Center
        self.songAlbumArtistLabel.font = UIFont(name: "Avenir-Medium", size: 24)
        //self.songAlbumArtistLabel.text = "Airplanes Single - B.o.B"

        self.setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(rect: CGRectMake(0, 18, self.frame.width, 4))
        UIColor(red:0.98, green:0.82, blue:0.09, alpha:1).setFill()
        path.fill()
    }
}