//
//  GalleryCollectionController.swift
//  Notes
//
//  Created by b0ysa on 21/07/2019.
//  Copyright © 2019 b0ysa. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class GalleryCollectionViewController: UICollectionViewController {
    
    private var picker = UIImagePickerController()
    private let storage = AppDelegate.shared.photosStorage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        collectionView.collectionViewLayout = GalleryLayout()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storage.photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        
        cell.imageView.image = storage.photos[indexPath.row].image
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showImage", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "showImage",
            let destination = segue.destination as? PhotoSliderViewController  else {
                return
        }
        
        if let indexPath = collectionView.indexPathsForSelectedItems?.first {
            destination.initialIndex = indexPath.row
        }
        
    }
    
    @IBAction func addPhotoTapped(_ sender: Any) {
        
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
        
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
}

extension GalleryCollectionViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let selectedImage = info[.editedImage] as! UIImage
        storage.add(Photo(image: selectedImage))
        
        dismiss(animated: true) { [unowned self] in
            self.collectionView.insertItems(at: [IndexPath(item: 0, section: 0)])
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension GalleryCollectionViewController: UINavigationControllerDelegate { }
