//
//  BQPost.swift
//  BooQs
//
//  Created by Leonardo Domingues on 6/7/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import Foundation
import UIKit.UIImage

class BQPost {
    
    var id: String
    var user: BQUser
    var book: BQBook
    var category: Category?
    
    enum Category {
        case sell
        case borrow
        case donate
    }
    
    init(id: String, user: BQUser, book: BQBook, category: Category) {
        self.id = id
        self.user = user
        self.book = book
        self.category = category
    }
    
    func imagePreview() -> UIImage? {
        if book.images.count > 0 {
            return book.images[0]
        }
        return nil
    }
    
}
