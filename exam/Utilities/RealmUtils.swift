//
//  RealmUtils.swift
//  exam
//
//  Created by 11 on 2022/1/9.
//

import RealmSwift
import RxRealm

class RealmUtils {

    class func config() -> Realm.Configuration {
        return Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    }

    class func realm() -> Realm {
        do {
            let config = RealmUtils.config()
            Realm.Configuration.defaultConfiguration = config
            
            return try Realm()
        } catch let error as NSError {
            fatalError("Error opening realm: \(error)")
        }
    }
}

extension RealmUtils {
    class func save<S: Sequence>(_ objects: S?) where S.Iterator.Element: Object {
        guard let objects = objects else {
            return
        }
        let realm = RealmUtils.realm()
        do {
            try realm.write {
                realm.add(objects, update: .all)
            }
        } catch {
            fatalError("Error save realm array: \(error)")
        }
    }
}
