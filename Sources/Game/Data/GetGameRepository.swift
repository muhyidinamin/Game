//
//  File.swift
//  
//
//  Created by Muhamad Muhyidin Amin on 14/02/21.
//

import Core
import Combine

public struct GetGameRepository<
    GameLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    GameLocaleDataSource.Request == String,
    GameLocaleDataSource.Response == GameEntity,
    RemoteDataSource.Request == String,
    RemoteDataSource.Response == GameResponse,
    Transformer.Request == String,
    Transformer.Response == GameResponse,
    Transformer.Entity == GameEntity,
    Transformer.Domain == GameModel {
  
    
    public typealias Request = String
    public typealias Response = GameModel
    
    private let _localeDataSource: GameLocaleDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: GameLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: String?) -> AnyPublisher<GameModel, Error> {
        guard let request = request else { fatalError("Request cannot be empty") }
        
        return _localeDataSource.get(id: Int(request) ?? 0)
          .flatMap { result -> AnyPublisher<GameModel, Error> in
            if result.desc == "Unknow" || result.desc == "" {
              return self._remoteDataSource.execute(request: request)
                .map { self._mapper.transformResponseToEntity(request: request, response: $0) }
                .catch { _ in self._localeDataSource.get(id: Int(request) ?? 0) }
                .flatMap { self._localeDataSource.update(id: Int(request) ?? 0, entity: $0) }
                .filter { $0 }
                .flatMap { _ in self._localeDataSource.get(id: Int(request) ?? 0)
                  .map { self._mapper.transformEntityToDomain(entity: $0) }
                }.eraseToAnyPublisher()
            } else {
              return self._localeDataSource.get(id: Int(request) ?? 0)
                .map { self._mapper.transformEntityToDomain(entity: $0) }
                .eraseToAnyPublisher()
            }
          }.eraseToAnyPublisher()
    }
}
