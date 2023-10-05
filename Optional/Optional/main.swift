//
//  main.swift
//  Optional
//
//  Created by Wonji Ha on 2023/09/06.
//

import Foundation

let letter : String? = String("A")
print(letter!) // 강제 추출 방법
let letterOk = "B"

func t1 () {
    guard let letter = letter  else {
        return  print("값이 있음")
    }
    print("값이 없음")
}

t1()

