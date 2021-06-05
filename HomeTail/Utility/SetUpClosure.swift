//
//  SetUpClosure.swift
//  HomeTail
//
//  Created by taeuk on 2021/06/06.
//

import UIKit

func create<T>(_ setup: ((T) -> Void)) -> T where T: NSObject {
    let obj = T()
    setup(obj)
    return obj
}
