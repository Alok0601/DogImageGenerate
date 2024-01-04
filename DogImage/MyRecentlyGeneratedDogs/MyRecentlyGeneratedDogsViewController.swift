//
//  MyRecentlyGeneratedDogsViewController.swift
//  DogImage
//
//  Created by Alok Ranjan on 04/01/24.
//

import UIKit

class MyRecentlyGeneratedDogsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var dogCollectionView: UICollectionView!
    
    @IBOutlet weak var clearDogs: UIButton! {
        didSet {
            clearDogs.backgroundColor = UIColor.blue
            clearDogs.setTitle(clearDogstxt, for: .normal)
            clearDogs.layer.cornerRadius = 20
            clearDogs.setTitleColor(.white, for: .normal)
            clearDogs.addTarget(self, action: #selector(clearDogTapped), for: .touchUpInside)
        }
    }
    var viewModel: DogsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = generatedDogs
        viewModel = DogsViewModel(cache: CacheDataManager())
        dogCollectionView.delegate = self
        dogCollectionView.dataSource = self
        updateGallery()
    }
    
    
    // Implement UICollectionViewDataSource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let imageView = UIImageView(frame: cell.contentView.bounds)
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        
        // Load the image from the view model
        let dogImage = viewModel?.images[indexPath.item]
        imageView.load(url: URL(string: dogImage?.message ?? "")!)
        
        cell.contentView.addSubview(imageView)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Set the size of each cell to match the size of the collection view
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
    }
    
    // Implement the updateGallery method
    func updateGallery() {
        DispatchQueue.main.async { [weak self] in
            self?.dogCollectionView.reloadData()
        }
    }
    
    @objc func clearDogTapped() {
        viewModel?.clearCache()
        updateGallery()
    }
}
