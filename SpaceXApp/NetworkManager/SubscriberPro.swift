//
//  SubscriberPro.swift
//  SpaceXApp
//
//  Created by Muralidhar reddy Kakanuru on 12/11/24.


import Foundation
import UIKit


// MARK: - Protocol
protocol APIServiceProtocol {
    func fetchData<T: Codable>(url: String) async throws -> T 
    func fetchImage(url: String) async throws -> UIImage
}

// MARK: - SubscribeNetwork Class
class APIService: APIServiceProtocol {
    static let shared = APIService()
    private let urlSession: URLSession
    private var imageCache = NSCache<NSString, UIImage>()

    private init() {
        let config = URLSessionConfiguration.default
        self.urlSession = URLSession(configuration: config)
    }

    // MARK: - Fetch Data
    func fetchData<T: Codable>(url: String) async throws -> T {
        guard let serverURL = URL(string: url) else {
            throw NetworkError.invalidURL
        }

            let (data, _) = try await urlSession.data(from: serverURL)

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch let decodingError as DecodingError {
                throw NetworkError.decodingError(decodingError.localizedDescription)
            }
    }

    // MARK: - Fetch Image
    func fetchImage(url: String) async throws -> UIImage {
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            return cachedImage
        }

        guard let serverURL = URL(string: url) else {
            throw NetworkError.invalidURL
        }

        do {
            let (data, _) = try await urlSession.data(from: serverURL)
            

            guard let image = UIImage(data: data) else {
                throw NetworkError.invalidImageData
            }

            imageCache.setObject(image, forKey: url as NSString)
            return image
        } catch {
            throw NetworkError.networkFailure(error.localizedDescription)
        }
    }
}
