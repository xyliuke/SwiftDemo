//
//  AnyBasicTypeCodable.swift
//  SwiftDemo
//
//  Created by 刘科 on 2022/2/8.
//

import Foundation

enum AnyBasicTypeCodable: Codable, CustomStringConvertible {
    case bool(Bool)
    case double(Double)
    case int(Int)
    case string(String)
    indirect case array([AnyBasicTypeCodable])
    indirect case dictionary([String: AnyBasicTypeCodable])

    init(from decoder: Decoder) throws {
        if let container = try? decoder.container(keyedBy: JSONCodingKeys.self) {
            self = AnyBasicTypeCodable(from: container)
        } else if let container = try? decoder.unkeyedContainer() {
            self = AnyBasicTypeCodable(from: container)
        } else if let container = try? decoder.singleValueContainer() {
            self = AnyBasicTypeCodable(from: container)
        } else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: ""))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let bool):
            try? container.encode(bool)
        case .int(let int):
            try? container.encode(int)
        case .double(let double):
            try? container.encode(double)
        case .string(let string):
            try? container.encode(string)
        case .array(let array):
            try? container.encode(array)
        case .dictionary(let dictionary):
            try? container.encode(dictionary)
        }
    }

    private init(from container: KeyedDecodingContainer<JSONCodingKeys>) {
        var dict: [String: AnyBasicTypeCodable] = [:]
        for key in container.allKeys {
            if let value = try? container.decode(Bool.self, forKey: key) {
                dict[key.stringValue] = .bool(value)
            } else if let value = try? container.decode(Int.self, forKey: key) {
                dict[key.stringValue] = .int(value)
            } else if let value = try? container.decode(Double.self, forKey: key) {
                dict[key.stringValue] = .double(value)
            } else if let value = try? container.decode(String.self, forKey: key) {
                dict[key.stringValue] = .string(value)
            } else if let value = try? container.nestedContainer(keyedBy: JSONCodingKeys.self, forKey: key) {
                dict[key.stringValue] = AnyBasicTypeCodable(from: value)
            } else if let value = try? container.nestedUnkeyedContainer(forKey: key) {
                dict[key.stringValue] = AnyBasicTypeCodable(from: value)
            }
        }
        self = .dictionary(dict)
    }

    private init(from container: UnkeyedDecodingContainer) {
        var container = container
        var arr: [AnyBasicTypeCodable] = []
        while !container.isAtEnd {
            if let value = try? container.decode(Bool.self) {
                arr.append(.bool(value))
            } else if let value = try? container.decode(Int.self) {
                arr.append(.int(value))
            } else if let value = try? container.decode(Double.self) {
                arr.append(.double(value))
            } else if let value = try? container.decode(String.self) {
                arr.append(.string(value))
            } else if let value = try? container.nestedContainer(keyedBy: JSONCodingKeys.self) {
                arr.append(AnyBasicTypeCodable(from: value))
            } else if let value = try? container.nestedUnkeyedContainer() {
                arr.append(AnyBasicTypeCodable(from: value))
            }
        }
        self = .array(arr)
    }
    
    private init(from container: SingleValueDecodingContainer) {
        if let val = try? container.decode(String.self) {
            self = .string(val)
        } else if let val = try? container.decode(Int.self) {
            self = .int(Int(val))
        } else if let val = try? container.decode(Double.self) {
            self = .double(val)
        } else if let val = try? container.decode(Bool.self) {
            self = .bool(val)
        } else {
            self = .string("")
        }
    }
    
    public var description: String {
        switch self {
        case .bool(let bool):
            return bool ? "true" : "false"
        case .double(let double):
            return String(double)
        case .int(let int):
            return String(int)
        case .string(let string):
            return string
        case .array(let array):
            var ret = "["
            let string = array.reduce("") {
                if $0 == "" {
                    return "\($1.description)"
                } else {
                    return "\($0),\($1.description)"
                }
            }
            ret.append(string)
            ret.append("]")
            return ret
        case .dictionary(let dictionary):
            var ret = "{"
            let string = dictionary.reduce("") {
                let (key, value) = $1
                if $0 == "" {
                    return "\(key):\(value)"
                } else {
                    return "\($0),\(key):\(value)"
                }
            }
            ret.append(string)
            ret.append("}")
            return ret
        }
    }
}

struct JSONCodingKeys: CodingKey {
    var stringValue: String

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    var intValue: Int?

    init?(intValue: Int) {
        self.init(stringValue: "\(intValue)")
        self.intValue = intValue
    }
}
