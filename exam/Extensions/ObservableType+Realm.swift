//
//  ObservableType+Realm.swift
//  exam
//
//  Created by 11 on 2022/1/9.
//

import RxSwift
import RealmSwift

extension ObservableType {

    public func save<S: Sequence>() -> Observable<Element> where Element == S, S.Iterator.Element: Object {
        return self.do(onNext: { RealmUtils.save($0) })
    }
}

