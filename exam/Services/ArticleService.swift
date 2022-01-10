//
//  ArticleService.swift
//  exam
//
//  Created by 11 on 2022/1/9.
//

import RxSwift
import Moya
import Moya_ObjectMapper
import RxRealm

protocol ArticleServiceType {
    func queryArticles() -> Observable<[ArticleModel]>
    func getArticles() -> Observable<[ArticleModel]>
}

final class ArticleService: BaseService<ArticleApi>, ArticleServiceType {
    
    func queryArticles() -> Observable<[ArticleModel]> {
        return Observable.array(from: realm.objects(ArticleModel.self))
    }
    
    func getArticles() -> Observable<[ArticleModel]> {
        return networking
            .request(.getArticles)
            .observeOn(SerialDispatchQueueScheduler(qos: .background))
            .mapArray(ArticleModel.self, atKeyPath: "articles")
            .catchErrorJustReturn([])
            .observeOn(MainScheduler.asyncInstance)
            .save()
    }
}

