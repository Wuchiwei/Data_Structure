//
//  QueueArray.swift
//  DataStructure
//
//  Created by WU CHIH WEI on 2022/3/23.
//

import Foundation

public struct QueueArray<T>: Queue {
    
    private var array: [T] = []
    
    init() { }
    
    //MARK: - Action
    @discardableResult
    public mutating func dequeue() -> T? {
        isEmpty ? nil : array.removeFirst()
    }
    
    @discardableResult
    public mutating func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }
    
    public var peek: T? { array.first }
    
    public var isEmpty: Bool { array.isEmpty }
}

extension QueueArray: CustomStringConvertible {
    
    public var description: String {
        String(describing: array)
    }
}
