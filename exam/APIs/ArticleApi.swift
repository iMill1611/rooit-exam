//
//  ArticleApi.swift
//  exam
//
//  Created by 11 on 2022/1/9.
//

import Moya

enum ArticleApi {
    case getArticles
}

extension ArticleApi: TargetType {
    var baseURL: URL {
        return URL(string: API.baseUrl + "/top-headlines")!
    }
    
    var path: String {
        switch self {
        case .getArticles:
            return ""
        }
    }
    
    var method: Method {
        switch self {
        case .getArticles:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getArticles:
            return .requestParameters(parameters: ["country": "us", "apiKey": API.apKey], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return API.headers
    }
}

