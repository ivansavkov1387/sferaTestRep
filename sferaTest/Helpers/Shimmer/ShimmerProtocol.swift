//
//  ShimmerProtocol.swift
//  sferaTest
//
//  Created by Иван on 21.12.22.
//

import UIKit

protocol ShimmerProtocol: UIView {
    var gradientLayer: CAGradientLayer { get set }
}

extension ShimmerProtocol {
    func startShimmerAnimation() {
        let gradientColorOne: CGColor = UIColor.gradientDarkGrey.cgColor
        let gradientColorTwo: CGColor = UIColor.gradientLightGrey.cgColor

        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
        gradientLayer.locations = [0.0, 0.5, 1.0]

        let animation = CABasicAnimation(keyPath: "locations")
        animation.duration = 0.9
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: animation.keyPath)

        self.layer.addSublayer(gradientLayer)
    }

    func removeShimmerAnimation() {
        gradientLayer.removeFromSuperlayer()
    }
}

final class ShimmerUIButton: UIButton, ShimmerProtocol {
    var gradientLayer: CAGradientLayer = CAGradientLayer()
}

final class ShimmerUIImageView: UIImageView, ShimmerProtocol {
    var gradientLayer: CAGradientLayer = CAGradientLayer()
}

final class ShimmerUILabel: UILabel, ShimmerProtocol {
    var gradientLayer: CAGradientLayer = CAGradientLayer()
}

class ShimmerCollectionCell: UICollectionViewCell, ShimmerProtocol {
    var gradientLayer: CAGradientLayer = CAGradientLayer()
}


