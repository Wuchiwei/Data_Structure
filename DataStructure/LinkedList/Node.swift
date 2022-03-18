//
//  Node.swift
//  DataStructure
//
//  Created by WU CHIH WEI on 2022/3/18.
//

import Foundation

public class Node<Value> {
    
    public var value: Value
    public var next: Node<Value>?
    
    init(value: Value, next: Node<Value>? = nil) {
        self.value = value
        self.next = next
    }
}

extension Node: CustomDebugStringConvertible {
    public var debugDescription: String {
        guard let next = next else {
            return "\(value)"
        }
        return "\(value) -> " + String(describing: next)
    }
}
