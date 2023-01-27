//
//  EpisodesHeader.swift
//  sferaTest
//
//  Created by Иван on 20.12.22.
//

import Foundation
import UIKit

class CharacterDetailsEpisodesHeader: UITableViewHeaderFooterView {
    
    let episodesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.tintColor = .systemGray
        label.text = Localization.episodes
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(episodesLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        episodesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Layout.tableElementsSideMargin).isActive = true
        episodesLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
}
