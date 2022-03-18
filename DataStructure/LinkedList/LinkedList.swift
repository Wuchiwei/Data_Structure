//
//  LinkedList.swift
//  DataStructure
//
//  Created by WU CHIH WEI on 2022/3/18.
//

import Foundation

public struct LinkedList<Value> {
    
    public var head: Node<Value>?
    public var tail: Node<Value>?
    
    public init() {}
    
    public var isEmpty: Bool { head == nil }
    
    //MARK: - Add Action
    public mutating func push(_ value: Value) {
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(_ value: Value) {
        
        guard !isEmpty else {
            push(value)
            return
        }
        
        let node = Node(value: value, next: nil)
        self.tail?.next = node
        self.tail = node
    }
    
    @discardableResult
    public mutating func insert(
        _ value: Value,
        after node: Node<Value>
    ) -> Node<Value> {
    
        guard node !== tail else {
            append(value)
            return tail!
        }
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
    
    //MARK: - Search Action
    public func node(at index: Int) -> Node<Value>? {
        var currentIndex = 0
        var currentNode: Node<Value>? = head
        
        while currentIndex < index && currentNode != nil {
            currentIndex += 1
            currentNode = currentNode?.next
        }
        
        return currentNode
    }
    
    //MARK: - Remove Action
    @discardableResult
    public mutating func pop() -> Value? {
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    @discardableResult
    public mutating func removeLast() -> Value? {
        guard head !== tail else {
            return pop()
        }
        
        var previousNode = head!
        var currentNode = head!
        
        while let next = currentNode.next {
            previousNode = currentNode
            currentNode = next
        }
        
        previousNode.next = nil
        tail = previousNode
        
        return currentNode.value
    }
    
    @discardableResult
    public mutating func remove(after node: Node<Value>) -> Value? {
        
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        
        return node.next?.value
    }
}

extension LinkedList: CustomStringConvertible {
    
    public var description: String {
        guard let head = head else {
            return "Empty list"
        }
        return String(describing: head)
    }
}
