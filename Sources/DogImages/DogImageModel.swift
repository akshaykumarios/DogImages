//
//  File.swift
//  
//
//  Created by Akshay Kumar on 07/07/24.
//

import Foundation

final public class DogImageModel {
    private var dogImages: [URL] = []
    private var currentIndex: Int = 0
    
    public init() {
        fetchInitialDogImages()
    }
    
    private func fetchInitialDogImages() {
        let group = DispatchGroup()
        for _ in 1...10 {
            group.enter()
            fetchRandomDogImage { [weak self] imageUrl in
                if let url = imageUrl {
                    self?.dogImages.append(url)
                }
                group.leave()
            }
        }
        group.wait()
        group.notify(queue: .main) {
            debugPrint("Initial dog images fetched")
        }
    }
    
    private func fetchRandomDogImage(completion: @escaping (URL?) -> Void) {
        let urlString = "https://dog.ceo/api/breeds/image/random"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let imageUrlString = json["message"] as? String {
                    let imageUrl = URL(string: imageUrlString)
                    completion(imageUrl)
                } else {
                    completion(nil)
                }
            } catch {
                completion(nil)
            }
        }.resume()
    }
    
    public func getImage() -> URL? {
        return dogImages.first
    }
    
    public func getImages(_ number: Int) -> [URL] {
        return Array(dogImages.prefix(number))
    }
    
    public func getNextImage() -> URL? {
        guard !dogImages.isEmpty else { return nil }
        currentIndex = (currentIndex + 1) % dogImages.count
        return dogImages[currentIndex]
    }
    
    public func getPreviousImage() -> URL? {
        guard !dogImages.isEmpty else { return nil }
        currentIndex = (currentIndex - 1 + dogImages.count) % dogImages.count
        return dogImages[currentIndex]
    }
}
