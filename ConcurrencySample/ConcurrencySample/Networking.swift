//
//  ConcurrencySample - Networking.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import Foundation
import UIKit

fileprivate enum ImageURL {
    private static let imageIds: [String] = [
        "europe-4k-1369012",
        "europe-4k-1318341",
        "europe-4k-1379801",
        "cool-lion-167408",
        "iron-man-323408"
    ]
    
    static subscript(index: Int) -> URL {
        let id = imageIds[index]
        return URL(string: "https://wallpaperaccess.com/download/"+id)!
    }
}

enum FetchError: Error {
    case badID, badImage, canceled
}

fileprivate func thumbnailURLRequest(for index: Int) -> URLRequest {
    return URLRequest(url: ImageURL[index])
}

func fetchThumbnail(for index: Int, completion: @escaping (UIImage?, Error?) -> Void) {
    let request = thumbnailURLRequest(for: index)
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(nil, error)
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  !(200...299).contains(statusCode) {
            completion(nil, FetchError.badID)
        } else {
            guard let image = UIImage(data: data!) else {
                completion(nil, FetchError.badImage)
                return
            }
            image.prepareThumbnail(of: CGSize(width: 160, height: 90)) { thumbnail in
                guard let thumbnail = thumbnail else {
                    completion(nil, FetchError.badImage)
                    return
                }
                completion(thumbnail, nil)
            }
        }
    }
    task.resume()
}

extension UIImage {
    var thumbnail: UIImage? {
        get async {
            let size = CGSize(width: 160, height: 90)
            return await self.byPreparingThumbnail(ofSize: size)
        }
    }
}

func fetchThumbnail(for index: Int) async throws -> UIImage {
    let request = thumbnailURLRequest(for: index)
    let (data, response) = try await URLSession.shared.data(for: request)
    guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
    (200...299).contains(statusCode) else { throw FetchError.badID }
    let maybeImage = UIImage(data: data)
    guard let thumbnail = await maybeImage?.thumbnail else { throw FetchError.badImage }
    return thumbnail
}
