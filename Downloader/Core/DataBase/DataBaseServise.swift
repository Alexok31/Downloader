//
//  DataBaseServise.swift
//  Downloader
//
//  Created by Alex Kharchenko on 30.11.2020.
//

import RealmSwift

protocol DataBaseServise {
    func update(object: [Object])
    func fetch(object: Object.Type) -> [Object]?
    func addObserve(object: Object.Type, complition: @escaping([Object]?)->())
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
    
    func update(object: [Object]) {
        realmWriteBlock { [weak self] in
            self?.realm?.add(object, update: .modified)
        }
    }
    
    func fetch(object: Object.Type) -> [Object]? {
        guard let realm = realm else {return nil}
        return Array(realm.objects(object.self))
    }
    
    func addObserve(object: Object.Type, complition: @escaping([Object]?)->()) {
        guard let realm = realm else { return }
        notificationToken = realm.objects(object.self).observe { (change) in
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
