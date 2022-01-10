//
//  ErrorModel.swift
//  exam
//
//  Created by 11 on 2022/1/9.
//

import RealmSwift
import ObjectMapper

class ErrorModel: Object, Mappable {
    @objc dynamic var status: Int = 0
    @objc dynamic var message: String = ""

    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }

    func mapping(map: ObjectMapper.Map) {
        status <- map["status"]
        message <- map["message"]
    }
}

