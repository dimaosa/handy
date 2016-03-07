//
//  PhotoViewController.swift
//  handy
//
//  Created by Osadchy Dima on 3/2/16.
//  Copyright © 2016 Osadchy Dima. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {

    @IBAction func doneButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            NSLog("Get the fuck ou of here")
        }
    }
    
    var image: UIImage!
    
    private struct Constants{
        struct Screen {
            static let screen = UIScreen.mainScreen().bounds.size
        }
        
        struct HandNexus4 {
            static let startPoint = CGPoint(
                x: Screen.screen.width * 0.241,
                y: Screen.screen.height * 0.29
            )
            static let screenSize = CGSize(
                width: Screen.screen.width * 0.785 - startPoint.x,
                height: Screen.screen.height * 0.70 - startPoint.y)
            static let screenPoints = [
                CGPoint(x: startPoint.x, y: startPoint.y),
                CGPoint(x: startPoint.x + 50, y: startPoint.y),
                CGPoint(x: startPoint.x + 50, y: startPoint.y + 50),
                CGPoint(x: startPoint.x, y: startPoint.y + 50)
            ]
        }
        struct Hand {
            static let image = UIImage(named: "cam")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Background blur imageView with originalPhoto
        createBlurBackground()
        
        //On Screen imageView with originalPhoto
        createOnScreenScrollView()
        
        //Phone screen on
        createPhoneSkinImage()
        
    }
    
    //MARK! - Imaage createion
    func createPhoneSkinImage() {
        let phone = UIImageView()
        phone.image = Constants.Hand.image
        phone.contentMode = .ScaleAspectFill
        phone.frame = CGRectMake(
            0,
            0,
            Constants.Screen.screen.width,
            Constants.Screen.screen.height
        )
        self.view.addSubview(phone)
    }
    
    func createBlurBackground() {
        let bckgrndImgViw = UIImageView()
        bckgrndImgViw.image = image
        bckgrndImgViw.contentMode = .ScaleAspectFill
        bckgrndImgViw.frame = CGRectMake(
            0,
            0,
            Constants.Screen.screen.width,
            Constants.Screen.screen.height
        )
        let blurEffect = UIBlurEffect(style: .Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        //always fill the view
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        bckgrndImgViw.addSubview(blurEffectView)
        self.view.addSubview(bckgrndImgViw)
    }
    
    
    var onScreenImgViw: UIImageView!
    var scrollView: UIScrollView!
    func createOnScreenScrollView() {
        onScreenImgViw = UIImageView(image: image)
        onScreenImgViw.sizeToFit()
        
        scrollView = UIScrollView(frame: CGRectMake(
            Constants.HandNexus4.startPoint.x,
            Constants.HandNexus4.startPoint.y,
            Constants.HandNexus4.screenSize.width,
            Constants.HandNexus4.screenSize.height
            )
        )
        scrollView.delegate = self
        
        scrollView.backgroundColor = UIColor.blackColor()
        scrollView.contentSize = onScreenImgViw.frame.size
        scrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight ]
        
        scrollView.addSubview(onScreenImgViw)
        view.addSubview(scrollView)
        
    }
    
    //MARK! - scrollView Zoom
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return onScreenImgViw
    }
    override func viewWillLayoutSubviews() {
        setZoomScale()
    }
    func setZoomScale() {
        let imageViewSize = onScreenImgViw.bounds.size
        let scrollViewSize = scrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        scrollView.minimumZoomScale = min(widthScale, heightScale)
        scrollView.zoomScale = heightScale
        print( imageViewSize, scrollViewSize, imageViewSize.width / 2 - scrollViewSize.width / 2)
        print(scrollView.contentSize)
        scrollView.contentOffset = CGPoint(
            x: scrollView.contentSize.width / 2 - scrollViewSize.width / 2,
            y: 0.0)
        
    }
    func scrollViewDidZoom(scrollView: UIScrollView) {
        let imageViewSize = onScreenImgViw.frame.size
        let scrollViewSize = scrollView.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
        
    }
}
