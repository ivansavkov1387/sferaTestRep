//
//  ShimmerCell.swift
//  sferaTest
//
//  Created by Иван on 22.12.22.
//

import Foundation
import UIKit

class ShimmerCell: ShimmerCollectionCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
        startCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
    }
    
    func update(with viewModel: CharacterViewModel) {
        
    }
    
    
    func stopCell() {
        self.removeShimmerAnimation()
    }
    func startCell() {
        self.startShimmerAnimation()
    }
    
}

private extension ShimmerCell {
    
    func setUpCell() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    
}
