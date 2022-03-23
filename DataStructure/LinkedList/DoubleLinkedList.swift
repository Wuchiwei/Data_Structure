//
//  DoubleLinkedList.swift
//  DataStructure
//
//  Created by WU CHIH WEI on 2022/3/23.
//

import Foundation

public protocol DoubleLinkedList {
    
    associatedtype Element
    
    mutating func push(_ element: Element)
    mutating func append(_ element: Element)
    mutating func insert(_ element: Element, after node: BidirectionNode<Element>)
    
    mutating func pop() -> Element?
    mutating func remove(_ node: BidirectionNode<Element>)
    mutating func removeLast() -> BidirectionNode<Element>?
    
    var isEmpty: Bool { get }
    var peek: Element? { get }
}

class LKDoubleLinkedList<T>: DoubleLinkedList {
    
    typealias Element = T
    
    //MARK: - Private Properties
    private var head: BidirectionNode<T>?
    
    private var tail: BidirectionNode<T>?
    
    //MARK: - Public Properties
    var isEmpty: Bool { head == nil }
    
    var peek: T? { head?.value}
    
    init(){ }
    
    //MARK: - Public Method
    //MARK: - Add Action
    func push(_ element: T) {
        
        let newNode = BidirectionNode<T>(value: element)
        
        guard !isEmpty else {
            head = newNode
            tail = newNode
            return
        }
        
        newNode.next = head!
        head?.previous = newNode
        
        head = newNode
    }
    
    func append(_ element: T) {
        guard !isEmpty else {
            push(element)
            return
        }
        
        let newNode = BidirectionNode<T>(value: element)
        
        newNode.previous = tail!
        tail?.next = newNode
        
        tail = newNode
    }
    
    func insert(
        _ element: Element,
        after node: BidirectionNode<T>
    ) {
        let newNode = BidirectionNode(value: element)
        newNode.previous = node
        newNode.next = node.next
        
        node.next = newNode
        
        newNode.next?.previous = newNode
        
        if node === tail {
            tail = newNode
        }
    }
    
    //MARK: - Remove Action
    @discardableResult
    func pop() -> Element? {
        guard !isEmpty else {
            return nil
        }
        
        let removeNode = head!
        
        head = removeNode.next
        head?.previous = nil
        
        removeNode.next = nil
        
        if head === nil {
            tail = nil
        }
        
        return removeNode.value
    }
    
    func remove(_ node: BidirectionNode<T>) {
        
        guard !isEmpty else { return }
        
        guard node !== head else {
            pop()
            return
        }
        
        guard node !== tail else {
            removeLast()
            return
        }
        
        let previous = node.previous
        let next = node.next
        
        previous?.next = next
        next?.previous = previous
    }
    
    @discardableResult
    func removeLast() -> BidirectionNode<T>? {
        guard !isEmpty else {
            return nil
        }
        
        let removeNode = tail
        
        tail = removeNode?.previous
        tail?.next = nil
        
        removeNode?.previous = nil
        
        if tail === nil {
            head = nil
        }
        
        return removeNode
    }
}
