//
//  Queue.swift
//  DataStructure
//
//  Created by WU CHIH WEI on 2022/3/23.
//

import Foundation

public protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
}
