//
//  BQDatasource.swift
//  BooQs
//
//  Created by Leonardo Domingues on 6/7/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import Foundation

class BQDatasource {
    
    private var unsafeDatasource = Array<BQPost>()
    
    private let concurrentQueue: DispatchQueue = {
        let queue = DispatchQueue(
            label: "BQDatasource.queue.concurrent",
            attributes: .concurrent)
        return queue
    }()
    
    var datasource: Array<BQPost> {
        var swapDatasource = Array<BQPost>()
        concurrentQueue.sync {
            swapDatasource.append(contentsOf: unsafeDatasource)
        }
        return swapDatasource
    }
    
    var count: Int = 0
    
    func add(element: BQPost) {
        concurrentQueue.sync {
            unsafeDatasource.append(element)
            count += 1
        }
    }
    
    func add(collection: Array<BQPost>) {
        concurrentQueue.sync {
            unsafeDatasource.append(contentsOf: collection)
            count += collection.count
        }
    }
    
    func drop() {
        concurrentQueue.sync {
            unsafeDatasource.removeAll()
            count = 0
        }
    }
    
    func index(at: Int) -> BQPost? {
        if (at < 0) || (at > unsafeDatasource.count-1) {
            return nil
        }
        var post: BQPost?
        concurrentQueue.sync {
            post = unsafeDatasource[at]
        }
        if let postObject = post {
            return postObject
        }
        return nil
    }
    
}
