//
//  File 2.swift
//  
//
//  Created by Akshay Kumar on 07/07/24.
//

import Foundation

final public class DogImagePresenter {
    private let model: DogImageModel
    weak private var view: DogImageView?
    
    public init(model: DogImageModel) {
        self.model = model
    }
    
    public func attachView(_ view: DogImageView) {
        self.view = view
    }
    
    public func getImage() {
        if let image = model.getImage() {
            view?.displayImage(image)
        } else {
            view?.showError("No image available")
        }
    }
    
    public func getImages(_ number: Int) {
        let images = model.getImages(number)
        if !images.isEmpty {
            view?.displayImages(images)
        } else {
            view?.showError("No images available")
        }
    }
    
    public func getNextImage() {
        if let image = model.getNextImage() {
            view?.displayImage(image)
        } else {
            view?.showError("No next image available")
        }
    }
    
    public func getPreviousImage() {
        if let image = model.getPreviousImage() {
            view?.displayImage(image)
        } else {
            view?.showError("No previous image available")
        }
    }
    
    public func noImage() {
        view?.showError("No images available")
    }
}
