//
//  CharacterListViewController.swift
//  sferaTest
//
//  Created by Иван on 11/30/22.
//  
//

import UIKit

final class CharacterListViewController: UIViewController {
    private let output: CharacterListViewOutput
    private let collectionView: UICollectionView
    
    private var characterListViewModel = [CharacterViewModel]()
    
    var isAnimating = true
    
    init(output: CharacterListViewOutput) {
        self.output = output
        let collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.output.viewDidLoad()
        
    }
    
    override func loadView() {
        super.loadView()
        let view = UIView()
        view.addSubview(collectionView)
        setupCollectionView()
        self.view = view
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    
    
}

extension CharacterListViewController: CharacterListViewInput {
    func set(viewModels: [CharacterViewModel]) {
            self.characterListViewModel = viewModels
            self.isAnimating = false
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.collectionView.reloadData()
        }
        
    }
    
}

extension CharacterListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isAnimating {
            return 10
        } else {
            return characterListViewModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellType: CharacterCell.self, for: indexPath)
        let shimmerCell = collectionView.dequeueCell(cellType: ShimmerCell.self, for: indexPath)
        if isAnimating {
            return shimmerCell
        } else {
            let viewModel = self.characterListViewModel[indexPath.item]
            cell.update(with: viewModel)
            return cell
        }
    }
}

extension CharacterListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let ratio: CGFloat = 1.3
        let width = collectionView.frame.width - collectionView.contentInset.left*2
        let height = ratio*width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            self.output.willDisplay(at: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = characterListViewModel[indexPath.row]
        self.output.onCellTap(with: viewModel)
    }
    
    
}

private extension CharacterListViewController {
    func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(CharacterCell.self)
        self.collectionView.register(ShimmerCell.self)
        self.collectionView.backgroundColor = .systemBackground
        self.collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
    }
    
    
    
    
    
}
