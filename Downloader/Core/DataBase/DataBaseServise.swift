//
//  DataBaseServise.swift
//  Downloader
//
//  Created by Alex Kharchenko on 30.11.2020.
//

import RealmSwift

protocol DataBaseServise {
    func save(object: [Object], isUpdate: Bool)
    func delete(object: Object)
    func delete(objectType: Object.Type, notIdIn: [String])
    func fetch<object>(object: object.Type) -> Results<object>? where object: Object
    func addObserve<object>(object: Results<object>, initial: @escaping([object]?) -> (),
                            update: (([Int], [Int]) -> ())?) where object: Object
    func removeRealmNotificationToken()
}

class RealmDataBaseServise: DataBaseServise {
   
    private var realm: Realm?
    private var notificationToken: NotificationToken?
    
    init() {
        do {
            self.realm = try Realm()
        } catch {
            self.realm = nil
        }
    }
    
    func save(object: [Object], isUpdate: Bool) {
        realmWriteBlock { [weak self] in
            if isUpdate {
                self?.realm?.add(object, update: .modified)
            } else {
                self?.realm?.add(object)
            }
            
        }
    }
    
    func delete(object: Object) {
        realmWriteBlock { [weak self] in
            self?.realm?.delete(object)
        }
    }
    
    func delete(objectType: Object.Type, notIdIn: [String]) {
        guard let objectsToDelete = realm?.objects(objectType).filter("NOT name IN %@", notIdIn) else { return }
        realmWriteBlock { [weak self] in
            self?.realm?.delete(objectsToDelete)
        }
    }
    
    func fetch<object>(object: object.Type) -> Results<object>? where object: Object {
        guard let realm = realm else {return nil}
        return realm.objects(object)
    }
    
    func addObserve<object>(object: Results<object>, initial: @escaping([object]?) -> (),
                            update: (([Int], [Int]) -> ())? = nil) where object: Object {
        notificationToken = object.observe { (change) in
            switch change {
            case .initial:
                initial(Array(object))
            case .update(_, deletions: let deletions, insertions: let insertions, modifications: _):
                update?(deletions, insertions)
            case .error(let error):
                print(error)
            }
        }
    }
    
    func removeRealmNotificationToken() {
        notificationToken?.invalidate()
        notificationToken = nil
    }
    
    private func realmWriteBlock(completion: @escaping ()->()) {
        do {
            try realm?.write {
                completion()
            }
        } catch {
            print("error realm Write Block")
        }
    }
}
