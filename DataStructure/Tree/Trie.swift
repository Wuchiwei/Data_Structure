//
//  Trie.swift
//  DataStructure
//
//  Created by WU CHIH WEI on 2022/4/14.
//

import Foundation
import UIKit

public class Trie<CollectionType: Collection> where CollectionType.Element: Hashable {
    
    public typealias Node = TrieNode<CollectionType.Element>
    
    private let root  = Node(key: nil, parent: nil)
    
    public init() {}
}

//MARK: - Insert
extension Trie {
    public func insert(_ collection: CollectionType) {
        
        var current = root
        
        for element in collection {
            
            if current.children[element] == nil {
                current.children[element] = Node(key: element, parent: current)
            }
            
            current = current.children[element]!
        }
        
        current.isTerminating = true
    }
}

//MARK: - Contains
extension Trie {
    public func contains(_ prefix: CollectionType) -> Bool {
        
        var current = root
        
        for element in prefix {
            if current.children[element] == nil {
                return false
            } else {
                current = current.children[element]!
            }
        }
        
        return current.isTerminating
    }
}

//MARK: - Remove
extension Trie {
    public func remove(_ collection: CollectionType) {
        var current = root
        for element in collection {
            guard let child = current.children[element] else {
                return
            }
            
            current = child
        }
        
        current.isTerminating = false
        
        while let parent = current.parent,
              current.children.isEmpty && !current.isTerminating {
            
            parent.children[current.key!] = nil
            current = parent
        }
    }
}

//MARK: - Prefix matching
public extension Trie where CollectionType: RangeReplaceableCollection {
    
    func collections(
        startingWith prefix: CollectionType
    ) -> [CollectionType] {
        
        var current = root
        
        for element in prefix {
            guard let node = current.children[element] else {
                return []
            }
            current = node
        }
        
        return collections(startingWith: prefix, after: current)
    }
    
    private func collections(
        startingWith prefix: CollectionType,
        after node: Node
    ) -> [CollectionType] {
        
        var results: [CollectionType] = []
        
        if node.isTerminating {
            results.append(prefix)
        }
        
        for element in node.children.values {
            var prefix = prefix
            prefix.append(element.key!)
            results.append(contentsOf: collections(startingWith: prefix, after: element))
        }
        
        return results
    }
}
