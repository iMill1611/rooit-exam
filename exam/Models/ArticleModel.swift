//
//  ArticleModel.swift
//  exam
//
//  Created by 11 on 2022/1/9.
//

import RealmSwift
import ObjectMapper

class ArticleModel: Object, Mappable {
    @objc dynamic var url: String!
    @objc dynamic var title: String?
    @objc dynamic var urlToImage: String?
    
    var imageUrl: URL? {
        guard let url = urlToImage, !url.isEmpty else {
            return nil
        }
        return URL(string: url)
    }

    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "url"
    }

    func mapping(map: ObjectMapper.Map) {
        url <- map["url"]
        title <- map["title"]
        urlToImage <- map["urlToImage"]
    }
}

