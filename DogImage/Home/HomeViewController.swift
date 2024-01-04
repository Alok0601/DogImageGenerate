//
//  ViewController.swift
//  DogImage
//
//  Created by Alok Ranjan on 04/01/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var generateDogButton: UIButton! {
        didSet {
            generateDogButton.backgroundColor = UIColor.blue
            generateDogButton.setTitle(generateDogs, for: .normal)
            generateDogButton.layer.cornerRadius = 20
            generateDogButton.setTitleColor(.white, for: .normal)
            generateDogButton.addTarget(self, action: #selector(generateDogTapped), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var recentlyGeneratedDogButton: UIButton! {
        didSet {
            recentlyGeneratedDogButton.backgroundColor = UIColor.blue
            recentlyGeneratedDogButton.setTitle(generatedDogs, for: .normal)
            recentlyGeneratedDogButton.layer.cornerRadius = 20
            recentlyGeneratedDogButton.setTitleColor(.white, for: .normal)
            recentlyGeneratedDogButton.addTarget(self, action: #selector(generatedDogTapped), for: .touchUpInside)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = randomDogGenerator
    }
    
    @objc func generateDogTapped() {
        let controller = UIStoryboard.init(name: "GerateDogsStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "GenerateDogsViewController") as!
        GenerateDogsViewController
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func generatedDogTapped() {
        let controller = UIStoryboard.init(name: "RecentlyGeneratedStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyRecentlyGeneratedDogsViewController") as!
        MyRecentlyGeneratedDogsViewController
        navigationController?.pushViewController(controller, animated: true)
    }
}

