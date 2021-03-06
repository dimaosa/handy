//
//  ImageUtil.swift
//  CAMERA
//
//  Created by Osadchy Dima on 3/4/16.
//  Copyright © 2016 Osadchy Dima. All rights reserved.
//

import Foundation
import UIKit
import GPUImage

enum BiggerImageSide {
    case IDontKnow
    case Height
    case Width
}

class ImageUtil: NSObject {
    
    static func cropToSquare(image originalImage: UIImage, contextSize: CGSize? = nil) -> UIImage {
        // Create a copy of the image without the imageOrientation property so it is in its native orientation (landscape)
        let contextImage: UIImage = UIImage(CGImage: originalImage.CGImage!)

        let _contextSize = contextImage.size
        
        let posX: CGFloat
        let posY: CGFloat
        let width: CGFloat
        let height: CGFloat
        
        if _contextSize.width > _contextSize.height {
            posX = ((_contextSize.width - _contextSize.height) / 2)
            posY = 0
            width = _contextSize.height
            height = _contextSize.height
        } else {
            posX = 0
            posY = ((_contextSize.height - _contextSize.width) / 2)
            width = _contextSize.width
            height = _contextSize.width
        }
        
        let rect: CGRect = CGRectMake(posX, posY, width, height)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImageRef = CGImageCreateWithImageInRect(contextImage.CGImage, rect)!
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage? = UIImage(CGImage: imageRef, scale: originalImage.scale, orientation: originalImage.imageOrientation)
        
        
        UIGraphicsBeginImageContext(contextSize!)
        image!.drawInRect(CGRectMake(0, 0, (contextSize?.width)!, (contextSize?.height)!))
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    static func cropToRect(image originalImage: UIImage,width  _width: CGFloat, height _height: CGFloat) -> UIImage {
        // Create a copy of the image without the imageOrientation property so it is in its native orientation (landscape)
        let contextImage: UIImage = UIImage(CGImage: originalImage.CGImage!)
        
        let contextSize: CGSize = contextImage.size
        
        let posX: CGFloat
        let posY: CGFloat
        let width: CGFloat
        let height: CGFloat
        
            posX = ((contextSize.width - _width) / 2)
            posY = 0
            width = (_width * originalImage.scale)
            height = (_height * originalImage.scale)
        
        let rect: CGRect = CGRectMake(posX, posY, width, height)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImageRef = CGImageCreateWithImageInRect(contextImage.CGImage, rect)!
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage? = scaleImageTo(image: UIImage(CGImage: imageRef, scale: originalImage.scale, orientation: originalImage.imageOrientation), scale: 1)!
        
        return image!
    }
    static func scaleImageTo(image originalImage: UIImage, scale: Double) -> UIImage? {
        
        let _scale = CGFloat(min(max(0, scale), 5))
        
        let newImageWidth = originalImage.size.width * _scale
        let newImageHeight = originalImage.size.height * _scale
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newImageWidth, height: newImageHeight), false, 0.0)
        originalImage.drawInRect(CGRectMake(0, 0, newImageWidth, newImageHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImage
    }
    static func scaleImageToHeight(image: UIImage, height: CGFloat) -> UIImage? {
        
        let newImageWidth = image.size.width * ((height)/image.size.height)
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newImageWidth, height: height), false, 0.0)
        image.drawInRect(CGRectMake(0, 0, newImageWidth, height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImage
    }
    
    static func startPointCGRectFirstRelativelySecond(a: CGSize, b: CGSize) -> CGPoint {
        
        var newPoint = CGPoint()
        newPoint.x = a.width / 2 - b.width / 2
        newPoint.y = a.height / 2 - b.height / 2
        
        return newPoint
    }
    
    static func applyBlurEffect(image: UIImage) -> UIImage?{
        let imageToBlur = CIImage(image: image)
        let blurfilter = CIFilter(name: "CIGaussianBlur")
        blurfilter!.setValue(imageToBlur, forKey: "inputImage")
        let resultImage = blurfilter!.valueForKey("outputImage") as! CIImage
        let blurredImage: UIImage? = UIImage(CIImage: resultImage)
        
        return blurredImage
    }
}