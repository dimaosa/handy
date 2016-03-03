//
//  ImageConfigurationModel.swift
//  handy
//
//  Created by Osadchy Dima on 3/3/16.
//  Copyright © 2016 Osadchy Dima. All rights reserved.
//

import Foundation
import UIKit

class ImageConfiguration {
    
    private(set) var userImage: UIImage?
    private(set) var skinImage: UIImage?
    
    var imageView = UIImageView()
    
    var finalImage: UIImage? {
        return createImage()
    }
    
    init(uImage: UIImage?, sImage: UIImage?) {
        userImage = uImage
        skinImage = sImage
    }
    
    func createImage() -> UIImage?{
        //1
        //create blury background image
        
        //        imageView.addSubview(blurView)
        imageView.addSubview(createBlur(.Light))
        
        
        //create internal image
        //combine all images
        
        return nil
    }
    
    func createBlur(style: UIBlurEffectStyle) -> UIVisualEffectView{
        let darkBlur = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: (userImage?.size)!)
        return blurView
    }
}