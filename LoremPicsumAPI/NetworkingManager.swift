//
//  NetworkingManager.swift
//  LoremPicsumAPI
//
//  Created by Field Employee on 12/10/20.
//

import Foundation

enum NetworkError: Error {
    case invalidURLString
    case badData
}

final class NetworkingManager {
    static let shared = NetworkingManager()
    private init() { }
    func getDecodedObject<T: Decodable>(from urlString: String, completion: @escaping (T?, Error?) -> Void) {
            guard let url = URL(string: urlString) else {
                completion(nil, NetworkError.invalidURLString)
                return
            }
            URLSession.shared.dataTask(with:url) {
                (data, response, error) in
                guard let data = data else {
                    completion(nil, error)
                    return
                }
                do {
                    let decodedObject = try
                    JSONDecoder().decode(T.self, from: data)
                    completion(decodedObject, nil)
                } catch {
                 completion(nil, error)
                }
            }.resume()
        }

    func getImageData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, error)
        }.resume()
    }
}

