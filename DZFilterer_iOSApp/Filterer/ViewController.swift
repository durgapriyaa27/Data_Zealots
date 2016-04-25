//
//  ViewController.swift
//  Filterer
//
//  Created by Jack on 2015-09-22.
//  Copyright © 2015 UofT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var image = UIImage(named: "colbert")!
    var filteredImage: UIImage?
    
    var currentFilter:String = "default"
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet var bottomMenu: UIView!
    
    @IBOutlet var filterButton: UIButton!
    
    @IBOutlet weak var compareButton: UIButton!
    
    @IBOutlet var originalTitle: UIView!

    @IBOutlet var crossOverImage: UIImageView!
    
    @IBOutlet var sliderView: UIView!
    
    @IBOutlet weak var editButton: UIButton!
    
    
    @IBAction func sliderValueChange(sender: UISlider) {
        let value =  Float32(sender.value)
        var rgbaImage = RGBAImage(image: image)!
        
        switch (currentFilter) {
        case "Red":
            print("Red")
            for y in 0..<rgbaImage.height {
                for x in 0..<rgbaImage.width {
                    
                    let index = y * rgbaImage.width + x
                    var pixel = rgbaImage.pixels[index]
                    let red: Float = Float(pixel.red) * value
                    let green: Float = 0
                    let blue: Float = 0
                    
                    pixel.red = UInt8(red)
                    pixel.green = UInt8(green)
                    pixel.blue = UInt8(blue)
                    
                    rgbaImage.pixels[index] = pixel;
                }
            }
            filteredImage = rgbaImage.toUIImage()
            //showfilteredImage()
            showImageViewFilteredImage()
        case "Green":
            print ("Green")
            for y in 0..<rgbaImage.height {
                for x in 0..<rgbaImage.width {
                    
                    let index = y * rgbaImage.width + x
                    var pixel = rgbaImage.pixels[index]
                    let red: Float = 0
                    let green: Float = Float(pixel.green) * value
                    let blue: Float = 0
                    
                    pixel.red = UInt8(red)
                    pixel.green = UInt8(green)
                    pixel.blue = UInt8(blue)
                    
                    rgbaImage.pixels[index] = pixel;
                }
            }
            filteredImage = rgbaImage.toUIImage()
            //showfilteredImage()
            showImageViewFilteredImage()
        case "Blue":
            print ("Blue")
            for y in 0..<rgbaImage.height {
                for x in 0..<rgbaImage.width {
                    
                    let index = y * rgbaImage.width + x
                    var pixel = rgbaImage.pixels[index]
                    let red: Float = 0
                    let green: Float = 0
                    let blue: Float = Float(pixel.blue) * value
                    
                    pixel.red = UInt8(red)
                    pixel.green = UInt8(green)
                    pixel.blue = UInt8(blue)
                    
                    rgbaImage.pixels[index] = pixel;
                }
            }
            filteredImage = rgbaImage.toUIImage()

            showImageViewFilteredImage()
        case "Brightness":
            for y in 0..<rgbaImage.height {
                for x in 0..<rgbaImage.width {
                    let index = y * rgbaImage.width + x
                    var pixel = rgbaImage.pixels[index]
                    let red: Float = Float(pixel.red)*value
                    let green: Float = Float(pixel.green)*value
                    let blue: Float = Float(pixel.blue)*value
                    
                    pixel.red = UInt8(red)
                    pixel.green = UInt8(green)
                    pixel.blue = UInt8(blue)
                    
                    rgbaImage.pixels[index] = pixel;
                    
                }
            }
            filteredImage = rgbaImage.toUIImage()
            showImageViewFilteredImage()
        case "Contrast":
            for y in 0..<rgbaImage.height {
                for x in 0..<rgbaImage.width {
                    let index = y * rgbaImage.width + x
                    var pixel = rgbaImage.pixels[index]
                    let factor = (259 * ((value*100) + 255)) / (255 * (259 - (value*100)))
                    
                    pixel.red = truncate(Float(factor)*(Float(pixel.red) - 128) + 128)
                    pixel.green = truncate(Float(factor)*(Float(pixel.green) - 128) + 128)
                    pixel.blue = truncate(Float(factor)*(Float(pixel.blue) - 128) + 128)
                    
                    rgbaImage.pixels[index] = pixel;
                    
                }
            }
            filteredImage = rgbaImage.toUIImage()
            showImageViewFilteredImage()
        default:
            showImage()
            
            
        }
    }
    
    
    
    @IBAction func onEdit(sender: UIButton) {
        if (sender.selected) {
            sender.selected = false
            hideSliderView()
            //hideSecondaryMenu()
            //showSliderView()
            
            
        } else {
            hideSecondaryMenu()
            //hideSliderView()
            showSliderView()
            sender.selected = true
        }
    }
    
    func showSliderView(){
        view.addSubview(sliderView)
        sliderView.translatesAutoresizingMaskIntoConstraints = false

        let leftConstraint = sliderView.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = sliderView.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let bottomConstraint = sliderView.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        
        NSLayoutConstraint.activateConstraints([leftConstraint,rightConstraint,bottomConstraint])
        
        view.layoutIfNeeded()
        self.sliderView.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.sliderView.alpha = 1.0
        }
    }
    
    func hideSliderView(){
        UIView.animateWithDuration(0.4, animations: {
            self.sliderView.alpha = 0
        }) { completed in
            if completed == true {
                self.sliderView.removeFromSuperview()
            }
        }
    }
    
    @IBAction func compareImage(sender: UIButton) {
        if (sender.selected) {
            sender.selected = false
            showfilteredImage()
            
        } else {
            sender.selected = true
            showImage()
        }
    }
    
    
    @IBAction func redFilter(sender: AnyObject) {
        var rgbaImage = RGBAImage(image: image)!
        
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                var pixel = rgbaImage.pixels[index]
                let red: Float = Float(pixel.red)*0.5
                let green: Float = 0
                let blue: Float = 0
                
                pixel.red = UInt8(red)
                pixel.green = UInt8(green)
                pixel.blue = UInt8(blue)
                
                rgbaImage.pixels[index] = pixel;
                
            }
        }
        filteredImage = rgbaImage.toUIImage()
        showfilteredImage()
        currentFilter = "Red"
    }
    
    
    @IBAction func greenFilter(sender: AnyObject) {
        var rgbaImage = RGBAImage(image: image)!
        //let avgGreen = 109
        
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                var pixel = rgbaImage.pixels[index]
                let red: Float = 0
                let green: Float = Float(pixel.green)*0.5
                let blue: Float = 0
                
                pixel.red = UInt8(red)
                pixel.green = UInt8(green)
                pixel.blue = UInt8(blue)
                
                rgbaImage.pixels[index] = pixel;

            }
        }
        filteredImage = rgbaImage.toUIImage()
        showfilteredImage()
        currentFilter = "Green"
    }
    
    
    @IBAction func blueFilter(sender: AnyObject) {
        var rgbaImage = RGBAImage(image: image)!
        //let avgBlue = 110
        
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                var pixel = rgbaImage.pixels[index]
                let red: Float = 0
                let green: Float = 0
                let blue: Float = Float(pixel.blue)*0.5
                
                pixel.red = UInt8(red)
                pixel.green = UInt8(green)
                pixel.blue = UInt8(blue)
                
                rgbaImage.pixels[index] = pixel;

            }
        }
        filteredImage = rgbaImage.toUIImage()
        showfilteredImage()
        currentFilter = "Blue"
    }
    
    @IBAction func brightnessFilter(sender: UIButton) {
            var rgbaImage = RGBAImage(image: image)!

            
            for y in 0..<rgbaImage.height {
                for x in 0..<rgbaImage.width {
                    let index = y * rgbaImage.width + x
                    var pixel = rgbaImage.pixels[index]
                    let red: Float = Float(pixel.red)*0.5
                    let green: Float = Float(pixel.green)*0.5
                    let blue: Float = Float(pixel.blue)*0.5
                    
                    pixel.red = UInt8(red)
                    pixel.green = UInt8(green)
                    pixel.blue = UInt8(blue)
                    
                    rgbaImage.pixels[index] = pixel;
                    
                }
            }
            filteredImage = rgbaImage.toUIImage()
            showfilteredImage()
            currentFilter = "Brightness"
    }
    
    
    
    @IBAction func contrastFilter(sender: UIButton) {
        var rgbaImage = RGBAImage(image: image)!
        
        
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                var pixel = rgbaImage.pixels[index]
                let factor = (259 * ((0.5*100) + 255)) / (255 * (259 - (0.5*100)))
                
                pixel.red = truncate(Float(factor)*(Float(pixel.red) - 128) + 128)
                pixel.green = truncate(Float(factor)*(Float(pixel.green) - 128) + 128)
                pixel.blue = truncate(Float(factor)*(Float(pixel.blue) - 128) + 128)

                rgbaImage.pixels[index] = pixel;
                
            }
        }
        filteredImage = rgbaImage.toUIImage()
        showfilteredImage()
        currentFilter = "Contrast"
        
    }
    
    func truncate(value: Float) -> UInt8{
        return UInt8(max( min(255, value), 0))
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        compareButton.enabled = false
        editButton.enabled = false
        let tapGestureRecognizer = UILongPressGestureRecognizer(target:self, action:#selector(ViewController.toggleImage(_:)))
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        originalTitle.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
    }
    
    func toggleImage(sender: UILongPressGestureRecognizer) {
        if sender.state == .Began {
            showImage()
        }
        else if sender.state == .Ended {
            showfilteredImage()
        }
    }
    
    // MARK: Share
    @IBAction func onShare(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: ["Check out our really cool app", imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    // MARK: New Photo
    @IBAction func onNewPhoto(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image1 = info[UIImagePickerControllerOriginalImage] as? UIImage {
            image = image1
            showImage()
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Filter Menu
    @IBAction func onFilter(sender: UIButton) {
        if (sender.selected) {
            hideSliderView()
            hideSecondaryMenu()
            editButton.enabled = false
            compareButton.enabled = false
            sender.selected = false
            showImage()
            
        } else {
            hideSliderView()
            showSecondaryMenu()
            editButton.enabled = true
            compareButton.enabled = true
            sender.selected = true
            showImage()
        }
    }
    
    func showSecondaryMenu() {
        hideSliderView()
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.secondaryMenu.alpha = 1.0
        }
    }

    func hideSecondaryMenu() {
        UIView.animateWithDuration(0.4, animations: {
            self.secondaryMenu.alpha = 0
            }) { completed in
                if completed == true {
                    self.secondaryMenu.removeFromSuperview()
                }
        }
    }
    
    func showSecondaryMenuFast() {
        hideSliderView()
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
    }
    
    func showImage() {
        showOriginal()
        hideCrossOver()
        imageView.image = image
    }
    
    func showfilteredImage() {
        hideOriginal()
        crossOverImage.image = filteredImage
        showCrossOver()

    }
    
    func showImageViewFilteredImage() {
        hideCrossOver()
        hideOriginal()
        imageView.image = filteredImage
    }
    
    func showOriginal(){
        view.addSubview(originalTitle)
        originalTitle.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = originalTitle.topAnchor.constraintEqualToAnchor(imageView.topAnchor)
        let leftConstraint = originalTitle.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = originalTitle.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        NSLayoutConstraint.activateConstraints([topConstraint, leftConstraint, rightConstraint])
        view.layoutIfNeeded()
        
        self.originalTitle.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.originalTitle.alpha = 1.0
        }
    }
    
    func hideOriginal(){
        UIView.animateWithDuration(0.4, animations: {
            self.originalTitle.alpha = 0 }) {
                    completed in
                if completed == true {
                    self.originalTitle.removeFromSuperview()
                }
        }
    }
    
    func showCrossOver(){
        view.addSubview(crossOverImage)
        crossOverImage.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = crossOverImage.topAnchor.constraintEqualToAnchor(imageView.topAnchor)
        let leftConstraint = crossOverImage.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = crossOverImage.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let bottomConstraint = crossOverImage.bottomAnchor.constraintEqualToAnchor(imageView.bottomAnchor)
        
        NSLayoutConstraint.activateConstraints([topConstraint,leftConstraint,rightConstraint,bottomConstraint])
        
        view.layoutIfNeeded()
        showSecondaryMenuFast()
        self.crossOverImage.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.crossOverImage.alpha = 1.0
        }
    }
    
    func hideCrossOver() {
        UIView.animateWithDuration(0.4, animations: {
            self.crossOverImage.alpha = 0 }) {
                completed in
                if completed == true {
                    self.crossOverImage.removeFromSuperview()
                }
        }
    }

}





