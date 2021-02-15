//
//  File.swift
//  
//
//  Created by Muhamad Muhyidin Amin on 14/02/21.
//

import Core
import Combine
import Alamofire
import Foundation

public struct GetGamesRemoteDataSource : DataSource {
    
    public typealias Request = String
    
    public typealias Response = [GameResponse]
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        
        return Future<[GameResponse], Error> { completion in
            
          guard let request = request else { return completion(.failure(URLError.invalidRequest)) }
          print(self._endpoint + request)
          if let url = URL(string: self._endpoint + request) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GamesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                          print("success remote")
                            completion(.success(value.results))
                        case .failure:
                          print("gagal remote")
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
