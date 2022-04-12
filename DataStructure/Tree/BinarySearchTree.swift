//
//  BinarySearchTree.swift
//  DataStructure
//
//  Created by WU CHIH WEI on 2022/4/12.
//

import Foundation

protocol BinarySearchTree {
    associatedtype Element: Comparable
    associatedtype Node: BinaryNode where Node.Element == Element
    var root: Node? { get }
}

public struct LKBinarySearchTree<T: Comparable>: BinarySearchTree {
    
    typealias Element = T
    
    public private(set) var root: LKBinaryNode<T>?
    
    public init() {}
}

extension LKBinarySearchTree: CustomStringConvertible {
    
    public var description: String {
        guard let root = root else { return "empty tree" }
        return String(describing: root)
    }
}

//MARK: - Insert
extension LKBinarySearchTree {
    
    public mutating func insert(_ value: T) {
        root = insert(from: root, value: value)
    }
    
    private func insert(from node: LKBinaryNode<T>?, value: T) -> LKBinaryNode<T> {
        
        guard let node = node else {
            return LKBinaryNode(value: value)
        }
        
        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        
        return node
    }
}

//MARK: - Search
extension LKBinarySearchTree {
    
    public func contains(_ value: T) -> Bool {
        
        var current = root
        
        while let node = current {
            if value == node.value {
                return true
            } else if value < node.value {
                current = node.leftChild
            } else {
                current = node.rightChild
            }
        }
        
        return false
    }
    
    public func search(value: T) -> LKBinaryNode<T>? {
        return search(from: root, value: value)
    }
    
    private func search(from node: LKBinaryNode<T>?, value: T) -> LKBinaryNode<T>? {
        
        guard let node = node else {
            return nil
        }
        
        if value == node.value {
            return node
        } else if value < node.value {
            return search(from: node.leftChild, value: value)
        } else {
            return search(from: node.rightChild, value: value)
        }
    }
}


//MARK: - Remove
private extension LKBinaryNode {
    var min: LKBinaryNode<Element> {
        return leftChild?.min ?? self
    }
}

extension LKBinarySearchTree {
    public mutating func remove(_ value: T) {
        root = remove(from: root, value)
    }
    
    private mutating func remove(
        from node: LKBinaryNode<T>?,
        _ value: T
    ) -> LKBinaryNode<T>? {
    
        guard let node = node else {
            return nil
        }
        
        if value == node.value {
            
            switch (node.leftChild, node.rightChild) {
            case (nil, nil): return nil
            case (.some, nil): return node.leftChild
            case (nil, .some): return node.rightChild
            case (.some, .some):
                node.value = node.rightChild!.min.value
                node.rightChild = remove(from: node.rightChild, node.value)
            }
        } else if value < node.value {
            node.leftChild = remove(from: node.leftChild, value)
        } else {
            node.rightChild = remove(from: node.rightChild, value)
        }
        
        return node
    }
}
