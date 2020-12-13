//
//  DataBaseServise.swift
//  Downloader
//
//  Created by Alex Kharchenko on 30.11.2020.
//

import RealmSwift

protocol DataBaseServise {
    func save(object: [Object], isUpdate: Bool)
    func fetch<object>(object: object.Type) -> [object]? where object: Object
    func addObserve<object>(object: object.Type, complition: @escaping([object]?)->()) where object: Object
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
    
    func fetch<object>(object: object.Type) -> [object]? where object: Object {
        guard let realm = realm else {return nil}
        return Array(realm.objects(object))
    }
    
    func addObserve<object>(object: object.Type, complition: @escaping([object]?)->()) where object: Object {
        guard let realm = realm else { return }
        notificationToken = realm.objects(object).observe { (change) in
            switch change {
            case .initial:
                complition(self.fetch(object: object))
            case .update(_, deletions: _, insertions: _, modifications: _):
                complition(self.fetch(object: object))
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
