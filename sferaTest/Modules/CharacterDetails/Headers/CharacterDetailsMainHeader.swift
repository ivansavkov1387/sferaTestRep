//
//  CharacterDetailsHeader.swift
//  sferaTest
//
//  Created by Иван on 16.12.22.
//

import UIKit

class CharacterDetailsMainHeader: UITableViewHeaderFooterView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    private let nameLabel: ShimmerUILabel = {
        let label = ShimmerUILabel()
        label.font = Font.system(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.font = Font.system(ofSize: 18, weight: .medium)
        label.textColor = .systemGray6
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = Font.system(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
        self.addSubview(imageView)
        self.addSubview(statusLabel)
        self.addSubview(nameLabel)
        self.addSubview(speciesLabel)
        mainHeaderSetUp()
        setNeedsLayout()
        nameLabel.startShimmerAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: Layout.headerVertMargin).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        
        statusLabel.topAnchor.constraint(greaterThanOrEqualTo: imageView.bottomAnchor, constant: Layout.headerBetweenMargin).isActive = true
        statusLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true


        nameLabel.topAnchor.constraint(greaterThanOrEqualTo: statusLabel.bottomAnchor, constant: Layout.headerBetweenMargin).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        speciesLabel.topAnchor.constraint(greaterThanOrEqualTo: nameLabel.bottomAnchor, constant: Layout.headerBetweenMargin).isActive = true
        speciesLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Layout.headerVertMargin).isActive = true
        speciesLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        // Работает только если оставить здесь....
        imageView.layer.cornerRadius = (self.frame.width*0.3)/2
        imageView.clipsToBounds = true
    }
    
    func update(with viewModel: CharacterViewModel) {
        self.statusLabel.text = viewModel.status
        self.imageView.kf.setImage(with: URL(string: viewModel.imageURL))
        self.nameLabel.text = viewModel.name
        self.speciesLabel.text = viewModel.species
        self.statusLabelColor()
        self.setNeedsLayout()
    }

}

private extension CharacterDetailsMainHeader {
    func mainHeaderSetUp() {
        contentView.backgroundColor = Styles.Color.appGreen
    }
    
    func statusLabelColor() {
        switch statusLabel.text {
        case "Alive": statusLabel.textColor = .yellow
        case "Dead": statusLabel.textColor = .red
        default:
            statusLabel.textColor = .white
        }
    }
    
}


