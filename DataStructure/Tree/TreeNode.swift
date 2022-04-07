//
//  TreeNode.swift
//  DataStructure
//
//  Created by WU CHIH WEI on 2022/4/7.
//

import Foundation

public protocol TreeNode {
    associatedtype Value
    associatedtype AnotherTreeNode: TreeNode where AnotherTreeNode.Value == Value
    
    var value: Value { get set }
    var children: [AnotherTreeNode] { get set }
    var parent: AnotherTreeNode? { get }
}

public class LKTreeNode<T>: TreeNode {
    
    public typealias Value = T
    public typealias AnotherTreeNode = LKTreeNode<T>
    
    public var value: T
    
    public var children: [AnotherTreeNode] = []
    
    public weak var parent: AnotherTreeNode?
    
    public init(_ value: T, parent: AnotherTreeNode?) {
        self.value = value
        self.parent = parent
    }
    
    public func add(_ child: AnotherTreeNode) {
        children.append(child)
    }
}

//MARK: - Depth-First Traversal
extension LKTreeNode {
    public func forEachDepthFirst(visit: (AnotherTreeNode) -> Void) {
        visit(self)
        children.forEach{
            $0.forEachDepthFirst(visit: visit)
        }
    }
}

//MARK: - Level-Order Traversal
extension LKTreeNode {
    public func forEachLevelOrder(visit: (AnotherTreeNode) -> Void) {
        visit(self)
        var queue = QueueArray<AnotherTreeNode>()
        children.forEach{ queue.enqueue($0) }
        while let node = queue.dequeue() {
            visit(node)
            node.children.forEach{ queue.enqueue($0) }
        }
    }
}

//MARK: - Level-Order Traversal print level by level
extension LKTreeNode {
    public func printEachLevel(for tree: AnotherTreeNode) {
        
        var queue = QueueArray<AnotherTreeNode>()
        var nodeLeftInCurrentLevel = 0
        
        queue.enqueue(tree)
        
        while !queue.isEmpty {
            
            nodeLeftInCurrentLevel = queue.count
            
            while nodeLeftInCurrentLevel > 0 {
                guard let node = queue.dequeue() else { break }
                print("\(node.value) ", terminator: "")
                node.children.forEach{ queue.enqueue($0) }
                nodeLeftInCurrentLevel -= 1
            }
            
            print()
        }
    }
}

//MARK: - Search
extension LKTreeNode where T: Equatable {
    public func search(_ value: T) -> AnotherTreeNode? {
        
        var result: AnotherTreeNode?
        
        forEachLevelOrder(visit: {
            if $0.value == value {
                result = $0
            }
        })
        
        return result
    }
}
