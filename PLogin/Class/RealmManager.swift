//
//  RealmManager.swift
//  PLogin
//
//  Created by os on 2019/10/15.
//  Copyright © 2019 os. All rights reserved.
//

import UIKit
import RealmSwift


class RealmManager: NSObject {
    static let shared = RealmManager()
    fileprivate override init() {}
    
    var realm: Realm{
        return try! Realm()
    }
    
    //增
    func add <T> (_ model:T,_ id:String? = nil) {
        do {
            try realm.write {
                realm.add(model as! Object)
            }
        }catch{}
    }
    
    //查
    func query <T> (_ model:T,filter:String? = nil) -> [T]{
        var result: Results<Object>
        if filter != nil {
            result = realm.objects(T.self as! Object.Type).filter(filter!)
        } else {
            result = realm.objects(T.self as! Object.Type)
        }
        
        guard result.count > 0 else { return [] }
        var modelArr = [T]()
        for item in result{
            modelArr.append(item as! T)
        }
        return modelArr
    }
    //删
    func delete <T> (_ model:T){
        do {
            try realm.write {
                realm.delete(model as! Object)
            }
        } catch {}
    }
    //删除整张表
    func deleteList <T> (_ model:T){
        do{
            try realm.write {
                realm.delete(realm.objects((T.self as! Object.Type).self))
            }
        } catch {}
    }
    
    //改
    func update <T> (_ model:T){
        do{
            try realm.write {
                realm.add(model as! Object, update: Realm.UpdatePolicy.modified)
            }
        }catch{}
    }
}
