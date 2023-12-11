//
//  main.swift
//  DesignPatterns
//
//  Created by Wonji Ha on 12/5/23.
//

// TV의 동작 상태를 코드로 나타내 봤습니다.

import Foundation

enum State { // TV 전원 상태 구조체
    case on
    case off
}

// MARK: - Command
protocol Command {
    func play()
}

struct turnOnTvCommand: Command { // 명령을 상속 받음
    private let tv: TV
    
    init(tv: TV) {
        self.tv = tv
    }
    
    func play() {
        tv.turnOn()
    }
}

struct turnOffTvCommand: Command {
    private let tv: TV
    
    init(tv: TV) {
        self.tv = tv
    }
    
    func play() {
        tv.turnOff()
    }
}

struct changeChannelCommand: Command {
    private var tv: TV
    private var channel: String
    
    init(tv: TV, channel: String) {
        self.tv = tv
        self.channel = channel
    }
    
    func play() {
        tv.change(channel) // 채널 변경
    }
}
// MARK: - Receiver(수신자)
class TV {
    private var state : State = .off
    
    func turnOn() {
        state = .on
        print("TV 켜짐")
    }
    
    func turnOff() {
        state = .off
        print("TV 꺼짐")
    }
    
    func turnReverse() {
        switch state {
        case .on:
            turnOn()
        case .off:
            turnOff()
        }
    }
    
    func change(_ channel: String) {
        if state == .on {
            debugPrint("TV가 \(channel)번 채널을 돌렸습니다.")
        } else {
            debugPrint("TV가 꺼져서 채널을 변경할 수 없습니다.")
        }
    }
}
// MARK: - Invoker(호출자)
final class TVControl { // 리모컨
    
    private var redButton: Command // Protocol인 Command를 가짐
    private var numberButton: Command
    
    init(redButton: Command, numberButton: Command) {
        self.redButton = redButton
        self.numberButton = numberButton
    }
    
    func pressRedButton() {
        redButton.play()
    }
    
    func pressChannelChangeButton() {
        numberButton.play()
    }
}

let newTV = TV()
let turnOnTv = turnOnTvCommand(tv: newTV)
let turnOffTv = turnOffTvCommand(tv: newTV)
let changeChannelOfTV = changeChannelCommand(tv: newTV, channel: "5")

let tvRemote1 = TVControl(redButton: turnOnTv, numberButton: changeChannelOfTV)
tvRemote1.pressRedButton()
tvRemote1.pressChannelChangeButton()

let tvRemote2 = TVControl(redButton: turnOffTv, numberButton: changeChannelOfTV)
tvRemote2.pressRedButton()
tvRemote2.pressChannelChangeButton()
