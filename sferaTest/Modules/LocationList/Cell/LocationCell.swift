//
//  LocationsCardView.swift
//  sferaTest
//
//  Created by Иван on 14.12.22.
//

import Foundation
import UIKit

class LocationCell: UICollectionViewCell {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = Font.system(ofSize: 17, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = Font.system(ofSize: 13, weight: .medium)
        label.textColor = .systemGray6
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
        self.addSubview(nameLabel)
        self.addSubview(typeLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("UNSUPPORTED")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.typeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        self.typeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        self.typeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        
        self.nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        self.nameLabel.topAnchor.constraint(greaterThanOrEqualTo: typeLabel.bottomAnchor, constant: 8).isActive = true
        self.nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        self.nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
    }
    
    func update(with viewModel: LocationCardViewModel) {
        self.nameLabel.text = viewModel.name
        self.typeLabel.text = viewModel.type
        self.setNeedsLayout()
    }
    
}

private extension LocationCell {
    func setUpCell() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.backgroundColor = Styles.Color.appGreen
    }
}
