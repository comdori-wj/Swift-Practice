import Cocoa
import Foundation

struct Stack<T> {
    // Stack<T>: 이름인 Stack 과 자료형을 지칭하는 T 입니다. 이때 T 는 제네릭 타입이라고 지칭되며, 어떠한 자료형이든 입력을 받아주겠다 라는 의미로 사용
    private var stack: [T] = []
    
    
    public var count: Int {
        return stack.count
    }
    
    public var isEmpty: Bool {
        return stack.isEmpty
    }
    
    public mutating func push(_ element: T) {
        stack.append(element)
    }
    
    // 기본적으로 내부의 값을 임의로 바꿀 수 없게 되어있습니다. mutating 키워드를 활용하여 내부의 값을 변경 할 수 있음.
    
    public mutating func pop() -> T? {
        return stack.popLast()
    }
    
    public func peek() -> T? {
        return stack.last
    }
    // mutating func 와 달리 mutating 이 없는 peek 는 이름 그대로, 가장 상단의 값을 확인만 할 뿐이니 mutating 이 필요가 없다.
}

var stack = Stack<Int>()
print("1) isEmpty? \(stack.isEmpty)")

stack.push(1)
stack.push(2)
print("2) isEmpty? \(stack.isEmpty)")
print("3) top: \(stack.peek())")

stack.pop()
print("4) top: \(stack.peek())")
