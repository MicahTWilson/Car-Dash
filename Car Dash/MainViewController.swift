//
//  ViewController.swift
//  Car Dash
//
//  Created by Micah Wilson on 7/13/15.
//  Copyright © 2015 Micah Wilson. All rights reserved.
//

import UIKit
import MediaPlayer
import CoreMotion
class MainViewController: UIViewController, UIGestureRecognizerDelegate {
    let mainView = MainView()
    let nowPlaingView = NowPlayingView()
    let musicPlayer = MPMusicPlayerController.systemMusicPlayer()
    var motionManager = CMMotionManager()
    var motionArray = [Float]()
    
    override func loadView() {
        self.view = mainView
        self.mainView.parent = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.motionManager.deviceMotionAvailable {
            self.motionManager.deviceMotionUpdateInterval = 0.1
            self.motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: { (data: CMDeviceMotion!, error: NSError!) -> Void in

                var dataTotal = abs(data.userAcceleration.x) + abs(data.userAcceleration.y) + abs(data.userAcceleration.z)
                //println(dataTotal)
                self.motionArray.append(Float(dataTotal))
                
                
                
                if self.motionArray.count == 10 {
                    var count = 0
                    for dat in self.motionArray {
                        if  dat < 0.015 {
                            count++
                        }
                        if count == 10 {
                            //print("PAUSE MUSIC THE CAR IS OFF")
                            self.musicPlayer.pause()
                            self.updateNowPlaying()
                            count == 0
                            break
                        }
                    }
                    self.motionArray.removeAll(keepCapacity: false)
                    
                    if self.musicPlayer.playbackState.rawValue == 1 {
                        self.nowPlaingView.playButton.setBackgroundImage(UIImage(named: "PauseIcon"), forState: .Normal)
                    } else if self.musicPlayer.playbackState.rawValue == 2 || self.musicPlayer.playbackState.rawValue == 0 {
                        self.nowPlaingView.playButton.setBackgroundImage(UIImage(named: "PlayIcon"), forState: .Normal)
                    }
                }
            })
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //Configure mainView
        self.mainView.songsButton.addTarget(self, action: "displaySongs:", forControlEvents: .TouchUpInside)
        self.mainView.artistsButton.addTarget(self, action: "displayArtists:", forControlEvents: .TouchUpInside)
        self.mainView.albumsButton.addTarget(self, action: "displayAlbums:", forControlEvents: .TouchUpInside)
        self.mainView.playlistButton.addTarget(self, action: "displayPlaylists:", forControlEvents: .TouchUpInside)
        self.mainView.voiceButton.addTarget(self, action: "displayVoice:", forControlEvents: .TouchUpInside)
        self.mainView.settingsButton.addTarget(self, action: "displaySettings:", forControlEvents: .TouchUpInside)
        
        //Configure now playing
        self.nowPlaingView.playButton.addTarget(self, action: "playPausePressed:", forControlEvents: .TouchUpInside)
        self.nowPlaingView.clipsToBounds = false
        self.nowPlaingView.layer.masksToBounds = false
        self.nowPlaingView.layer.shadowColor = UIColor.blackColor().CGColor
        self.nowPlaingView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.nowPlaingView.layer.shadowOpacity = 0.8
    }
    
    override func viewWillAppear(animated: Bool) {
        self.view.addSubview(self.nowPlaingView)
        self.nowPlaingView.removeConstraints(self.nowPlaingView.constraints())
        self.nowPlaingView.constrainUsing(constraints: [
            .LeftToLeft : (of: self.view, multiplier: 1.0, offset: 0),
            .TopToTop : (of: self.view, multiplier: 1.0, offset: 0),
            .RightToRight : (of: self.view, multiplier: 1.0, offset: 0),
            .Height : (of: nil, multiplier: 1.0, offset: 150)])
        if self.musicPlayer.playbackState != .Stopped {
            self.updateNowPlaying()
        }
    }
    
    func playPausePressed(sender: UIButton) {
        if self.musicPlayer.playbackState == MPMusicPlaybackState.Playing {
            self.musicPlayer.pause()
            self.updateNowPlaying()
        } else {
            self.musicPlayer.play()
            self.updateNowPlaying()
        }
    }
    
    func updateNowPlaying() {
        if self.musicPlayer.nowPlayingItem != nil {
            self.nowPlaingView.songArtworkImage.image = self.musicPlayer.nowPlayingItem.artwork.imageWithSize(CGSizeMake(100, 100))
            self.nowPlaingView.songTitleLabel.text = self.musicPlayer.nowPlayingItem.title
            self.nowPlaingView.songAlbumArtistLabel.text = "\(self.musicPlayer.nowPlayingItem.albumTitle) - \(self.musicPlayer.nowPlayingItem.artist)"
        }
    }
    
    func skipToNextTrack() {
        self.musicPlayer.skipToNextItem()
        self.updateNowPlaying()
    }
    
    func skipToPreviousTrack() {
        self.musicPlayer.skipToPreviousItem()
        self.updateNowPlaying()
    }
    
    func increaseVolume() {
        var mpVolume = MPVolumeView()
        
        if let view = mpVolume.subviews.first as? UISlider {
            view.value += 0.1
            print(view.value)
        }
    }
    
    func decreaseVolume() {
        var mpVolume = MPVolumeView()
        
        if let view = mpVolume.subviews.first as? UISlider {
            view.value -= 0.1
            print(view.value)
        }
    }
    
    func displaySongs(sender: UIButton) {
        var songs = [MPMediaItem]()
        for item in MPMediaQuery.songsQuery().items as! [MPMediaItem] {
            if !item.cloudItem {
                songs.append(item)
            }
        }
        
        let songsView = SongsCollectionView(collectionViewLayout: UICollectionViewFlowLayout())
        songsView.songs = songs
        songsView.parent = self
        songsView.nowPlayingView = self.nowPlaingView
        self.presentViewController(songsView, animated: true, completion: nil)
        
    }
    
    func displayArtists(sender: UIButton) {
        
        let artistsView = SongsCollectionView(collectionViewLayout: UICollectionViewFlowLayout())
        artistsView.contentType = .Artists
        artistsView.songs = MPMediaQuery.artistsQuery().collections as! [MPMediaItemCollection]
        artistsView.parent = self
        artistsView.nowPlayingView = self.nowPlaingView
        self.presentViewController(artistsView, animated: true, completion: nil)
    }
    
    func displayAlbums(sender: UIButton) {
        
        let albumsView = SongsCollectionView(collectionViewLayout: UICollectionViewFlowLayout())
        albumsView.contentType = .Albums
        albumsView.songs = MPMediaQuery.albumsQuery().collections as! [MPMediaItemCollection]
        albumsView.parent = self
        albumsView.nowPlayingView = self.nowPlaingView
        self.presentViewController(albumsView, animated: true, completion: nil)
    }
    
    func displayPlaylists(sender: UIButton) {
        for item in MPMediaQuery.playlistsQuery().collections {
            print((item as! MPMediaPlaylist).name)
            print("\n")
        }
        
        let albumsView = SongsCollectionView(collectionViewLayout: UICollectionViewFlowLayout())
        albumsView.contentType = .Playlists
        albumsView.songs = MPMediaQuery.playlistsQuery().collections as! [MPMediaPlaylist]
        albumsView.parent = self
        albumsView.nowPlayingView = self.nowPlaingView
        self.presentViewController(albumsView, animated: true, completion: nil)
        
    }
    
    func displayVoice(sender: UIButton) {
        
    }
    
    func displaySettings(sender: UIButton) {
        
    }
    
    func displayPausedBanner() {
        
    }

    func removePausedBanner() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        
    }
}