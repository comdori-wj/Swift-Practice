//
//  main.swift
//  DesignPatterns
//
//  Created by Wonji Ha on 12/5/23.
//

// TV 리모컨을 구현하였습니다.

import Foundation

enum State { // TV 전원 상태 구조체
    case on
    case off
}

// MARK: - Command
protocol Command {
    func execute()
    func undo()
}

struct turnOnTvCommand: Command { // tv 켜짐 명령
    private let tv: TV
    
    init(tv: TV) {
        self.tv = tv
    }
    
    func execute() {
        tv.turnOn()
    }
    
    func undo() {
        tv.turnOff()
    }
}

struct turnOffTvCommand: Command { // tv 꺼짐 명령
    private let tv: TV
    
    init(tv: TV) {
        self.tv = tv
    }
    
    func execute() {
        tv.turnOff()
    }
    
    func undo() {
        tv.turnOn()
    }
}

struct changeChannelCommand: Command { // 채널 변경 명령
    private var tv: TV
    private var channel: String
    
    init(tv: TV, channel: String) {
        self.tv = tv
        self.channel = channel
    }
    
    func execute() {
        tv.change(channel)
    }
    
    func undo() {
        tv.change(channel)
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
    private var commandHistory: [Command] = [] // 명령 저장소
    
    init(redButton: Command, numberButton: Command) {
        self.redButton = redButton
        self.numberButton = numberButton
    }
    
    func pressRedButton() {
        redButton.execute()
        commandHistory.append(redButton)
    }
    
    func pressChannelChangeButton() {
        numberButton.execute()
        commandHistory.append(numberButton)
    }
    
    func undoButton() {
        if commandHistory.isEmpty != true {
            let command = self.commandHistory.removeLast()
            command.undo()
        } else {
            print("되돌릴 작업이 없습니다.")
        }
    }
}

let newTV = TV()
let turnOnTv = turnOnTvCommand(tv: newTV)
let turnOffTv = turnOffTvCommand(tv: newTV)
let changeChannelOfTV = changeChannelCommand(tv: newTV, channel: "5")

let tvRemote1 = TVControl(redButton: turnOnTv, numberButton: changeChannelOfTV)
tvRemote1.pressRedButton()
tvRemote1.pressChannelChangeButton()
//tvRemote1.undoButton() // 만약 되돌린다면?

let tvRemote2 = TVControl(redButton: turnOffTv, numberButton: changeChannelOfTV)
tvRemote2.pressRedButton()
tvRemote2.pressChannelChangeButton()

tvRemote2.undoButton()
