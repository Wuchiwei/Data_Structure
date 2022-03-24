//
//  QueueStack.swift
//  DataStructure
//
//  Created by WU CHIH WEI on 2022/3/24.
//

import Foundation

public struct QueueStack<T>: Queue {
    
    private var leftStack: [T] = []
    
    private var rightStack: [T] = []
    
    public init() {}
    
    public var isEmpty: Bool { leftStack.isEmpty && rightStack.isEmpty }
    
    public var peek: T? { leftStack.isEmpty ? rightStack.first : leftStack.last }
    
    public mutating func enqueue(_ element: T) -> Bool {
        rightStack.append(element)
        return true
    }
    
    public mutating func dequeue() -> T? {
        
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        }
        
        return leftStack.popLast()
    }
}

extension QueueStack: CustomStringConvertible {
    public var description: String {
        String(describing: leftStack.reversed() + rightStack)
    }
}
