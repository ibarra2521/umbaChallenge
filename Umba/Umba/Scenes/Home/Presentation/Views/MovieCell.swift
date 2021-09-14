//
//  MovieCell.swift
//  Rappiering
//
//  Created by Nivardo Ibarra on 7/15/21.
//

import UIKit

final class MovieCell: UICollectionViewCell {

    // MARK: - IBOulets
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelMovie: UILabel!
    
    // MARK: - Constants
    let identifier = String(describing: MovieCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func setupUI() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
    
    func setupCell(movie: HomeUseCases.DisplayableMovie, indexPath: Int) {
        labelMovie.text = movie.titleMovie
        let itemNumber = NSNumber(value: indexPath)
        if let cachedImage = ImageCache().cache.object(forKey: itemNumber) {
            imageMovie.image = cachedImage
        } else {
            ImageCache().load(imageUrl: movie.imageMovie, completion: { [weak self] (image) in
                                guard let self = self, let image = image else { return }
                                self.imageMovie.image = image
                                ImageCache().cache.setObject(image, forKey: itemNumber)})            
        }
        setupUI()
    }    
}
