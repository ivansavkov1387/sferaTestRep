//
//  UIImageView+URL.swift
//  sferaTest
//
//  Created by Иван on 10.12.22.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with url: URL?, stopAnimation: ()) {
        self.kf.setImage(with: url) { result in
            switch result {
            case .success(_): stopAnimation
            case .failure(let error): print(error)
            }
        }
    }
}
