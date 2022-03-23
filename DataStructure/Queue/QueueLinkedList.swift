//
//  QueueLinkedList.swift
//  DataStructure
//
//  Created by WU CHIH WEI on 2022/3/23.
//

import Foundation

class QueueLinkedList<T>: Queue {
    
    typealias Element = T
    
    private let linkedList = LKDoublyLinkedList<T>()
    
    init() {}
    
    var isEmpty: Bool { linkedList.isEmpty }
    
    var peek: T? { linkedList.peek }
    
    @discardableResult
    func enqueue(_ element: T) -> Bool {
        linkedList.append(element)
        return true
    }
    
    @discardableResult
    func dequeue() -> T? {
        return linkedList.pop()
    }
}

extension QueueLinkedList: CustomStringConvertible {
    
    var description: String {
        String(describing: linkedList)
    }
}
