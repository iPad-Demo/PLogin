//
//  Person.swift
//  PLogin
//
//  Created by os on 2019/10/15.
//  Copyright © 2019 os. All rights reserved.
//

import UIKit
import RealmSwift

class Person: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    @objc dynamic var id = 0

    //设置主键
    override class func primaryKey() -> String? {
        return "id"
    }
}
