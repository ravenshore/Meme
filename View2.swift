//
//  View2.swift
//  meme
//
//  Created by Razvigor Andreev on 10/19/14.
//  Copyright (c) 2014 Razvigor Andreev. All rights reserved.
//

import UIKit

class View2: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate {

    @IBOutlet var frontButton: UIButton!
    @IBOutlet var backButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var newMemeField: UITextField!
    
    var focus: Int?
    var focusImage: UIImageView?
    var focusLabel: UILabel?
    var screenshot: UIImage?
    
    @IBOutlet var savedLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        var borderColor: UIColor = UIColor.whiteColor()
        var radius:CGFloat = 50
        
    imageView.layer.borderWidth = 0.5
    imageView.layer.borderColor = borderColor.CGColor
    imageView.layer.cornerRadius = radius
    imageView.clipsToBounds = true
    newMemeField.delegate = self
        
    }
    
    
   
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func textButtonPressed(sender: AnyObject) {
        
        // Put the add field above any other view
        newMemeField.layer.zPosition = 1;
        
        // Show it
        newMemeField.hidden = false
        
        // Brings keyboard
        newMemeField.becomeFirstResponder()
        
    }
    
    
    // When Return is detected -> add the new Label
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
    
    println("return detected")
    newMemeField.hidden = true
    newMemeField.resignFirstResponder()
    
    
    if let newMeme = newMemeField.text {
    addNewMeme(newMeme)
        }
    
    // Clean up the field
    newMemeField.text = ""
    
    
    return true;
        }

    
    @IBAction func imageButtonPressed(sender: AnyObject) {
        
        newMemeField.hidden = true
        newMemeField.resignFirstResponder()
        newMemeField.text = ""
        
        UIGestureRecognizerState.Began
        
        var imagePicker = UIImagePickerController()
        var sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            imagePicker.sourceType = sourceType
            
            imagePicker.delegate = self
            
            //        show a screen
            
            
            presentViewController(imagePicker, animated: true, completion: nil)
        }

        
        
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var x = CGFloat(arc4random_uniform(100)+50)
        var y = CGFloat(arc4random_uniform(100)+50)
        
        
        
        var image = info[UIImagePickerControllerOriginalImage] as UIImage
        var imageViewNew = UIImageView(frame: CGRectMake(100, 100, 150 , 150))
        
        
        imageViewNew.center = CGPoint(x: x, y: y)
        
        imageViewNew.image = image
        
        imageView.addSubview(imageViewNew)
        shadow(imageViewNew)
        
        imageViewNew.multipleTouchEnabled = true
        imageViewNew.userInteractionEnabled = true
        
        
        
        createPanGestureRecognizer(imageViewNew)
        createPinchGestureRecognizer(imageViewNew)
        createRotateGestureRecognizer(imageViewNew)
        
        
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    func createPinchGestureRecognizer(targetView:UIImageView) {
        
        let pinch = UIPinchGestureRecognizer(target: self, action: "handlePinch:")
        targetView.addGestureRecognizer(pinch)
        pinch.delegate = self
    }
    
    func handlePinch(sender:UIPinchGestureRecognizer) {
        
        sender.view!.transform = CGAffineTransformScale(sender.view!.transform,
            sender.scale, sender.scale)
        sender.scale = 1
        
        var label = sender.view as UIImageView
        if sender.state == UIGestureRecognizerState.Changed {
            hoverShadow(label)
        }
            
        else {
            
            shadow(label)
        }
    }

    func handlePinchText(sender:UIPinchGestureRecognizer) {
        
        sender.view!.transform = CGAffineTransformScale(sender.view!.transform,
            sender.scale, sender.scale)
        sender.scale = 1
        
        var label = sender.view as UILabel
        if sender.state == UIGestureRecognizerState.Changed {
            hoverShadowText(label)
        }
            
        else {
            
            shadowText(label)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        println("cancelled")
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    func createPanGestureRecognizer(targetView: UIImageView) {
        
        var panGesture = UIPanGestureRecognizer(target: self, action: ("handlePanGesture:"))
        targetView.addGestureRecognizer(panGesture)
        
        
        
    }
    
    
       func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        
        
        //        get translation
        
        var translation = panGesture.translationInView(view)
        panGesture.setTranslation(CGPointZero, inView: view)
        println(translation)
        
        var label = panGesture.view as UIImageView
        label.center = CGPoint(x: label.center.x+translation.x, y: label.center.y+translation.y)
        label.multipleTouchEnabled = true
        label.userInteractionEnabled = true
        
        if panGesture.state == UIGestureRecognizerState.Began {
            
            focus = 0
            focusImage = label
            showButtons()
            
        }
        
        if panGesture.state == UIGestureRecognizerState.Ended {
            
           
            
        }

        
        if panGesture.state == UIGestureRecognizerState.Changed {
            
         
        hoverShadow(label)
        }
        
        else {
            
            shadow(label)
        }
        
        }
    
    func handlePanGestureText(panGesture: UIPanGestureRecognizer) {
        
        
        //        get translation
        
        var translation = panGesture.translationInView(view)
        panGesture.setTranslation(CGPointZero, inView: view)
        println(translation)
        
        var label = panGesture.view as UILabel
        label.center = CGPoint(x: label.center.x+translation.x, y: label.center.y+translation.y)
        label.multipleTouchEnabled = true
        label.userInteractionEnabled = true
        
        
        if panGesture.state == UIGestureRecognizerState.Began {
            
        focus = 1
        focusLabel = label
        showButtons()
            
        }
        
        if panGesture.state == UIGestureRecognizerState.Ended {
            
            hideButtons()
        }
        

        
        if panGesture.state == UIGestureRecognizerState.Changed {
            hoverShadowText(label)
            
            
        }
            
        else {
            
            shadowText(label)
        }
        
    }
    
    
    func createRotateGestureRecognizer(targetView:UIImageView) {
        
        var rotateGesture = UIRotationGestureRecognizer(target: self, action: ("handleRotate:"))
        targetView.addGestureRecognizer(rotateGesture)
        rotateGesture.delegate = self
        
    }
    
    
        
        func handleRotate(recognizer : UIRotationGestureRecognizer) {
            recognizer.view!.transform = CGAffineTransformRotate(recognizer.view!.transform, recognizer.rotation)
            recognizer.rotation = 0
        var label = recognizer.view as UIImageView
            if recognizer.state == UIGestureRecognizerState.Changed {
                hoverShadow(label)
            }
                
            else {
                
                shadow(label)
            }
        
    }
    
    func handleRotateText(recognizer : UIRotationGestureRecognizer) {
        recognizer.view!.transform = CGAffineTransformRotate(recognizer.view!.transform, recognizer.rotation)
        recognizer.rotation = 0
       var label = recognizer.view as UILabel
        if recognizer.state == UIGestureRecognizerState.Changed {
            hoverShadowText(label)
        }
            
        else {
            
            shadowText(label)
        }
        
    }

    
    func gestureRecognizer(UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
            
            return true
    }
    
    
    
    
    func createPinchGestureRecognizerText(targetView:UILabel) {
        
        let pinch = UIPinchGestureRecognizer(target: self, action: "handlePinchText:")
        targetView.addGestureRecognizer(pinch)
        pinch.delegate = self
    }
    
 
    
    
   
    
    
    func createPanGestureRecognizerText(targetView: UILabel) {
        
        var panGesture = UIPanGestureRecognizer(target: self, action: ("handlePanGestureText:"))
        targetView.addGestureRecognizer(panGesture)
        
    }
    
  
    
    
    func createRotateGestureRecognizerText(targetView:UILabel) {
        
        var rotateGesture = UIRotationGestureRecognizer(target: self, action: ("handleRotateText:"))
        targetView.addGestureRecognizer(rotateGesture)
        rotateGesture.delegate = self
        
    }
    

    
    
    func addNewMeme(word: String) {
        
         println("adding a new word")
            let meme = UILabel()
            
            // Style and text
            meme.text = word
            meme.textAlignment = NSTextAlignment.Center
            
        
            meme.backgroundColor =  UIColor.blackColor()
            meme.font = UIFont.boldSystemFontOfSize(16)
            meme.textColor = UIColor.whiteColor()
            
            // Size
            meme.sizeToFit()
            // add space around ?
            var rect = meme.frame
            rect = CGRectInset(rect, -4, 0)
            meme.frame = rect
            
        
            imageView.addSubview(meme)
            meme.multipleTouchEnabled = true
            meme.userInteractionEnabled = true
        
            // center it
        meme.center = CGPoint(x: 150, y: 150 )
        
        
            createPanGestureRecognizerText(meme)
            createPinchGestureRecognizerText(meme)
            createRotateGestureRecognizerText(meme)

    }
    
    func shadow(image: UIImageView) {
        var layer = image.layer
        
        image.layer.shadowOffset = CGSize(width: 3, height: 3)
        image.layer.shadowOpacity = 0.7
        image.layer.shadowRadius = 2
        
    }
    
    func hoverShadow(image: UIImageView) {
        
        var layer = image.layer
        image.layer.shadowOffset = CGSize(width: 10, height: 20)
        image.layer.shadowOpacity = 0.3
        image.layer.shadowRadius = 6
    }
    
    func shadowText(text: UILabel) {
        var layer = text.layer
        
        text.layer.shadowOffset = CGSize(width: 3, height: 3)
        text.layer.shadowOpacity = 0.7
        text.layer.shadowRadius = 2
        
    }
    
    func hoverShadowText(text: UILabel) {
        
        var layer = text.layer
        text.layer.shadowOffset = CGSize(width: 10, height: 20)
        text.layer.shadowOpacity = 0.3
        text.layer.shadowRadius = 6
    }
    
    func takeScreenshot() {
        
        UIGraphicsBeginImageContext(imageView.bounds.size)
        self.imageView.layer.renderInContext(UIGraphicsGetCurrentContext())
        screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }
   

    @IBAction func save(sender: AnyObject) {
        
        takeScreenshot()
        UIImageWriteToSavedPhotosAlbum(screenshot!, nil, nil, nil)
        
        imageSavedMessage()
        
    }
    
    @IBAction func share(sender: UIButton) {
        
        takeScreenshot()
        
        let shareScreen:UIImage = screenshot!
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [shareScreen], applicationActivities: nil)
        let presentationController = activityViewController.popoverPresentationController
        presentationController?.sourceView = sender
        presentationController?.sourceRect = CGRect(origin: CGPointZero, size: CGSize(width: sender.frame.width, height: sender.frame.height))
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func back(sender: UIButton) {
        
        if focus! == 0 {
            
            println("back image")
            println("\(focusImage)")
            println("\(focus)")
            focusImage!.layer.zPosition = focusImage!.layer.zPosition - 1
            
        }
        
        if focus! == 1 {
            
            println("back text")
            println("\(focusLabel)")
            println("\(focus)")
            println("\(focusLabel!.layer.zPosition)")
            focusLabel!.layer.zPosition = focusLabel!.layer.zPosition - 1
            
        }
        
    }
   
    @IBAction func front(sender: UIButton) {
    
    
    if focus! == 0 {
    
    focusImage!.layer.zPosition = focusImage!.layer.zPosition + 1
    
    }
    
    if focus! == 1 {
    
    focusLabel!.layer.zPosition = focusLabel!.layer.zPosition + 1
    
    }

    }
    
    func delay(delay:Double, closure:()->()) {
        
        dispatch_after(
        dispatch_time( DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
        
        
    }
    
    func hideButtons() {
        
        
    
        delay(5) {
         
            self.frontButton.hidden = true
            self.backButton.hidden = true
            
        }
    
    
    }
    
    func imageSavedMessage() {
        
        savedLabel.hidden = false
        
        delay(2) {
        self.savedLabel.hidden = true
        }
    }
    
    func showButtons() {
        
        self.frontButton.hidden = false
        self.backButton.hidden = false
        
    }

}
