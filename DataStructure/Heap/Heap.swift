//
//  Heap.swift
//  DataStructure
//
//  Created by WU CHIH WEI on 2022/4/15.
//

import Foundation

struct Heap<Element: Equatable> {
    var elements: [Element]
    let sort: (Element, Element) -> Bool
    
    init(
        sort: @escaping (Element, Element) -> Bool,
        elements: [Element] = []
    ) {
        self.sort = sort
        self.elements = elements
        
        if !elements.isEmpty {
            for index in stride(from: (elements.count - 1) / 2, through: 0, by: -1) {
                shitDown(from: index)
            }
        }
    }
}

extension Heap {
    
    var isEmpty: Bool {
        elements.isEmpty
    }
    
    var count: Int { elements.count }
    
    func peek() -> Element? { elements.first }
    
    func leftChildIndex(ofParentAt index: Int) -> Int {
        index * 2 + 1
    }
    
    func rightChildIndex(ofParentAt index: Int) -> Int {
        index * 2 + 2
    }
    
    func parentIndex(ofChildAt index: Int) -> Int {
        (index - 1) / 2
    }
}

//MARK: - Helper method
extension Heap {
    fileprivate mutating func shitDown(from index: Int = 0) {
        
        guard index < count else { return }
        
        let leftIndex = leftChildIndex(ofParentAt: index)
        let rightIndex = rightChildIndex(ofParentAt: index)
        
        var leftChild: Element?
        var rightChild: Element?
        
        if leftIndex < count {
            leftChild = elements[leftIndex]
        }
        
        if rightIndex < count {
            rightChild = elements[rightIndex]
        }
        
        let currentValue = elements[index]
        
        switch (leftChild, rightChild) {
        case (.some(let leftValue), .some(let rightValue)):
            if sort(currentValue, leftValue) && sort(currentValue, rightValue) {
                return
            }
            if sort(leftValue, rightValue) {
                elements.swapAt(index, leftIndex)
                shitDown(from: leftIndex)
            } else {
                elements.swapAt(index, rightIndex)
                shitDown(from: rightIndex)
            }
        case (.some, .none):
            if sort(currentValue, leftChild!) {
                return
            }
            elements.swapAt(index, leftIndex)
            shitDown(from: leftIndex)
        case (.none, .some):
            if sort(currentValue, rightChild!) {
                return
            }
            elements.swapAt(index, rightIndex)
            shitDown(from: rightIndex)
        case (.none, .none): return
        }
    }
    
    private mutating func shitUp(from index: Int) {
        
        let parentIndex = parentIndex(ofChildAt: index)
        
        guard index < count,
              index >= 0,
              parentIndex < count,
              parentIndex >= 0
        else {
            return
        }
        
        let parent = elements[parentIndex]
        let current = elements[index]
        
        if sort(current, parent) {
            elements.swapAt(index, parentIndex)
            shitUp(from: parentIndex)
        }
    }
}

//MARK: - Remove
extension Heap {
    
    mutating func remove() -> Element? {
        
        defer {
            shitDown()
        }
        
        guard !isEmpty else {
            return nil
        }

        elements.swapAt(0, count - 1)
        let result = elements.removeLast()
        return result
    }
    
    mutating func remove(at index: Int) -> Element? {
        
        defer {
            shitDown(from: index)
            shitUp(from: index)
        }
        
        guard index < elements.count else { return nil }
        elements.swapAt(index, elements.count - 1)
        let result = elements.removeLast()
        return result
    }
}

//MARK: Insert
extension Heap {
    mutating func insert(_ value: Element) {
        defer {
            shitUp(from: elements.count - 1)
        }
        elements.append(value)
    }
}

//MARK: - Search
extension Heap {
    func index(of element: Element, startingAt i: Int) -> Int? {
        if i > count {
            return nil
        }
        
        if sort(element, elements[i]) {
            return nil
        }
        
        if elements[i] == element {
            return i
        }
        
        if let index = index(of: element, startingAt: leftChildIndex(ofParentAt: i)) {
            return index
        }
        
        if let index = index(of: element, startingAt: rightChildIndex(ofParentAt: i)) {
            return index
        }
        
        return nil
    }
}
