//
//  LinkedList.swift
//  BankManagerConsoleApp
//
//  Created by Wonji Ha on 2023/10/27.
//

import Foundation

struct LinkedList<T> {
    private var head: Node<T>?
    private var tail: Node<T>?
    
    var isEmpty: Bool {
        return head == nil && tail == nil
    }
    
    mutating func append(data: T) {
        let newNode = Node(data: data)
        
        guard isEmpty else {
            tail?.nextNode = newNode
            tail = newNode
            return
        }
        
        head = newNode
        tail = head
        
//        if isEmpty == true {
//            head = newNode
//            tail = head
//        } else {
//            tail?.nextNode = newNode
//            tail = newNode
//        }
    }
    
    mutating func removeFirstNode() -> T? {
        // 노드가 하나도 없거나, 하나만 있는 경우의 예외처리를 따로 진행합니다.
        // 반환값으로는 제거한 노드의 값을 갖습니다.
        guard head == nil else { return nil }
        
        let firstNode = head?.data
        head = head?.nextNode
        return firstNode
    }
    
    mutating func cleanerAllNode() {
        head = nil
        tail = nil
    }
    
}
