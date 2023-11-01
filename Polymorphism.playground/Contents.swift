import UIKit

class Student {
    func 공부하기() {
        print("공부를 열심히 합시다.")
    }
    
    func 놀기(){
        print("신나게 놀아봅시다")
    }
}
class 유치원생:Student {
    override func 한글공부() {
        print("공부하기")
    }
    override func 병원놀이() {
        print("의사 센세 여기가 아파요")
    }
}

func showAction(_ student: Student) {
    student.공부하기()
    student.놀기()
}

let person1 = 유치원생()

showAction(person1)
