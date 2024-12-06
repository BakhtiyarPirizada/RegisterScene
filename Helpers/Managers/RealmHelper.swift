//
//  RealmHelper.swift
//  RegisterScene
//
//  Created by Bakhtiyar Pirizada on 04.11.24.
//
import RealmSwift
import UIKit

final class RealmHelper {
    static let instance = RealmHelper()
    private init() {}
  
    let realm = try! Realm()
    
    //MARK: Add
    func addObject<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("Error adding object: \(error.localizedDescription)")
        }
    }
    
    //MARK: Update
    func updateObject(_ block: () -> Void) {
        do {
            try realm.write {
                block()
            }
        } catch {
            print("Error updating object: \(error.localizedDescription)")
        }
    }
    
    //MARK: Delete
    func deleteObject<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("Error deleting object: \(error.localizedDescription)")
        }
    }
    
    //MARK: Get List
    func getList<T: Object>(of type: T.Type) -> Results<T> {
        return realm.objects(type)
    }
    
    //MARK: Delete all
    func deleteAllObjects<T: Object>(of type: T.Type) {
        do {
            try realm.write {
                let objects = realm.objects(type)
                realm.delete(objects)
            }
        } catch {
            print("Error deleting all objects of type \(type): \(error.localizedDescription)")
        }
    }
}
