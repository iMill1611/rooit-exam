//
//  NetworkError.swift
//  exam
//
//  Created by 11 on 2022/1/9.
//

import RxSwift
import Moya
import Moya_ObjectMapper

enum ErrorType: Error {
    case authorise(ErrorModel)
    case badRequest(ErrorModel)
    case client(Response)
    case server(Response)
    case other(MoyaError)
}

extension MoyaError {
    func transform() -> ErrorType {
        do {
            guard let response = response else {
                throw self
            }
            switch response.statusCode {
            case 401, 403:
                return try .authorise(response.mapObject(ErrorModel.self))
            case 400...499:
                return try .badRequest(response.mapObject(ErrorModel.self))
//            case 402, 404...499:
//                return .client(response)
            case 500...599:
                do {
                    return try .badRequest(response.mapObject(ErrorModel.self))
                } catch {
                    return .server(response)
                }
            default:
                throw self
            }
        } catch let error {
            return .other(error as? MoyaError ?? self)
        }
    }
}
