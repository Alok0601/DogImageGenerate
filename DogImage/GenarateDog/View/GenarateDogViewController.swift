//
//  GenarateDogViewController.swift
//  DogImage
//
//  Created by Alok Ranjan on 04/01/24.
//

import UIKit

class GenerateDogsViewController: UIViewController {
    
    @IBOutlet weak var dogImage: UIImageView!
    
    @IBOutlet weak var generateButton: UIButton! {
        didSet {
            generateButton.setTitle(gererate, for: .normal)
            generateButton.backgroundColor = UIColor.blue
            generateButton.layer.cornerRadius = 20
            generateButton.setTitleColor(.white, for: .normal)
            generateButton.addTarget(self, action: #selector(generateButtonTapped), for: .touchUpInside)
        }
    }
    
    var viewModel: DogsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = generateDogs
        setupViewMode()
    }
    
    func setupViewMode() {
        viewModel = DogsViewModel(cache: CacheDataManager())
    }
    
    @objc func generateButtonTapped() {
        generateButton.isEnabled = false
        viewModel?.generateDog { [weak self] data in
            DispatchQueue.main.async {
                self?.generateButton.isEnabled = true
                if let urlString = data?.message {
                    self?.dogImage.load(url: URL(string: urlString)!)
                }
            }
        }
    }
}
