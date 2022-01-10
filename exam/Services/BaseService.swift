//
//  BaseService.swift
//  exam
//
//  Created by 11 on 2022/1/9.
//

import Moya
import RealmSwift
import Resolver

class BaseService<T: TargetType> {
    internal lazy var networking: Networking<T> = Networking<T>()
    @Injected var realm: Realm
}
