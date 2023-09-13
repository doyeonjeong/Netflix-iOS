//
//  CacheManager.swift
//  Netflix
//
//  Created by DOYEON JEONG on 2023/08/11.
//

import UIKit

final class CacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}

extension UIImageView {
    func setImageURL(_ url: String) {
        DispatchQueue.global(qos: .background).async {
            let cachedKey = NSString(string: url)
            
            if let cachedImage = CacheManager.shared.object(forKey: cachedKey) {
                self.image = cachedImage
                return
            }
            
            guard let url = URL(string: url) else { return }
            URLSession.shared.dataTask(with: url) { (data, result, error) in
                guard error == nil else {
                    DispatchQueue.main.async { [weak self] in
                        self?.image = UIImage()
                    }
                    return
                }
                
                DispatchQueue.main.async { [weak self] in
                    if let data = data, let image = UIImage(data: data) {
                        CacheManager.shared.setObject(image, forKey: cachedKey)
                        self?.image = image
                    }
                }
            }
            .resume()
        }
    }
}
