//
//  Delegate.swift
//  SwiftDemo
//
//  Created by liuke on 2022/2/11.
//

import Foundation


public protocol OptionalProtocol {
    static var createNil: Self { get }
}

extension Optional: OptionalProtocol {
    public static var createNil: Optional<Wrapped> {
        return nil
    }
}

/// 一个简单的delegate来代替自定义的block，作用有两个：一是简化代码。二是为避免自定义block时导致的内存问题
/// 使用方法：
///     类A中定义变量：var finishBlock = Delegate<Int, Int>()，其中两个泛型分别是input和output，
///
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

extension Delegate where Output: OptionalProtocol {
    public func callAsFunction(_ value: Input) -> Output {
        if let result = block?(value) {
            return result
        } else {
            return .createNil
        }
    }
}
