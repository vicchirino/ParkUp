//
//  UIImageExtension.swift
//  Stride
//
//  Created by Victor Gabriel Chirino on 5/13/15.
//  Copyright (c) 2015 Stride Labs, Inc. All rights reserved.
//

import UIKit
import QuartzCore

extension UIImage {
    class func imageWithColor(color: UIColor, size: CGSize = CGSizeMake(1, 1)) -> UIImage {
        let rect = CGRectMake(0.0, 0.0, size.width, size.height)
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }

    var width: CGFloat { get { return size.width } }
    var height: CGFloat { get { return size.height } }
    
    
}
