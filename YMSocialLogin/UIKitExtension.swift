//
//  UIKitExtension.swift
//  PeekPop3DTouch
//
//  Created by Yudiz Solutions Pvt.Ltd. on 13/01/17.
//  Copyright © 2017 Yudiz Solutions Pvt.Ltd. All rights reserved.
//

import UIKit

public extension UIView {
    @IBInspectable public var isRound: Bool {
        get { return (layer.cornerRadius == (self.frame.width / 2 )) || (layer.cornerRadius == (self.frame.height / 2)) }
        set { layer.cornerRadius = newValue == true ? self.frame.width / 2 : layer.cornerRadius }
    }
    @IBInspectable public var borderWidth: CGFloat {
        get { return self.layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }
    @IBInspectable public var borderColor: UIColor {
        get { return self.layer.borderColor == nil ? UIColor.clear : UIColor(cgColor: self.layer.borderColor!) }
        set { self.layer.borderColor = newValue.cgColor }
    }
    @IBInspectable public var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    @IBInspectable public var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
    @IBInspectable public var shadowOpacity: Float {
        get { return layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }
    @IBInspectable public var shadowColor: UIColor? {
        get { return layer.shadowColor != nil ? UIColor(cgColor: layer.shadowColor!) : nil }
        set { layer.shadowColor = newValue?.cgColor }
    }
    @IBInspectable public var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }
    @IBInspectable public var zPosition: CGFloat {
        get { return layer.zPosition }
        set { layer.zPosition = newValue }
    }
}
