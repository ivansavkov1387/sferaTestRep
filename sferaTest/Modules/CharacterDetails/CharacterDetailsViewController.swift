//
//  CharacterDetailsViewController.swift
//  sferaTest
//
//  Created by Иван on 14.12.22.
//  
//

import UIKit

final class CharacterDetailsViewController: UIViewController {
    private let output: CharacterDetailsViewOutput
    private let characterViewModel: CharacterViewModel
    private var episodeViewModel = [EpisodeViewModel]()
    
    private lazy var tableView = UITableView(frame: .zero, style: .grouped)
    
    init(output: CharacterDetailsViewOutput, characterViewModel: CharacterViewModel) {
        self.output = output
        self.characterViewModel = characterViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.output.viewDidLoad(characterViewModel.episodes)
        self.setUpView()
        self.view.addSubview(tableView)
        self.setUpTableView()
    }
    
}

extension CharacterDetailsViewController: CharacterDetailsViewInput {
    func set(viewModels: [EpisodeViewModel]) {
        self.episodeViewModel = viewModels
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

private extension CharacterDetailsViewController {
    func setUpTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(CharacterDetailsCell.self)
        tableView.register(CharacterDetailsMainHeader.self)
        tableView.register(CharacterDetailsEpisodesHeader.self)
        
        let inset = UIEdgeInsets(top: -44, left: 0, bottom: 0, right: 0)
        self.tableView.contentInset = inset
        self.tableView.scrollIndicatorInsets = inset
        
        tableView.frame = self.view.frame
        
    }
    
    func setUpView() {
        self.title = characterViewModel.name
        self.view.backgroundColor = .yellow
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
}

extension CharacterDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(cellType: CharacterDetailsCell.self, for: indexPath)
        cell.update(with: episodeViewModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Cell.cellHeight
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let mainHeader = tableView.dequeueHeaderFooterViewCell(cellType: CharacterDetailsMainHeader.self)
        mainHeader.update(with: characterViewModel)
        
        let episodesHeader = tableView.dequeueHeaderFooterViewCell(cellType: CharacterDetailsEpisodesHeader.self)
        
        switch section {
        case 0:
            return mainHeader
        case 1:
            return episodesHeader
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return self.view.frame.width * 0.6
        default:
            return 50
        }
    }
    
}

extension CharacterDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Sections.numberOfSections
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0
        case 1:
           return episodeViewModel.count
        default:
            return 0
        }
    }
    
}
