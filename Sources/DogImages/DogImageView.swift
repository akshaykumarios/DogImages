// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import UIKit

public protocol DogImageView: AnyObject {
    func displayImage(_ image: URL)
    func displayImages(_ images: [URL])
    func showError(_ error: String)
}
