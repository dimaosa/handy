//
//  PhotoViewController.swift
//  handy
//
//  Created by Osadchy Dima on 3/2/16.
//  Copyright © 2016 Osadchy Dima. All rights reserved.
//

import UIKit

import Nuke

class PhotoViewController: UIViewController, UIScrollViewDelegate {

    
    var image: UIImage!
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    var sizeMainImageView: CGSize {
        return mainImageView.frame.size
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let Nexus4Hand = PhoneSkin(name: "Nexus4MenHand", size: CGSize(width: 375, height: 375), hand: UIImage(named: "handLGG4"), startPScale: (0.354, 0.384))
        
        NSLog("Nexus4Hand.sizeOfParentView = \(Nexus4Hand.sizeOfParentView)")
        NSLog("Size of UIScreen = \(UIScreen.mainScreen().bounds.size) ")
        //Background blur imageView with originalPhoto
        createBlurBackground(sizeMainImageView)

        //On Screen imageView with originalPhoto
        createOnScreenScrollView(Nexus4Hand)
        
        //Phone screen on
        createPhoneSkinImage(Nexus4Hand)
        
    }
    
    //MARK! - Imaage createion
    func createPhoneSkinImage(phoneInfo: PhoneSkin) {
        let phone = UIImageView()
        
        NSLog("mainImageView.bounds.size = \(mainImageView.bounds.size)")
        NSLog("mainImageView.frame.size = \(mainImageView.frame.size)")

        
        phone.image = phoneInfo.handImage
        phone.contentMode = .ScaleAspectFill
        phone.frame = CGRectMake(
            0,
            0,
            UIScreen.mainScreen().bounds.size.width,
            UIScreen.mainScreen().bounds.size.width
        )
        mainImageView.addSubview(phone)
    }
    
    func createBlurBackground(size: CGSize) {
        let bckgrndImgViw = UIImageView()
        bckgrndImgViw.image = image
        bckgrndImgViw.contentMode = .ScaleAspectFill
        bckgrndImgViw.frame = CGRectMake(
            0,
            0,
            UIScreen.mainScreen().bounds.size.width + 10,
            UIScreen.mainScreen().bounds.size.width + 10
        )
        //let blurEffect = UIBlurEffect(style: .Light)
        //let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        //always fill the view
        //blurEffectView.frame = CGRectMake(
//            0,
//            0,
//            UIScreen.mainScreen().bounds.size.width + 10,
//            UIScreen.mainScreen().bounds.size.width + 10
//        )
        //blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        //bckgrndImgViw.addSubview(blurEffectView)
        
        
        bckgrndImgViw.clipsToBounds = true
        mainImageView.addSubview(bckgrndImgViw)
    }
    
    
    var onScreenImgViw: UIImageView!
    var scrollView: UIScrollView!
    func createOnScreenScrollView(phoneInfo: PhoneSkin) {
        onScreenImgViw = UIImageView(image: image)
        onScreenImgViw.sizeToFit()
        print("---------phoneInfo.startPoint = \(phoneInfo.startPoint)")
        scrollView = UIScrollView(frame: CGRectMake(
            phoneInfo.startPoint.x + mainImageView.frame.origin.x,
            phoneInfo.startPoint.y + mainImageView.frame.origin.y,
            phoneInfo.screenSize.width,
            phoneInfo.screenSize.height
            )
        )
        scrollView.delegate = self
        
        scrollView.backgroundColor = UIColor.blackColor()
        scrollView.contentSize = onScreenImgViw.frame.size
        scrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight ]
        
        scrollView.addSubview(onScreenImgViw)
        view.addSubview(scrollView)
        
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        super.viewWillAppear(animated)
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
