//
//  inputProtocol.swift
//  SSA Student
//
//  Created by pro admin on 9/12/17.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

protocol inputProtocol {
    //var names: [String]
    //var isScience: [Bool]
    //var isAB: [Bool]
    //func didSelectFree(row: Int, free: Bool)
    func didSelectRegular(row: Int, nor: Bool)
    func didSelectAB(row: Int, ab: Bool)
    func didChangeName(row:Int, text: String)
}
