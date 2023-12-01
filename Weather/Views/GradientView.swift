//
//  GradientView.swift
//  Weather
//
//  Created by Siddhant Paliwal on 7/19/23.
//

import UIKit

class GradientView: UIView {
    override open class var layerClass: AnyClass {
       return CAGradientLayer.classForCoder()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
    }
}

