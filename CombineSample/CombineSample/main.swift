//
//  main.swift
//  CombineSample
//
//  Created by Wonji Ha on 1/9/24.
//

import Combine

// MARK: - 컴바인 기본
let num = [1, 2, 3, 4, 5]
let pub = num.publisher // publisher 생성

// sink로 publisher subscribe
let sub = pub.sink(receiveCompletion: {
    print("완료 응답: ", $0)
}, receiveValue: {
    print("값 응답: ", $0)
})

// MARK: - 방출
let num2 = (1...5).publisher
num2
    .prepend(0)
    .sink { value in
        print("value: ", value)
    }

num2
    .firstWhere { $0 % 2 == 0 }

