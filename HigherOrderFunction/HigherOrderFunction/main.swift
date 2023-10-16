//
//  main.swift
//  HigherOrderFunction
//
//  Created by WonjiHa on 2023/10/16.
//

import Foundation

print("고차함수 연습 및 직접 구현해보기")

let string = ["1", "2", "3", "4", "5"]
var numbers: [Int] = [Int]()
var numbers2 = [1,2,3,4,5,6,7,8,9]

// MARK: - Map

let numbersAlpa = string.map { Int($0)! }
print(numbersAlpa)

extension Array {
    
    func myMap<T>(closure: (Element) -> T) -> [T] {
        var result = [T]()
        print(self)
        for index in self {
            result.append(closure(index))
        }
        return result
    }
}

func out() {
    print("myMap result: ", string.myMap(closure: {Character($0)} ))
}

out() // () 괄호의 의미는 '함수를 실행한다' 라는 뜻

// MARK: - Filter

var filtered: [Int] = [Int]()
for number in numbers2 {
    if number % 2 == 0 {
        filtered.append(number)
    }
}

print(filtered) // [0, 2, 4]

// filter 메서드 사용
// numbers의 요소 중 짝수를 걸러내어 새로운 배열로 반환
let evenNumbers: [Int] = numbers2.filter { (number: Int) -> Bool in
    return number % 2 == 0
}
print(evenNumbers) // [0, 2, 4]

extension Array {
    func myFilter(closure: (Element) -> Bool) -> [Element] {
        var result = [Element]()
        for element in self {
            if closure(element) {
                result.append(element)
            }
        }
        return result
    }
}

let evenNumbers2 = numbers2.myFilter { (number: Int) -> Bool in
    return number % 2 == 0
}

print("myFilter result: ", evenNumbers2)

// MARK: - Reduce

let someNumbers: [Int] = [2, 8, 15]
var result: Int = 0

// someNumbers의 모든 요소를 더합니다
for number in someNumbers {
    result += number
}

print(result) // 25

// reduce 메소드 사용
// 초깃값이 0이고 someNumbers 내부의 모든 값을 더합니다.
let sum: Int = someNumbers.reduce(0, { (first: Int, second: Int) -> Int in
    print("\(first) + \(second)") //어떻게 동작하는지 확인해보세요
    return first + second
})

print(sum)  // 25

extension Array {
    func myReduce<T>(_ initial: T, _ closure: (T, Element) -> T) -> T {
        var result: T = initial
        for element in self {
            result = closure(result, element)
        }
        return result
    }
}

let sum2 = someNumbers.myReduce(0) { num1, num2 in
    return num1 + num2
}
print("myReduce result: ", sum2)

let subtract = someNumbers.myReduce(0) { num1, num2 in
    return num1 - num2
}
print("myReduce result: ", subtract)

