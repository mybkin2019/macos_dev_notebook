//
//  Person.swift
//  MacosDevNotebook
//
//  Created by mabs on 02/12/2022.
//

import Foundation

import RealmSwift

// 沙盒设置 NO
class Person: Object {
    @Persisted var _id: String
    @Persisted var name: String
    @Persisted var age: Int
    @Persisted var pets: List<Dog>
    
    // @Persisted var job: String
    // 如果需要增加属性, 改变数据结构, 需要改变config schemaVersion = 1 -> 2
    // 创建Realm()实例的时候:
    // let config = Realm.Configuration(schemaVersion: 2)
    // Realm.Configuration.defaultConfiguration = config
    // let rm = try! Realm(configuration: config)
    
    // 自定义了init方法后必须显性声明 以下init()
    // ⚠️否则报错
    override init() {
    }
    
    init(_id: String = UUID().uuidString, name: String, age: Int, pets: List<Dog> = List()) {
        self._id = _id
        self.name = name
        self.age = age
        self.pets = pets
    }
}
