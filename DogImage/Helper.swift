//
//  Helper.swift
//  DogImage
//
//  Created by Alok Ranjan on 04/01/24.
//

import Foundation
import UIKit


let generateDogs = "Generate Dogs!"
let generatedDogs = "My Recently Generated Digs!"
let randomDogGenerator = "Random Dog Generator"
let gererate = "Generate"
let clearDogstxt = "Clear Dogs!"


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
