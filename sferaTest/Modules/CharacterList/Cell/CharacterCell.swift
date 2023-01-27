//
//  CharacterCardView.swift
//  sferaTest
//
//  Created by Иван on 12/1/22.
//

import UIKit
import Kingfisher

class CharacterCell: ShimmerCollectionCell {
    
    private let speciesLabel =  ShimmerUILabel()
    private let nameLabel = ShimmerUILabel()
    private let statusLabel = ShimmerUILabel()
    private let characterImageView = ShimmerUIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Styles.Color.appGreen
        contentView.addSubview(nameLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(characterImageView)
        contentView.addSubview(speciesLabel)
        
        setUpCell()
        setUpLabels()
        
        startCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let maxLabelWidth = self.frame.width - Layout.colViewCellMargin * 2
        let maxLabelSize = CGSize(width: maxLabelWidth, height: .greatestFiniteMagnitude)
        
        let speciesLabelSize = self.speciesLabel.sizeThatFits(maxLabelSize)
        self.speciesLabel.frame.origin = CGPoint(x: Layout.colViewCellMargin, y: Layout.colViewCellMargin)
        self.speciesLabel.frame.size = speciesLabelSize
        
        let nameLabelSize = self.nameLabel.sizeThatFits(maxLabelSize)
        let nameLabelOrigin = CGPoint(x: Layout.colViewCellMargin,
                                      y: self.frame.height - Layout.colViewCellMargin - nameLabelSize.height)
        self.nameLabel.frame.origin = nameLabelOrigin
        self.nameLabel.frame.size = nameLabelSize
        
        
        let statusLabelSize = self.statusLabel.sizeThatFits(maxLabelSize)
        let statusLabelOrigin = CGPoint(x: Layout.colViewCellMargin,
                                        y: self.nameLabel.frame.minY - Layout.colViewCellMargin - statusLabelSize.height )
        self.statusLabel.frame.origin = statusLabelOrigin
        self.statusLabel.frame.size = statusLabelSize
        
        self.characterImageViewLayout()
        
    }
    
    func update(with viewModel: CharacterViewModel) {
            self.speciesLabel.text = viewModel.species
            self.nameLabel.text = viewModel.name
            self.statusLabel.text = viewModel.status
            self.characterImageView.setImage(with: URL(string: viewModel.imageURL),
                                            stopAnimation: self.stopCell())
            self.setNeedsLayout()
    }
    
    func stopShimmerAnimations() {
        self.speciesLabel.removeShimmerAnimation()
        self.nameLabel.removeShimmerAnimation()
        self.statusLabel.removeShimmerAnimation()
        self.characterImageView.removeShimmerAnimation()
    }
    func startShimmerAnimations() {
        self.speciesLabel.startShimmerAnimation()
        self.nameLabel.startShimmerAnimation()
        self.statusLabel.startShimmerAnimation()
        self.characterImageView.startShimmerAnimation()
        
    }
    
    func stopCell() {
        self.removeShimmerAnimation()
    }
    func startCell() {
        self.startShimmerAnimation()
    }
    
}

private extension CharacterCell {
    
    func characterImageViewLayout() {
        self.characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        characterImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        characterImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        characterImageView.bottomAnchor.constraint(equalTo: statusLabel.topAnchor,
                                                   constant: -Layout.colViewCellMargin).isActive = true
    }
    
    
    func setUpCell() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    func setUpLabels() {
        self.speciesLabel.font = Font.system(ofSize: 14, weight: .medium)
        self.speciesLabel.textColor = .white
        self.speciesLabel.backgroundColor = Styles.Color.appGreen
        self.speciesLabel.layer.cornerRadius = 5
        self.speciesLabel.layer.masksToBounds = true
        
        
        self.nameLabel.font = Font.system(ofSize: 32, weight: .bold)
        self.nameLabel.textColor = .white
        self.nameLabel.numberOfLines = 0
        
        
        self.statusLabel.font = Font.system(ofSize: 18, weight: .regular)
        self.statusLabel.textColor = .white
        
    }
    
    
    
    
    
    
}


