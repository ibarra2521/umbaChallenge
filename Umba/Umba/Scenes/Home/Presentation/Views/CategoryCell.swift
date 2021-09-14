//
//  CategoryCell.swift
//  Rappiering
//
//  Created by Nivardo Ibarra on 7/15/21.
//

import UIKit

final class CategoryCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private var category: HomeUseCases.DisplayableCategory?
    var didSelectMovie: ((CategoryCell, Int) -> Void)?
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let space: CGFloat = 8.0
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.sectionInset.left = 16
        flowLayout.sectionInset.right = 16
        return flowLayout
    }()
    
    // MARK: - Constants
    let movieId = String(describing: MovieCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateCell(category: HomeUseCases.DisplayableCategory) {
        self.category = category
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.collectionViewLayout = flowLayout
        collectionView.register(UINib(nibName: movieId, bundle: nil), forCellWithReuseIdentifier: movieId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension CategoryCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectMovie?(self, indexPath.row)
    }
}

// MARK: - UICollectionViewDataSource
extension CategoryCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let category = self.category else { return 0 }
        return category.numberElements
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieId, for: indexPath) as? MovieCell, let category = self.category else { return UICollectionViewCell() }
        let movies = category.movies
        let movie = movies[indexPath.row]
        cell.setupCell(movie: movie, indexPath: indexPath.item)
        //Get UIImage Data 1)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CategoryCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - ((UIScreen.main.bounds.width * 0.8 / 16) * 2)
        return CGSize(width: width, height: width / 2.0)
    }
}
