//
//  BQBook.swift
//  BooQs
//
//  Created by Leonardo Domingues on 6/7/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import Foundation
import UIKit.UIImage

class BQBook {
    
    var title: String
    var isbn: String
    var images: Array<UIImage>
    
    init(title: String, isbn: String, images: Array<UIImage>) {
        self.title = title
        self.isbn = isbn
        self.images = images
    }
    
}
