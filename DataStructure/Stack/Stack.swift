//
//  Stack.swift
//  DataStructure
//
//  Created by WU CHIH WEI on 2022/3/18.
//

import Foundation

struct Stack<Element> {
    
    /*
     Why do we choose array as storage? Not Dictionaty or Set
     -> Stack 的概念是有次序性的，先進後出，Dictionary 與 Set 沒辦法提供次序的資訊，可以 psuh 東西進來，但 pop 不知道要從哪一個開始
     */
    private var storage: [Element]
    
    public init(_ elements: [Element] = []) {
        storage = elements
    }
    
    //MARK: - Public Method
    public mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    @discardableResult
    public mutating func pop() -> Element? {
        storage.popLast()
    }
    
    public func peek() -> Element? {
        storage.last
    }
    
    public func isEmpty() -> Bool {
        storage.last == nil
    }
}

extension Stack: CustomDebugStringConvertible {
    var debugDescription: String {
        """
        -----top----
        \(storage.map{ "\($0)" }.reversed().joined(separator: "\n"))
        ------------
        """
    }
}

extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        storage = elements
    }
}
