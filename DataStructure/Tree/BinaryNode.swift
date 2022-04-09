//
//  BinaryNode.swift
//  DataStructure
//
//  Created by WU CHIH WEI on 2022/4/8.
//

import Foundation
import UIKit

public protocol BinaryNode: CustomStringConvertible {
    associatedtype Element
    associatedtype ChildNode: BinaryNode where ChildNode.Element == Element
    
    var value: Element { get set }
    var leftChild: ChildNode? { get set }
    var rightChild: ChildNode? { get set }
}

extension BinaryNode {

  public var description: String {
    diagram(for: self as? ChildNode)
  }

  private func diagram(for node: ChildNode?,
                       _ top: String = "",
                       _ root: String = "",
                       _ bottom: String = "") -> String {
    guard let node = node else {
      return root + "nil\n"
    }
    if node.leftChild == nil && node.rightChild == nil {
      return root + "\(node.value)\n"
    }
    return diagram(for: node.rightChild as? ChildNode,
                   top + " ", top + "┌──", top + "│ ")
         + root + "\(node.value)\n"
         + diagram(for: node.leftChild as? ChildNode,
                   bottom + "│ ", bottom + "└──", bottom + " ")
  }
}

final public class LKBinaryNode<E>: BinaryNode {
    
    public typealias Element = E
    
    public typealias ChildNode = LKBinaryNode<E>
    
    public var value: Element
    
    public var leftChild: ChildNode?
    
    public var rightChild: ChildNode?
    
    public init(value: Element) {
        self.value = value
    }
}

//MARK: - In-Order Traversal
extension LKBinaryNode {
    public func inOrderTraversal(visit: (Element) -> Void) {
        leftChild?.inOrderTraversal(visit: visit)
        visit(value)
        rightChild?.inOrderTraversal(visit: visit)
    }
}

//MARK: - Pre-Order Traversal
extension LKBinaryNode {
    public func preOrderTraversal(visit: (Element) -> Void) {
        visit(value)
        leftChild?.preOrderTraversal(visit: visit)
        rightChild?.preOrderTraversal(visit: visit)
    }
}

//MARK: - Post-Order Traversal
extension LKBinaryNode {
    public func postOrderTraversal(visit: (Element) -> Void) {
        leftChild?.postOrderTraversal(visit: visit)
        rightChild?.postOrderTraversal(visit: visit)
        visit(value)
    }
}

//MARK - Height of Tree
extension LKBinaryNode {
    func height() -> Int {
        switch (leftChild?.height(), rightChild?.height()) {
        case (nil, nil):
            return 0
        case (nil, .some(let right)):
            return right + 1
        case (.some(let left), nil):
            return left + 1
        case (.some(let left), .some(let right)):
            return max(left, right) + 1
        }
    }
    
    func anotherHeightMethod(node: LKBinaryNode?) -> Int {
        guard let node = node else {
            return -1
        }
        return 1 + max(anotherHeightMethod(node: node.leftChild), anotherHeightMethod(node: node.rightChild))
    }
}

extension LKBinaryNode {
    
    static func deserialize(from values: [Element?]) -> LKBinaryNode? {
        var elements = Array(values.reversed())
        return deserialize(from: &elements)
    }
    
    private static func deserialize(from values: inout [Element?]) -> LKBinaryNode? {
        
        guard values.isEmpty == false,
              let element = values.removeLast()
        else {
            return nil
        }
        
        let node = LKBinaryNode(value: element)
        node.leftChild = deserialize(from: &values)
        node.rightChild = deserialize(from: &values)
        return node
    }
    
    static func serialize(from tree: LKBinaryNode) -> [Element?] {
        var array: [Element?] = []
        tree.preOrderTraversalWithNil(visit: { array.append($0) })
        return array
    }
    
    private func preOrderTraversalWithNil(visit: (Element?) -> Void) {
        
        visit(value)
        
        if let left = leftChild {
            left.preOrderTraversalWithNil(visit: visit)
        } else {
            visit(nil)
        }
        
        if let right = rightChild {
            right.preOrderTraversalWithNil(visit: visit)
        } else {
            visit(nil)
        }
    }
}
