//
//  ViewController.swift
//  meme
//
//  Created by Razvigor Andreev on 10/19/14.
//  Copyright (c) 2014 Razvigor Andreev. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var meme1: UILabel!
    var meme2: UILabel!
    var boing = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bong", ofType: "wav")!)
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        
        meme1 = UILabel()
        meme2 = UILabel()
        flyMemes()
        playAudio(0.2)
        playAudio(1.15)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func flyMemes () {
        
        
        
        meme1.text = "Brace yourself!"
        meme1.font = UIFont.systemFontOfSize(25)
        meme1.textColor = UIColor.whiteColor()
        meme1.sizeToFit()
        meme1.center = CGPoint(x: 200, y: -50)
        view.addSubview(meme1)
        
        
        UIView.animateWithDuration(0.9, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.0, options: .CurveLinear, animations: {
            
            self.meme1.center = CGPoint(x: 200, y:50 )
            
            }, completion: nil)
       
        
        UIView.animateWithDuration(0.6, delay: 1.1, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.0, options: .CurveLinear, animations: {
            
            self.meme1.center = CGPoint(x: 200, y:150+90 )
            
            
            
            }, completion: nil)
        
        
        
        
        
        meme2.text = "Swift Coding is coming !"
        meme2.font = UIFont.boldSystemFontOfSize(30)
        meme2.textColor = UIColor.whiteColor()
        meme2.sizeToFit()
        meme2.center = CGPoint(x: 200, y: 150)
        view.addSubview(meme2)
        meme2.alpha = 0
        
        UIView.animateWithDuration(2, delay: 1.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: nil, animations: {
            
            
            self.meme2.center = CGPoint(x: 180, y: 180+90)
            self.meme2.alpha = 1
            
            }, completion: nil)
        
        
    }
    
    func delay(delay:Double, closure:()->()) {
        
        dispatch_after(
            dispatch_time( DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
        
        
    }
    
    
    
    func playAudio (time: Double) {
        
        delay(time) {
    
    self.audioPlayer = AVAudioPlayer(contentsOfURL: self.boing, error: nil)
    self.audioPlayer.prepareToPlay()
    self.audioPlayer.play()
        }
    }

}

