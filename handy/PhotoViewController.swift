//
//  PhotoViewController.swift
//  handy
//
//  Created by Osadchy Dima on 3/2/16.
//  Copyright © 2016 Osadchy Dima. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {
    
    
    //TODO: Change this! should be some sort of JSON, and every entity should have it's own onScreen properties
    //create images
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
        
        
        //TODO! Create class which will return imageView property with Ready image
        
        
        //
        createFiltersScrollMenu()
        
        
        //TODO! Every entity should have such property
        let Nexus4Hand = PhoneSkin(name: "Nexus4MenHand", size: CGSize(width: 375, height: 375), hand: UIImage(named: "handLGG4"), contextScreenSize: CGRectMake(0.354, 0.384, 0.573, 0.776))
        
        
        NSLog("Nexus4Hand.sizeOfParentView = \(Nexus4Hand.sizeOfParentView)")
        NSLog("Size of UIScreen = \(UIScreen.mainScreen().bounds.size) ")
        
        let someImageVIewWithSizeOfUIScreenWidth = mainImageView
        someImageVIewWithSizeOfUIScreenWidth.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.width)
        
        let filterMainImageView = FilterImage(imgView: someImageVIewWithSizeOfUIScreenWidth, image: image, phoneHand: Nexus4Hand)
         mainImageView = filterMainImageView.filterImageView
//        //Background blur imageView with originalPhoto
//        createBlurBackground(sizeMainImageView)
//
//        //On Screen imageView with originalPhoto
//        //createOnScreenScrollView(Nexus4Hand)
//        
//        //Phone screen on
//        createPhoneSkinImage(Nexus4Hand)
//        
//        //TODO! Make all generics as possible
        
    }
    
//    //MARK! - Imaage createion
//    func createPhoneSkinImage(phoneInfo: PhoneSkin) {
//        let phone = UIImageView()
//        
//        NSLog("mainImageView.bounds.size = \(mainImageView.bounds.size)")
//        NSLog("mainImageView.frame.size = \(mainImageView.frame.size)")
//
//        
//        phone.image = phoneInfo.handImage
//        phone.contentMode = .ScaleAspectFill
//        phone.userInteractionEnabled = true
//        phone.frame = CGRectMake(
//            0,
//            0,
//            UIScreen.mainScreen().bounds.size.width,  // should not be here
//            UIScreen.mainScreen().bounds.size.width   // should not be here
//        )
//        phone.addSubview(createOnScreenScrollView(phone, phoneInfo: phoneInfo))
//        mainImageView.addSubview(phone)
//    }
//    
//    func createBlurBackground(size: CGSize) {
//        
//        let bckgrndImgViw = UIImageView()
//        bckgrndImgViw.contentMode = .ScaleAspectFill
//        bckgrndImgViw.clipsToBounds = true
//        bckgrndImgViw.frame = CGRectMake(
//            0,
//            0,
//            UIScreen.mainScreen().bounds.size.width,
//            UIScreen.mainScreen().bounds.size.width
//        )
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { () in
//           
//            let bluredImage = blurredImageWithImage(
//                ImageUtil.cropToSquare(
//                    image: self.image, contextSize: CGSize(
//                        width: UIScreen.mainScreen().bounds.width,
//                        height: UIScreen.mainScreen().bounds.width
//                    )
//                )
//            )
//            dispatch_async(dispatch_get_main_queue(), {
//                bckgrndImgViw.image = bluredImage
//            })
//        }
//        self.mainImageView.insertSubview(bckgrndImgViw, atIndex: 0)
//        
//    }
//    
//    
//    
//    
//    //TODO! change THIS!
//    var onScreenImgViw: UIImageView!
//    var scrollView: UIScrollView!
//    
//    func createOnScreenScrollView(parentView: UIView, phoneInfo: PhoneSkin) -> UIScrollView{
//        onScreenImgViw = UIImageView(image: image)
//        onScreenImgViw.sizeToFit()
//        print("---------phoneInfo.startPoint = \(phoneInfo.startPoint)")
//        scrollView = UIScrollView(frame: CGRectMake(
//            phoneInfo.startPoint.x + parentView.frame.origin.x,
//            phoneInfo.startPoint.y + parentView.frame.origin.y,
//            phoneInfo.screenSize.width,
//            phoneInfo.screenSize.height
//            )
//        )
//        scrollView.delegate = self
//        
//        scrollView.backgroundColor = UIColor.blackColor()
//        scrollView.contentSize = onScreenImgViw.frame.size
//        scrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight ]
//        
//        scrollView.addSubview(onScreenImgViw)
//        return scrollView
//        
//    }
//    override func viewWillAppear(animated: Bool) {
//        
//        //properties of window
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
//        super.viewWillAppear(animated)
//    }
//    
//    //MARK! - scrollView Zoom
//    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
//        return onScreenImgViw
//    }
//    override func viewWillLayoutSubviews() {
//        setZoomScale()
//    }
//    func setZoomScale() {
//        let imageViewSize = onScreenImgViw.bounds.size
//        let scrollViewSize = scrollView.bounds.size
//        let widthScale = scrollViewSize.width / imageViewSize.width
//        let heightScale = scrollViewSize.height / imageViewSize.height
//        
//        scrollView.minimumZoomScale = min(widthScale, heightScale)
//        scrollView.zoomScale = heightScale
//        print( imageViewSize, scrollViewSize, imageViewSize.width / 2 - scrollViewSize.width / 2)
//        print(scrollView.contentSize)
//        scrollView.contentOffset = CGPoint(
//            x: scrollView.contentSize.width / 2 - scrollViewSize.width / 2,
//            y: 0.0)
//        
//    }
//    func scrollViewDidZoom(scrollView: UIScrollView) {
//        let imageViewSize = onScreenImgViw.frame.size
//        let scrollViewSize = scrollView.bounds.size
//        
//        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
//        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
//        
//        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
//        
//    }
    
    
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
        let button = UIButton(frame: CGRectMake(x, 0, bWidthHeight, bWidthHeight))
        button.userInteractionEnabled = true
        
        let someImgVi = UIImageView(frame: button.frame)
        let Nexus4Hand = PhoneSkin(name: "Nexus4MenHand", size: CGSize(width: 375, height: 375), hand: UIImage(named: "handLGG4"), contextScreenSize: CGRectMake(0.354, 0.384, 0.573, 0.776))
        
        button.setImage(UIImage.imageWithView( FilterImage(imgView: someImgVi, image: image, phoneHand: Nexus4Hand).filterImageView), forState: .Normal)

        
        filtersScrollView.addSubview(button)
        
        x += bWidthHeight + constShift;
        
        filtersScrollView.contentSize = CGSizeMake(x, bWidthHeight);
        filtersScrollView.backgroundColor = UIColor.whiteColor()
    }
}
