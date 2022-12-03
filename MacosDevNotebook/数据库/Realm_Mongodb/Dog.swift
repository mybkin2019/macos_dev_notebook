//
//  Dog.swift
//  MacosDevNotebook
//
//  Created by mabs on 03/12/2022.
//

import Foundation
import RealmSwift

class Dog: Object {
    @Persisted var _id: String
    @Persisted var name: String
    @Persisted var age: Int
    
    override init() {
        
    }
    
    init(_id: String = UUID().uuidString, name: String, age: Int) {
        self._id = _id
        self.name = name
        self.age = age
    }
}
