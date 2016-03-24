//
//  PhoneSkinsConstants.swift
//  handy
//
//  Created by Osadchy Dima on 3/23/16.
//  Copyright © 2016 Osadchy Dima. All rights reserved.
//

import Foundation
import UIKit

class PhoneSkinsConstants {
    
    var size: CGSize {
        didSet{
            
            for phone in phoneSkinsConstants {
                phone.sizeOfParentView = size
                
            }
        }
    }
    var phoneSkinsConstants = [
        PhoneSkin(
            name: "picMountain",
            size: CGSize(),
            hand: UIImage(named: "picMountain"),
            contextScreenSize: CGRectMake(0.354, 0.384, 0.573, 0.776)
        ),
        PhoneSkin(
            name: "picRelax",
            size: CGSize(),
            hand: UIImage(named: "picRelax"),
            contextScreenSize: CGRectMake(0.397, 0.468, 0.605, 0.838)
        ),
        PhoneSkin(
            name: "picSkiWhite",
            size: CGSize(),
            hand: UIImage(named: "picSkiWhite"),
            contextScreenSize: CGRectMake(0.199, 0.269, 0.843, 0.622)
        ),
        PhoneSkin(
            name: "picSnowRail",
            size: CGSize(),
            hand: UIImage(named: "picSnowRail"),
            contextScreenSize: CGRectMake(0.244, 0.336, 0.817, 0.662)
        ),
        PhoneSkin(
            name: "picCreative",
            size: CGSize(),
            hand: UIImage(named: "picCreative"),
            contextScreenSize: CGRectMake(0.321, 0.247, 0.677, 0.869)
        )
        
    ]

    init(sizeMainImageView: CGSize) {
        
        size = sizeMainImageView
        
        for phone in phoneSkinsConstants {
            phone.sizeOfParentView = size
            
        }

    }
}
