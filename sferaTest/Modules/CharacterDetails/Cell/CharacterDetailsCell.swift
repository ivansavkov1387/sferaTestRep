//
//  CharacterDetailsCell.swift
//  sferaTest
//
//  Created by Иван on 16.12.22.
//

import Foundation

import UIKit

class CharacterDetailsCell: UITableViewCell {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = Font.system(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let airDateLabel: UILabel = {
        let label = UILabel()
        label.font = Font.system(ofSize: 12, weight: .medium)
        label.textColor = .systemGray3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let episodeLabel: UILabel = {
        let label = UILabel()
        label.font = Font.system(ofSize: 16, weight: .bold)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(airDateLabel)
        contentView.addSubview(episodeLabel)
        setUpCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("UNSUPPORTED")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                            constant: Layout.tableCellsVertMargin).isActive = true
        self.nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                constant: Layout.tableElementsSideMargin).isActive = true
        self.nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                 constant: -Layout.tableCellsVertMargin).isActive = true
        
        self.airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,
                                               constant: Layout.tableCellsVertMargin).isActive = true
        self.airDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: Layout.tableElementsSideMargin).isActive = true
        self.airDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -Layout.tableCellsVertMargin).isActive = true
        
        self.episodeLabel.topAnchor.constraint(equalTo: airDateLabel.bottomAnchor,
                                               constant: Layout.tableCellsVertMargin).isActive = true
        self.episodeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: Layout.tableElementsSideMargin).isActive = true
        self.episodeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -Layout.tableCellsVertMargin).isActive = true
        self.episodeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                  constant: -Layout.tableCellsVertMargin).isActive = true
        
    }
    
    func update(with viewModel: EpisodeViewModel) {
        self.nameLabel.text = viewModel.name
        self.episodeLabel.text = viewModel.episode
        self.airDateLabel.text = viewModel.airDate
        self.setNeedsLayout()
    }
    
}

private extension CharacterDetailsCell {
    func setUpCell() {
        self.backgroundColor = .white
    }
    
}
