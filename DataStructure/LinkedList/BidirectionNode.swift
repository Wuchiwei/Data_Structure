//
//  DoubleNode.swift
//  DataStructure
//
//  Created by WU CHIH WEI on 2022/3/23.
//

import Foundation

public class BidirectionNode<Value> {
    
    var value: Value
    
    weak var previous: BidirectionNode<Value>?
    
    var next: BidirectionNode<Value>?
    
    init(value: Value, previous: BidirectionNode<Value>? = nil, next: BidirectionNode<Value>? = nil) {
        self.value = value
        self.previous = previous
        self.next = next
    }
}

extension BidirectionNode: CustomDebugStringConvertible {
    public var debugDescription: String {
        guard let next = next else {
            return "\(value)"
        }
        return "\(value) -> " + String(describing: next)
    }
}
