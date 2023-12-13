//
//  main.swift
//  DesignPattern-TemplateMethod
//
//  Created by Wonji Ha on 12/5/23.
//

import Foundation

class SteakMaker {
    final func makeSteak() {
        grill()
        pourSauce()
        plating()
        print("----------")
    }

    func grill() {
        print("보통의 익힘정도로 고기를 굽습니다.")
    }

    func pourSauce() {
        print("소스를 붓습니다.")
    }

    func plating() {
        print("플레이팅후 파슬리가루를 뿌려줍니다.")
    }
}

class ChefComdori: SteakMaker {
    override func grill() {
        print("컴도리가 손님의 요청에 따라 익힘정도를 레어로 굽습니다.")
    }
    override func pourSauce() {
        print("컴도리가 손님의 요청에 따라 소스대신 소금을 붓습니다")
    }
}

class ChefYagom: SteakMaker {
    override func plating() {
        print("야곰이 플레이팅후 손님의 요청에 따라 파슬리가루는 뿌리지 않습니다.")
    }
}

let steakMaker = SteakMaker()
let comdori = ChefComdori()
let yagom = ChefYagom()

//steakMaker.makeSteak()
comdori.makeSteak()
yagom.makeSteak()
