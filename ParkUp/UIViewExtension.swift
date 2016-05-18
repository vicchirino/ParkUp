//
//  UIViewExtension.swift
//  Stride
//
//  Created by Victor Gabriel Chirino on 13/5/15.
//  Copyright (c) 2015 Stride Labs, Inc. All rights reserved.
//

import UIKit

extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView? {
        return UINib(nibName: nibNamed, bundle: bundle).instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
    
    var width: CGFloat { get { return CGRectGetWidth(frame) } }
    var height: CGFloat { get { return CGRectGetHeight(frame) } }
    var top: CGFloat { get { return CGRectGetMinY(frame) } }
    var left: CGFloat { get { return CGRectGetMinX(frame) } }
    var right: CGFloat { get { return CGRectGetMaxX(frame) } }
    var bottom: CGFloat { get { return CGRectGetMaxY(frame) } }
}

extension CGRect {
    var width: CGFloat { get { return size.width } }
    var height: CGFloat { get { return size.height } }
    var top: CGFloat { get { return CGRectGetMinY(self) } }
    var left: CGFloat { get { return CGRectGetMinX(self) } }
    var right: CGFloat { get { return CGRectGetMaxX(self) } }
    var bottom: CGFloat { get { return CGRectGetMaxY(self) } }
}

extension CALayer {
    var borderUIColor: UIColor {
        set {
            self.borderColor = newValue.CGColor
        }
        
        get {
            return UIColor(CGColor: self.borderColor!)
        }
    }
}

extension String {
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
}
