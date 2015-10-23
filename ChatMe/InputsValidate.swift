//
//  InputsValidate.swift
//  ChatMe
//
//  Created by baby on 15/8/16.
//  Copyright © 2015年 Beijing Gold Finger Education Technology LLC. All rights reserved.
//

import Foundation

struct Inputs:OptionSetType {
    var rawValue:Int
    static let userName = Inputs(rawValue: 1)
    static let password = Inputs(rawValue: 1 << 1)
    static let email = Inputs(rawValue: 1 << 2)
}

//方法验证
extension Inputs {
    
    func isAllValidate() -> Bool{
        let count = 3
        var found = 0
        for time in 0..<count where contains(Inputs(rawValue: 1 << time)) {
            found++
        }
        return count == found
    }
}
/*
//布尔值验证: 遵循Boolean的协议的变量可以拿来直接判断，如 if possibleInputs：Inputs {  }
extension Inputs:BooleanType {
    
    var boolValue:Bool {
        let count = 3
        var found = 0
        for time in 0..<count where contains(Inputs(rawValue: 1 << time)) {
            found++
        }
        return count == found
    }
}
*/