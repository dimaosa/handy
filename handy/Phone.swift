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
    var sizeOfParentView: CGSize?
    let handImage: UIImage?
    let contextScreenSize: CGRect
    var startPoint: CGPoint {
        return CGPoint(
            x: sizeOfParentView!.width * contextScreenSize.origin.x,
            y: sizeOfParentView!.height * contextScreenSize.origin.y
        )
    }
    var screenSize: CGSize {
        return CGSize(
            width: sizeOfParentView!.width * contextScreenSize.width - startPoint.x,
            height: sizeOfParentView!.height * contextScreenSize.height - startPoint.y
        )
    }
    init(name phoneName: String?, size parentSize: CGSize?, hand handImageName: UIImage?, contextScreenSize con: CGRect){
        name = phoneName
        sizeOfParentView = parentSize
        handImage = handImageName
        contextScreenSize = con
    }
}