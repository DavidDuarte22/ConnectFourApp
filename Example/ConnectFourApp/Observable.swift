//
//  Observable.swift
//  ConnectFourApp_Example
//
//  Created by David Duarte on 02/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

class Observable<T> {

    var value: T {
        didSet {
            listener?(value)
        }
    }

    private var listener: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
