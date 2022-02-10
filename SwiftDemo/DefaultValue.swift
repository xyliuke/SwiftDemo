//
//  DefaultValue.swift
//  SwiftDemo
//
//  Created by liuke on 2022/2/10.
//

import Foundation

protocol DefaultValue {
    associatedtype Value: Decodable
    static var defaultValue: Value { get }
}

extension Bool: DefaultValue {
    static let defaultValue = false
}

extension Bool {
    enum False: DefaultValue {
        static let defaultValue = false
    }
    enum True: DefaultValue {
        static let defaultValue = true
    }
}

extension Int: DefaultValue {
    static let defaultValue = 0
}

extension Int {
    enum Zero: DefaultValue {
        static let defaultValue = 0
    }
    enum MinusOne: DefaultValue {
        static let defaultValue = -1
    }
    enum One: DefaultValue {
        static let defaultValue = 1
    }
}

extension Double: DefaultValue {
    static let defaultValue = 0.0
}

extension Double {
    enum Zero: DefaultValue {
        static let defaultValue = 0
    }
    enum MinusOne: DefaultValue {
        static let defaultValue = -1.0
    }
    enum One: DefaultValue {
        static let defaultValue = 1.0
    }
}

extension String: DefaultValue {
    static let defaultValue = ""
}



@propertyWrapper
struct Default<T: DefaultValue> {
    var wrappedValue: T.Value
}

extension Default: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(T.Value.self) {
            wrappedValue = value
        } else {
            wrappedValue = T.defaultValue
        }
    }
}

extension Default: Encodable {
    func encode(to encoder: Encoder) throws {
        
    }
}

extension KeyedDecodingContainer {
    func decode<T>(_ type: Default<T>.Type, forKey key: Key) throws -> Default<T> where T: DefaultValue {
        try decodeIfPresent(type, forKey: key) ?? Default(wrappedValue: T.defaultValue)
    }
}
