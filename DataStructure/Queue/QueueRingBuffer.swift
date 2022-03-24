//
//  QueueRingBuffer.swift
//  DataStructure
//
//  Created by WU CHIH WEI on 2022/3/24.
//

import Foundation

struct QueueRingBuffer<T>: Queue {
    
    private var buffer: LKRingBuffer<T>
    
    init(size: Int) {
        buffer = LKRingBuffer<T>(size: size)
    }
    
    var isEmpty: Bool { buffer.isEmpty }
    
    var peek: T? { buffer.peek }
    
    mutating func enqueue(_ element: T) -> Bool {
        buffer.write(element)
    }
    
    mutating func dequeue() -> T? {
        buffer.read()
    }
}

extension QueueRingBuffer: CustomStringConvertible {
    public var description: String {
        String(describing: buffer)
    }
}
