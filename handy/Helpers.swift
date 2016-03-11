//
//  Helpers.swift
//  handy
//
//  Created by Osadchy Dima on 3/9/16.
//  Copyright © 2016 Osadchy Dima. All rights reserved.
//

import Foundation
import UIKit
import CoreImage

private var CIGAUSSIANBLUR: String {
    return "CIGaussianBlur"
}

class Context: CIContext {
    static let sharedInstance = Context()
    private override init(){ super.init() }
}

let context = Context()

func blurredImageWithImage(sourceImage: UIImage?) -> UIImage? {

    //create our blurred image
    let inputImage = CIImage(image: sourceImage!)
    
    
    //setting up gaussian blur
    let filter = CIFilter(name: CIGAUSSIANBLUR)
    filter?.setValue(inputImage, forKey: kCIInputImageKey)
    filter?.setValue(Float(2.0), forKey: "inputRadius")
    let result = filter?.valueForKey(kCIOutputImageKey) as! CIImage
    
    let cgImage = context.createCGImage(result, fromRect: (inputImage?.extent)!)
    let retVal = UIImage(CGImage: cgImage)
    
    return retVal
    
}

extension UIImage {
    class func imageWithView(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0)
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}