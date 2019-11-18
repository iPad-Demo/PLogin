//
//  Config.swift
//  PLogin
//
//  Created by os on 2019/10/15.
//  Copyright © 2019 os. All rights reserved.
//

import UIKit
import RealmSwift

class PRealm: NSObject {

    class func configRealm(){
        var docPath = ""
        #if TARGET_OS_IPHONE
            // On iOS the Documents directory isn't user-visible, so put files there
            docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        #else
            docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        #endif
        let dbPath = docPath.appending("/PLogin.realm")
        let config = Realm.Configuration(
            fileURL: URL.init(string: dbPath), // 获取预植数据库文件的 URL
            inMemoryIdentifier: nil,
            syncConfiguration: nil,
            encryptionKey: nil,
            readOnly: false,//是否以只读模式打开该文件
            schemaVersion: 1,
            migrationBlock: { (migration, oldSchemaVersion) in
                if oldSchemaVersion < 0 {

                }

        },
            deleteRealmIfMigrationNeeded: false,
            shouldCompactOnLaunch: nil, objectTypes: nil
        )

        Realm.Configuration.defaultConfiguration = config

        Realm.asyncOpen { (realm, error) in
            if let _ = realm {
                print("Realm 服务器配置成功!")
            }else if let error = error {
                print("Realm 数据库配置失败：\(error.localizedDescription)")
            }
        }
    }

}
