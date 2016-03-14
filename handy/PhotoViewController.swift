//
//  PhotoViewController.swift
//  handy
//
//  Created by Osadchy Dima on 3/2/16.
//  Copyright © 2016 Osadchy Dima. All rights reserved.
//

import UIKit
import GPUImage
import Nuke

class PhotoViewController: UIViewController, UIScrollViewDelegate {
    
    
    let FiterImagesNames = ["picGreen", "picMountain", "picRelax", "picSnowRail", "picSkiWhite"]
    
    @IBOutlet var filtersScrollView: UIScrollView!

    @IBAction func saveImageBarButton(sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(UIImage.imageWithView(mainImageView), nil, nil, nil);
        NSLog("Image is saved to library!")
        let alertVC = UIAlertController(
            title: "Image is saved to library!",
            message: "Take a look in your Photo Library",
            preferredStyle: .Alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.Default,
            handler: nil)
        alertVC.addAction(okAction)
        presentViewController(alertVC,
            animated: true,
            completion: nil)
    }
    
    var image: UIImage!
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    var sizeMainImageView: CGSize {
        return mainImageView.frame.size
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createFiltersScrollMenu()
        
        let Nexus4Hand = PhoneSkin(name: "Nexus4MenHand", size: CGSize(width: 375, height: 375), hand: UIImage(named: "handLGG4"), contextScreenSize: CGRectMake(0.354, 0.384, 0.573, 0.776))
        
        
        NSLog("Nexus4Hand.sizeOfParentView = \(Nexus4Hand.sizeOfParentView)")
        NSLog("Size of UIScreen = \(UIScreen.mainScreen().bounds.size) ")
        //Background blur imageView with originalPhoto
        createBlurBackground(sizeMainImageView)

        //On Screen imageView with originalPhoto
        //createOnScreenScrollView(Nexus4Hand)
        
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
        phone.userInteractionEnabled = true
        phone.frame = CGRectMake(
            0,
            0,
            UIScreen.mainScreen().bounds.size.width,
            UIScreen.mainScreen().bounds.size.width
        )
        phone.addSubview(createOnScreenScrollView(phone, phoneInfo: phoneInfo))
        mainImageView.addSubview(phone)
    }
    
    func createBlurBackground(size: CGSize) {
        
        let bckgrndImgViw = UIImageView()
        bckgrndImgViw.contentMode = .ScaleAspectFill
        bckgrndImgViw.clipsToBounds = true
        bckgrndImgViw.frame = CGRectMake(
            0,
            0,
            UIScreen.mainScreen().bounds.size.width,
            UIScreen.mainScreen().bounds.size.width
        )
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
           
            bckgrndImgViw.image = blurredImageWithImage(
                ImageUtil.cropToSquare(
                    image: self.image, contextSize: CGSize(
                        width: UIScreen.mainScreen().bounds.width,
                        height: UIScreen.mainScreen().bounds.width
                    )
                )
                
            )
//            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                self.mainImageView.insertSubview(bckgrndImgViw, atIndex: 0)
//            })
        }

//        let blurView = GPUImageView(frame: CGRectMake(0,0, UIScreen.mainScreen().bounds.size.width,UIScreen.mainScreen().bounds.size.width))
//        blurView.contentMode = .ScaleToFill
//        blurView.clipsToBounds = true
//        blurView.layer.contentsGravity = kCAGravityTop
//        
//        let blurFilter = GPUImageiOSBlurFilter()
//        
//        
//        blurFilter.blurRadiusInPixels = 4.0
//        
//        
//        let picture = GPUImagePicture(image: image)
//        picture.addTarget(blurFilter)
//        blurFilter.addTarget(blurView)
//        
//        dispatch_async(dispatch_get_main_queue()) { () -> Void in
//            picture.forceProcessingAtSize(self.sizeMainImageView)
//
//            bckgrndImgViw.clipsToBounds = true
//            self.mainImageView.addSubview(blurView)
//        }
        
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
        
        
    }
    
    
    var onScreenImgViw: UIImageView!
    var scrollView: UIScrollView!
    func createOnScreenScrollView(parentView: UIView, phoneInfo: PhoneSkin) -> UIScrollView{
        onScreenImgViw = UIImageView(image: image)
        onScreenImgViw.sizeToFit()
        print("---------phoneInfo.startPoint = \(phoneInfo.startPoint)")
        scrollView = UIScrollView(frame: CGRectMake(
            phoneInfo.startPoint.x + parentView.frame.origin.x,
            phoneInfo.startPoint.y + parentView.frame.origin.y,
            phoneInfo.screenSize.width,
            phoneInfo.screenSize.height
            )
        )
        scrollView.delegate = self
        
        scrollView.backgroundColor = UIColor.blackColor()
        scrollView.contentSize = onScreenImgViw.frame.size
        scrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight ]
        
        scrollView.addSubview(onScreenImgViw)
        return scrollView
        //mainImageView.addSubview(scrollView)
        
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
    
    func createFiltersScrollMenu() {
        filtersScrollView.userInteractionEnabled = true
        filtersScrollView.showsHorizontalScrollIndicator = false
        let bWidthHeight = filtersScrollView.frame.size.height
        let constShift:CGFloat = 8
        var x: CGFloat = 0 + constShift //initial x coordinate of a filter button in frames scroll View

        for image in FiterImagesNames {
            let button = UIButton(frame: CGRectMake(x, 0, bWidthHeight, bWidthHeight))
            button.userInteractionEnabled = true
            button.setImage(UIImage(named: image), forState: .Normal)
            
            filtersScrollView.addSubview(button)
            
            x += bWidthHeight + constShift;
        }
        
        filtersScrollView.contentSize = CGSizeMake(x, bWidthHeight);
        filtersScrollView.backgroundColor = UIColor.whiteColor()
    }
}
