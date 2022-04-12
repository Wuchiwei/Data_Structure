//
//  AVL Tree.swift
//  DataStructure
//
//  Created by WU CHIH WEI on 2022/4/12.
//

import Foundation

public struct AVLTree<T: Comparable>: BinarySearchTree {
    
    typealias Element = T
    
    public private(set) var root: LKBinaryNode<T>?
    
    public init() {}
}

extension AVLTree: CustomStringConvertible {
    
    public var description: String {
        guard let root = root else { return "empty tree" }
        return String(describing: root)
    }
}

//MARK: - Insert
extension AVLTree {
    
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
        
        //Add Balance
        let balanceNode = balance(node)
        
        return balanceNode
    }
}

//MARK: - Search
extension AVLTree {
    
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

extension AVLTree {
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
        
        //Add Balance
        let balanceNode = balance(node)
        
        return balanceNode
    }
}

//MARK: - Balance
extension AVLTree {
    private func balance(_ node: LKBinaryNode<T>) -> LKBinaryNode<T> {
        switch node.balanceFactor {
        case 2...:
            
            guard let leftChild = node.leftChild else {
                return node
            }
            
            if leftChild.balanceFactor < 0 {
                return leftRightRotation(node)
            }
            return rightRotate(node)
            
        case Int.min...(-2):
            
            guard let rightChild = node.rightChild else {
                return node
            }
            
            if rightChild.balanceFactor > 0 {
                return rightLeftRotation(node)
            }
            return leftRotate(node)
        default:
            return node
        }
    }
}

//MARK: - Left Rotation
extension AVLTree {
    private func leftRotate(_ node: LKBinaryNode<T>) -> LKBinaryNode<T> {
        
        let pivot = node.rightChild!
        
        node.rightChild = pivot.leftChild
        
        pivot.leftChild = node
        
        return pivot
    }
}

//MARK: - Right Rotation
extension AVLTree {
    private func rightRotate(_ node: LKBinaryNode<T>) -> LKBinaryNode<T> {
        
        let pivot = node.leftChild!
        
        node.leftChild = pivot.rightChild
        
        pivot.rightChild = node
        
        return pivot
    }
}

//MARK: - Right-Left Rotation
extension AVLTree {
    private func rightLeftRotation(_ node: LKBinaryNode<T>) -> LKBinaryNode<T> {
        node.rightChild = rightRotate(node.rightChild!)
        return leftRotate(node)
    }
}

//MARK: - Left-Right Rotation
extension AVLTree {
    private func leftRightRotation(_ node: LKBinaryNode<T>) -> LKBinaryNode<T> {
        node.leftChild = leftRotate(node.leftChild!)
        return rightRotate(node)
    }
}
