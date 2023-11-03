//
//  Node.swift
//  BankManagerConsoleApp
//
//  Created by Wonji Ha on 2023/10/27.
//

import Foundation

final class Node<T> {
    let data: T?
    var nextNode: Node?
    
    init(data: T?, nextNode: Node? = nil) {
        self.data = data
        self.nextNode = nextNode
    }
}
