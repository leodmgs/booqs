//
//  BQUser.swift
//  BooQs
//
//  Created by Leonardo Domingues on 6/7/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import Foundation

struct BQAddress {
    var street: String
    var number: Int
    var district: String
    var city: String
    var state: String
    var zipCode: String
}

class BQUser {
    
    var name: String
    var phone: String
    var address: BQAddress
    var posts: Array<BQPost>
    
    init(name: String, phone: String, address: BQAddress, posts: Array<BQPost>) {
        self.name = name
        self.phone = phone
        self.address = address
        self.posts = posts
    }
    
}
