//
//  PhotoViewController.swift
//  handy
//
//  Created by Osadchy Dima on 3/2/16.
//  Copyright © 2016 Osadchy Dima. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var image = UIImage() {
        didSet {
            print("Image in PhotoViewController is set up")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        processImage()
        imageView.image = image
        imageView.contentMode = .ScaleAspectFit
    }

    private struct Constants {
        static let styleBlur = UIBlurEffectStyle.Light
    }
    func processImage() {
        
        let blurStyle = UIBlurEffect(style: Constants.styleBlur)
        let blurView = UIVisualEffectView(effect: blurStyle)
        blurView.frame = imageView.frame
        

        imageView.image = image
        imageView.addSubview(blurView)
    }
}
