//
//  ImageCache.swift
//  Umba
//
//  Created by Nivardo Ibarra on 9/13/21.
//

import UIKit

open class ImageCache {
    
    let cache = NSCache<NSNumber, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    
    // MARK: - Image Loading
    public func load(imageUrl: String, completion: @escaping (UIImage?) -> ()) {
        utilityQueue.async {
            guard let url = URL(string: imageUrl) else { return }
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
