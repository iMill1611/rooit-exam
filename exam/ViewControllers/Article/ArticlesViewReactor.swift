//
//  ArticlesViewReactor.swift
//  exam
//
//  Created by 11 on 2022/1/9.
//

import ReactorKit
import RxSwift
import Resolver

final class ArticlesViewReactor: Reactor {
    enum Action {
        case observeArticles
        case getArticles
    }
    enum Mutation {
        case setArticles([ArticleModel])
    }
    struct State {
        var articles: [ArticleModel] = []
        var isNeedToUpdate = false
    }
    
    internal let initialState = State()
    @Injected internal var articleService: ArticleServiceType
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .observeArticles:
            return articleService.queryArticles().map { .setArticles($0) }
            
        case .getArticles:
            return articleService.getArticles().flatMap { _ in Observable.never() }
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        state.isNeedToUpdate = false
        
        switch mutation {
        case let .setArticles(articles):
            state.isNeedToUpdate = true
            state.articles = articles
        }
        return state
    }
}

