//
//  main.swift
//  ProtocolPrac
//
//  Created by Wonji Ha on 2023/10/06.
//

import Foundation

// 스킬이라는 열거형 생성
enum Skill {
    case 앉아, 손, 점프
}

// 개라면 할 수 있는것(응당해야하는 것) / 해야만 하는것
// 지구상에 있는 개라면 이 기능은 무조건 가지거 있어어야함.

protocol Dog {
    // 특성 : 프로퍼티 가지고 있어야 하는것.
    var color: String { get }
    var gender: String { get }
    var name: String { get }
    var age: Int { get }
    
    // 행위: 메서드 할 수 있는 것.
    
    func bark()
    func eat(_ something: String)
    func move(to: String)
    func sleeping()
    func skill() -> Skill
}

// 채택과 준수
// 채택 : 타입에다가 명찰을 다는 것.(타입에 기능의 명세를 붙인다)
// 준수 : 명찰을 달았다면 꼭 구현해야하는 것.(명세를 따라야 한다)
struct 꼬미: Dog {
    var color: String  = "흰색"
    var gender: String = "암컷"
    var name: String  = "꼬미"
    var age: Int = 7
    
    func bark() {
        print("멍멍!!")
    }
    
    func eat(_ something: String) {
        print("밥묵자~" + something + "꿀꺽")
    }
    
    func move(to: String) {
        print(to + "달려가~")
    }
    
    func sleeping() {
        print("자는중...")
    }
    
    func skill() -> Skill {
        return .앉아
    }
}

let gg = 꼬미()
gg.name
gg.move(to: "home")
gg.skill()

struct Bichon: Dog {
    var color: String = "흰색"
    var gender: String = "남"
    var name: String = "비종"
    var age: Int = 2
    func bark() {
        print("ww")
    }
    
    func eat(_ something: String) {
        print(something + "맛있다")
    }
    
    func move(to: String) {
        print(to + "달려가~")
    }
    
    func sleeping() {
        print("자는중...")
    }
    
    func skill() -> Skill {
        return .손
    }
}

let ggc: Dog = 꼬미()
ggc.move(to: "학교")
ggc.bark()

//ggc = Bichon()
//명세된것만 사용 가능
//var bb: Dog = Bichon() // 프로토콜을 사용하려면 반드시 붙여줘야 한다.
// 프로토콜 이름은 명사또는 able 붙여서 ~할수 있는 형태로 작성한다.

protocol Ownerable {
    func own(to: String)
}
// Type 'Person' does not conform to protocol 'Ownerable' 반드시 프로토콜 함수를 사용해야 한다.
struct Person: Ownerable {
    var name: String
    func order(to: Dog) {
    print("\(to)야 개인기 해봐!")
    }
    
    func takeWalk(with: Dog) {
        print("\(name)이 \(with.name)와 산책한다")
    }
    
    func own(to: String) {
        print("\(to) 넌 내꺼야!!")
    }
}

var dog: Dog = Bichon()
dog = 꼬미()
var owner: Ownerable = Person(name: "야곰")
owner.own(to: dog)

var jamking: Person = Person(name: "잼킹")
jamking.takeWalk(with: dog)
