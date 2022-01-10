//
//  Config.swift
//  exam
//
//  Created by 11 on 2022/1/9.
//

import Foundation
import RxSwift

struct API {
    static let scheme = "https"
    static let hostname = "newsapi.org"
    
    static let baseUrl = "\(scheme)://\(hostname)/v2"
    static let timeout = TimeInterval(30)
    static let headers = ["Content-Type": "application/json"]
    static let apKey = "f5e2bbceaed1428eb2db45e3a3009595"
}
