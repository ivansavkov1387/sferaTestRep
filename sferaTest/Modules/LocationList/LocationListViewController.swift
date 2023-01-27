//
//  LocationListViewController.swift
//  sferaTest
//
//  Created by Иван on 13.12.22.
//  
//

import UIKit

final class LocationListViewController: UIViewController {
	private let output: LocationListViewOutput
    private let collectionView: UICollectionView
    
    private var locationListViewModel = [LocationCardViewModel]()

    init(output: LocationListViewOutput) {
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

extension LocationListViewController: LocationListViewInput {
    func set(viewModels: [LocationCardViewModel]) {
        self.locationListViewModel = viewModels
        self.collectionView.reloadData()
    }

}

extension LocationListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        locationListViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = locationListViewModel[indexPath.item]
        let cell = collectionView.dequeueCell(cellType: LocationCell.self, for: indexPath)
        cell.update(with: viewModel)
        return cell
    }
    
}

extension LocationListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let ratio: CGFloat = 0.7
        let width = (collectionView.frame.width / 2) -
                     collectionView.contentInset.left -
                    (collectionView.contentInset.left / 2)
        let height = ratio*width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.output.willDisplay(at: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Layout.colViewCellMargin
    }
    
}

private extension LocationListViewController {
     func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(LocationCell.self)
        self.collectionView.backgroundColor = .systemBackground
        self.collectionView.contentInset = UIEdgeInsets(top: Layout.colViewCellMargin, left: Layout.colViewCellMargin,
                                                        bottom: Layout.colViewCellMargin, right: Layout.colViewCellMargin)
    }
    
}

