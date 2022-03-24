//
//  RingBuffer.swift
//  DataStructure
//
//  Created by WU CHIH WEI on 2022/3/24.
//

import Foundation

/*
 不覆蓋尚未讀取的資料
 */
public protocol RingBuffer {
    associatedtype Element
    init(size: Int)
    var isEmpty: Bool { get }
    var isFull: Bool { get }
    mutating func write(_ element: Element) -> Bool
    mutating func read() -> Element?
}

public struct LKRingBuffer<T>: RingBuffer {
    
    private enum Action {
        case read
        case write
        case none
    }
    
    private var array: [T?]

    private var readIndex: Int = 0
    
    private var writeIndex: Int = 0
    
    private var lastAction: Action = .none
    
    //MARK: - Public Method
    public init(size: Int) {
        self.array = Array(repeating: nil, count: size)
    }
    
    public var isEmpty: Bool {
        switch lastAction {
        case .read:
            return readIndex == writeIndex
        case .write:
            return false
        case .none:
            return true
        }
    }
    
    public var isFull: Bool {
        switch lastAction {
        case .read:
            return false
        case .write:
            return readIndex == writeIndex
        case .none:
            return false
        }
    }
    
    public mutating func read() -> T? {
        
        defer {
            if !isEmpty {
                lastAction = .read
                if (readIndex + 1) >= array.count {
                    readIndex = 0
                } else {
                    readIndex = readIndex + 1
                }
            }
        }
        
        guard !isEmpty else { return nil }
        return array[readIndex]
    }
    
    public mutating func write(_ element: T) -> Bool {
        
        defer {
            if !isFull {
                lastAction = .write
                if (writeIndex + 1) >= array.count {
                    writeIndex = 0
                } else {
                    writeIndex = writeIndex + 1
                }
            }
        }
        
        guard !isFull else { return false }
        array[writeIndex] = element
        return true
    }
}

extension LKRingBuffer: CustomStringConvertible {
    public var description: String {
        return """
        ---------Ring Buffer---------
            Read Index: \(readIndex)
            Write Index: \(writeIndex)
            Content: \(array)
        """
    }
}
