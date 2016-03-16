//
//  FilterImage.swift
//  handy
//
//  Created by Osadchy Dima on 3/16/16.
//  Copyright © 2016 Osadchy Dima. All rights reserved.
//

import Foundation
import UIKit

class FilterImage : NSObject, UIScrollViewDelegate{
    
    var filterImageView: UIImageView!
    var originalImage: UIImage!
    var phoneSkin: PhoneSkin!
    
    init(imgView: UIImageView, image: UIImage, phoneHand: PhoneSkin){
        super.init()
        filterImageView = imgView
        originalImage = image
        phoneSkin = phoneHand
        //Background blur imageView with originalPhoto
        
        filterImageView.addSubview(createBlurBackground())
        filterImageView.addSubview(self.createPhoneSkinImage())
        
        setZoomScale()
    }
    
    
    //MARK! - Image creation
    internal func createBlurBackground() -> UIImageView {
        
        let bckgrndImgViw = UIImageView()
        bckgrndImgViw.contentMode = .ScaleAspectFill
        bckgrndImgViw.clipsToBounds = true
        bckgrndImgViw.frame = CGRectMake(
            0,
            0,
            filterImageView!.bounds.width,
            filterImageView.bounds.height
        )
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let bluredImage = blurredImageWithImage(
                ImageUtil.cropToSquare(
                    image: self.originalImage, contextSize: CGSize(
                        width: self.filterImageView!.bounds.width,
                        height: self.filterImageView!.bounds.height))
            )
            dispatch_async(dispatch_get_main_queue()) {
                bckgrndImgViw.image = bluredImage
            }
        }
        return bckgrndImgViw
        
    }
    
    internal func createPhoneSkinImage() -> UIImageView {
        let phone = UIImageView()
        
        phone.image = phoneSkin.handImage
        phone.contentMode = .ScaleAspectFill
        phone.userInteractionEnabled = true
        phone.frame = CGRectMake(
            0,
            0,
            filterImageView!.bounds.width,
            filterImageView!.bounds.height
        )
        phone.addSubview(createOnScreenScrollView(phone, phoneInfo: phoneSkin))
        return phone
    }
    
    //TODO! change THIS!
    var onScreenImgViw: UIImageView!
    var scrollView: UIScrollView!
    
    func createOnScreenScrollView(parentView: UIView, phoneInfo: PhoneSkin) -> UIScrollView{
        onScreenImgViw = UIImageView(image: originalImage)
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
        
    }

    //MARK! - scrollView Zoom
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return onScreenImgViw
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