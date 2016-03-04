//
//  PhotoViewController.swift
//  handy
//
//  Created by Osadchy Dima on 3/2/16.
//  Copyright © 2016 Osadchy Dima. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBAction func doneButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            NSLog("Get the fuck ou of here")
        }
    }
    @IBOutlet weak var imageView: UIImageView!
    var image = UIImage() {
        didSet {
            print("Image in PhotoViewController is set up")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.contentMode = .ScaleAspectFill
        imageView.image = prepareMyImage(
            UIImage(named: "cam"),
            originalImage: image
        )
        
    }

    private struct Constants {
        static let styleBlur = UIBlurEffectStyle.Light
        static let smallImageHeightOnAPhoneScreen = CGFloat(423)
        static let smallImageWidthOnAPhoneScreen = CGFloat(292)
    }
    func prepareMyImage(cameraSkinImage: UIImage?, originalImage: UIImage?) -> UIImage? {
        
        let screenBounds = UIScreen.mainScreen().bounds
        
        let imageCam = cameraSkinImage
        let backgroundImage = ImageUtil.scaleImageToHeight(
            originalImage!,
            height: imageCam!.size.height
        )
        
        let imageOnAPhoneScreen: UIImage? = ImageUtil.cropToRect(
            image: ImageUtil.scaleImageToHeight(
                originalImage!,
                height: Constants.smallImageHeightOnAPhoneScreen)!,
            width: Constants.smallImageWidthOnAPhoneScreen,
            height: Constants.smallImageHeightOnAPhoneScreen
        )
        
        
        
        let newSize = CGSize(width: (imageCam?.size.width)!, height: (imageCam?.size.height)!)
        
        print(screenBounds)
        print(newSize.width, newSize.height)
        print(backgroundImage?.size.width, backgroundImage?.size.height)
        print(imageCam?.size.width, imageCam?.size.height)
        
        let centerCam = ImageUtil.startPointCGRectFirstRelativelySecond(newSize, b: (imageCam?.size)!)
        let centerImg = ImageUtil.startPointCGRectFirstRelativelySecond(newSize, b: (backgroundImage?.size)!)
        print("centerImg = \(centerImg)")
        print("centerCam = \(centerCam)")
        
        print("onscreensize = \(imageOnAPhoneScreen!.size)")
        //TODO! make background blur
        
        //TODO! find resolution of a little image on a phone
        
        ImageUtil.applyBlurEffect(backgroundImage!)
        
        
        UIGraphicsBeginImageContext( newSize )
        
        //background
        backgroundImage?.drawInRect(
            CGRectMake(
                centerImg.x,
                centerImg.y,
                backgroundImage!.size.width,
                newSize.height
            )
        )
        imageOnAPhoneScreen!.drawInRect(
            CGRectMake(
                0.32 * newSize.width,
                0.30 * newSize.height,
                imageOnAPhoneScreen!.size.width,
                imageOnAPhoneScreen!.size.height
            )
        )
        imageCam?.drawInRect(
            CGRectMake(
                centerCam.x,
                centerCam.y,
                newSize.width,
                newSize.height
            )
        )
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage
        
    }
}
