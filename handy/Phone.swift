//
//  Phone.swift
//  handy
//
//  Created by Osadchy Dima on 3/9/16.
//  Copyright © 2016 Osadchy Dima. All rights reserved.
//

import Foundation
import UIKit

class PhoneSkin {
    
    let name: String?
    let sizeOfParentView: CGSize?
    let handImage: UIImage?
    let startPointScale: (Double, Double)
    var startPoint: CGPoint {
        return CGPoint(
            x: sizeOfParentView!.width * CGFloat(startPointScale.0),
            y: sizeOfParentView!.height * CGFloat(startPointScale.1)
        )
    }
    var screenSize: CGSize {
        return CGSize(
            width: sizeOfParentView!.width * 0.56 - startPoint.x,
            height: sizeOfParentView!.height * 0.80 - startPoint.y
        )
    }
    init(name phoneName: String?, size parentSize: CGSize?, hand handImageName: UIImage?, startPScale: (Double, Double)){
        name = phoneName
        sizeOfParentView = parentSize
        handImage = handImageName
        startPointScale = startPScale
    }
}