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
    var startPoint: CGPoint {
        return CGPoint(
            x: sizeOfParentView!.width * 0.241,
            y: sizeOfParentView!.height * 0.29
        )
    }
    var screenSize: CGSize {
        return CGSize(
            width: sizeOfParentView!.width * 0.785 - startPoint.x,
            height: sizeOfParentView!.height * 0.70 - startPoint.y
        )
    }
    init(name phoneName: String?, size parentSize: CGSize?, hand handImageName: UIImage?){
        name = phoneName
        sizeOfParentView = parentSize
        handImage = handImageName
    }
}