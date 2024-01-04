//
//  DogsViewModel.swift
//  DogImage
//
//  Created by Alok Ranjan on 04/01/24.
//

import Foundation

class DogsViewModel {
    
    private var cache: CacheDataProtocol? = nil
    
    init(cache: CacheDataProtocol) {
        self.cache = cache
    }

    var images: [DogImage] {
        return cache?.getImages() ?? []
    }

    func generateDog(completion: @escaping (DogImage?) -> Void) {
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            do {
                let decoder = JSONDecoder()
                let dogImage = try decoder.decode(DogImage.self, from: data)
                
                // Update the cache with the fetched dog image
                self.cache?.addImage(dogImage)

                // Call completion handler with the fetched dog image
                completion(dogImage)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }


    func clearCache() {
        cache?.clearCache()
    }
}
