//
//  working.swift
//  ProtocolPrac
//
//  Created by Wonji Ha on 2023/10/06.
//

import Foundation

protocol Assistant {
    var name: String { get }
    var phoneNum: String { get }
    var level: Int { get }
    
    func todaybriefing(_ something: String)
    func callwork() -> String
    func scheduleManager(to: Int, work: String)
    func emailCheck(to: String)
}

struct Computer:Assistant {
    var name: String
    var phoneNum: String
    var level: Int
    
    func greet() {
        print("안녕하세요 " + name + "입니다")
    }
    
    func todaybriefing(_ something: String) {
        print("오늘의 업무는: " + something + "입니다.")
    }
    
    func callwork() -> String {
        return "여보세요~ 비서입니다!"
    }
    
    func scheduleManager(to: Int, work: String) {
        print("\(to) 일 \(work)업무를 생성하였습니다.")
    }
    
    func emailCheck(to: String) {
        print(to + "이라는 이메일을 확인하였습니다.")
    }
}

let siri = Computer(name: "siri", phoneNum: "", level: 8)
siri.greet()
