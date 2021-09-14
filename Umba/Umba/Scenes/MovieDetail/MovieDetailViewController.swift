//
//  MovieDetailViewController.swift
//  Rappiering
//
//  Created by Nivardo Ibarra on 9/13/21.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var movieImage: UIImageView!    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var synopsisField: UILabel!
    @IBOutlet weak var circularImageMovie: CircularView!
    @IBOutlet weak var otherDetails: UILabel!
    private var baseUrlImage = "https://image.tmdb.org/t/p/w500"
    
    // MARK: - Properties
    var movie: Movie?
        
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private func initialize() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        overrideUserInterfaceStyle = .dark
        
        ImageCache().load(imageUrl: "\(baseUrlImage)\(movie?.backdropPath ?? String())", completion: { [weak self] (image) in
            guard let self = self, let image = image else { return }
            self.circularImageMovie.image = image
        })

        ImageCache().load(imageUrl: "\(baseUrlImage)\(movie?.posterPath ?? String())", completion: { [weak self] (image) in
            guard let self = self, let image = image else { return }
            self.movieImage.image = image
        })
        synopsisField.text = movie?.overview
        otherDetails.text = "\(movie?.originalLanguage ?? "") - \(movie?.releaseDate ?? "")"
    }
}
