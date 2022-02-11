//
//  Delegate.swift
//  SwiftDemo
//
//  Created by liuke on 2022/2/11.
//

import Foundation


public final class Delegate<Input, Output> {
    private var block: ((Input) -> Output?)?
    
    public func callAsFunction(_ value: Input) -> Output? {
        if let block = block {
            return block(value)
        } else {
            return nil
        }
    }
    
    public func delegate<T: AnyObject>(on target: T, callback: @escaping (T, Input) -> Output?) {
        block = {[weak target] input in
            guard let target = target else { return nil }
            return callback(target, input)
        }
    }
}
