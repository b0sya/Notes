//
//  PhotoSliderViewController.swift
//  Notes
//
//  Created by b0ysa on 21/07/2019.
//  Copyright © 2019 b0ysa. All rights reserved.
//

import UIKit

class PhotoSliderViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var initialIndex: Int!
    private var storage = AppDelegate.shared.photosStorage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        view.backgroundColor = .white
        setViewControllers(
            [prepeareViewController(with: storage.photos[initialIndex])],
            direction: .forward,
            animated: true,
            completion: nil
        )
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let currentPhoto = (viewController as! PagePhotoViewController).photo
        
        guard let index = storage.photos.firstIndex(of: currentPhoto),
            storage.photos.indices.contains(index + 1) else {
                return nil
        }
        
        return prepeareViewController(with: storage.photos[index + 1])
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let currentPhoto = (viewController as! PagePhotoViewController).photo
        
        guard let index = storage.photos.firstIndex(of: currentPhoto),
            index > 0 else {
                return nil
        }
        
        return prepeareViewController(with: storage.photos[index - 1])
    }
    
    private func prepeareViewController(with photo: Photo) -> UIViewController {
        return PagePhotoViewController(with: photo)
    }
}
