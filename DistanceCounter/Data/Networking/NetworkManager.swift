//
//  NetworkManager.swift
//  DistanceCounter
//
//  Created by Yuliia Pavlenko on 06/06/2020.
//  Copyright © 2020 Yuliia Pavlenko. All rights reserved.
//

import Foundation

final class NetworkManager {

    static let shared = NetworkManager()
    let session: URLSession

    private init() {
        session = URLSession(configuration: .default)
    }
    
    func getPointWith(latitude: Double, longitute: Double, completion: @escaping (Result<Place, ApiError>) -> Void) {
        let url = URL(string: ApiRouter.pointFor(latitude: latitude, longitute: longitute))!
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let point = try JSONDecoder().decode(Place.self, from: data!)

                completion(.success(point))
            } catch {
                completion(.failure(.invalidData))
            }

        })
        task.resume()
    }
}
