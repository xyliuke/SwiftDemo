//
//  Dictionary+Ext.swift
//  SwiftDemo
//
//  Created by liuke on 2022/2/10.
//

import Foundation

extension Dictionary {
    public static func castToString(intValue : Int?) -> String? {
        guard let intValue = intValue else {return nil}
        return String(intValue)
    }

    public static func castToString(doubleValue : Double?) -> String? {
        guard let doubleValue = doubleValue else {return nil}
        return String(doubleValue)
    }

    public static func castToString(floatValue : Float?) -> String? {
        guard let floatValue = floatValue else {return nil}
        return String(floatValue)
    }

    public static func castToInt(string : String?) -> Int? {
        guard let str = string else {return nil}
        return Int(str)
    }

    public static func castToInt(string : String?, defaultValue : Int) -> Int {
        guard let str = string else {return defaultValue}
        return Int(str) ?? defaultValue
    }

    public static func castToInt(floatValue : Float?) -> Int? {
        guard let str = floatValue else {return nil}
        return Int(str)
    }

    public static func castToInt(doubleValue : Double?) -> Int? {
        guard let str = doubleValue else {return nil}
        return Int(str)
    }

    public static func castToFloat (string : String?) -> Float? {
        guard let str = string else {return nil}
        return Float(str)
    }

    public static func castToFloat (string : String?, defaultValue : Float) -> Float {
        guard let str = string else {return defaultValue}
        return Float(str) ?? defaultValue
    }

    public static func castToDouble (string : String?) -> Double? {
        guard let str = string else {return nil}
        return Double(str)
    }

    public static func castToDouble (string : String?, defaultValue : Double) -> Double {
        guard let str = string else {return defaultValue}
        return Double(str) ?? defaultValue
    }

    public static func castToBool (intValue : Int?) -> Bool? {
        guard let intValue = intValue else {return nil}
        return intValue == 0 ? false : true
    }

    public static func castToBool (string : String?) -> Bool? {
        guard let intValue = castToInt(string: string) else {return nil}
        return intValue == 0 ? false : true
    }

    public static func castToString(bool : Bool?) -> String? {
        guard let boolValue = bool else {return nil}
        return boolValue ? "1" : "0"
    }

    public static func castToInt(bool : Bool?) -> Int? {
        guard let boolValue = bool else {return nil}
        return boolValue ? 1 : 0
    }

    public func getBoolValue(key : Key) -> Bool? {
        if keys.contains(key) {
            let value = self[key]
            if let val = value as? Bool {
                return val
            } else if let val = value as? String {
                return Dictionary.castToBool(string: val)
            } else if let val = value as? Int {
                return Dictionary.castToBool(intValue: val)
            } else if let val = value as? Float {
                return Dictionary.castToBool(intValue: Int(val))
            } else if let val = value as? Double {
                return Dictionary.castToBool(intValue: Int(val))
            } else if let val = value as? AnyBasicTypeCodable {
                return val.getBoolValue()
            }
        }
        return nil
    }

    public func getBoolValue(key : Key, defaultValue : Bool) -> Bool {
        getBoolValue(key: key) ?? defaultValue
    }

    public func getIntValue(key : Key) -> Int? {
        if keys.contains(key) {
            let value = self[key]
            if let val = value as? Int {
                return val
            } else if let val = value as? String {
                return Dictionary.castToInt(string: val)
            } else if let val = value as? Float {
                return Int(val)
            } else if let val = value as? Double {
                return Int(val)
            } else if let val = value as? AnyBasicTypeCodable {
                return val.getIntValue()
            }
        }
        return nil
    }
    public func getIntValue(key : Key, defaultValue : Int) -> Int {
        getIntValue(key: key) ?? defaultValue
    }

    public func getFloatValue(key : Key) -> Float? {
        if keys.contains(key) {
            let value = self[key]
            if let val = value as? Float {
                return val
            } else if let val = value as? String {
                return Dictionary.castToFloat(string: val)
            } else if let val = value as? Double {
                return Float(val)
            } else if let val = value as? Int {
                return Float(val)
            } else if let val = value as? AnyBasicTypeCodable {
                return val.getFloatValue()
            }
        }
        return nil
    }

    public func getFloatValue(key : Key, defaultValue : Float) -> Float {
        getFloatValue(key: key) ?? defaultValue
    }

    public func getDoubleValue(key : Key) -> Double? {
        if keys.contains(key) {
            let value = self[key]
            if let val = value as? Double {
                return val
            } else if let val = value as? String {
                return Dictionary.castToDouble(string: val)
            } else if let val = value as? Float {
                return Double(val)
            } else if let val = value as? Int {
                return Double(val)
            } else if let val = value as? AnyBasicTypeCodable {
                return val.getDoubleValue()
            }
        }
        return nil
    }

    public func getDoubleValue(key : Key, defaultValue : Double) -> Double {
        getDoubleValue(key: key) ?? defaultValue
    }

    public func getStringValue(key : Key) -> String? {
        if keys.contains(key) {
            let value = self[key]
            if let val = value as? Int {
                return Dictionary.castToString(intValue: val)
            } else if let val = value as? String {
                return val
            } else if let val = value as? Float {
                return Dictionary.castToString(floatValue: val)
            } else if let val = value as? Double {
                return Dictionary.castToString(doubleValue: val)
            } else if let val = value as? AnyBasicTypeCodable {
                return val.getStringValue()
            }
        }
        return nil
    }
    public func getStringValue(key : Key, defaultValue : String) -> String {
        getStringValue(key: key) ?? defaultValue
    }

    public func getArrayValue(key : Key) -> [Any]? {
        if keys.contains(key) {
            let value = self[key]
            if let val = value as? [Any] {
                return val
            }
        }
        return nil
    }

    public func getArrayValue(key : Key, defaultValue : [Any]) -> [Any] {
        getArrayValue(key: key) ?? defaultValue
    }

    public func getDictionaryValue(key : Key) -> [AnyHashable : Any]? {
        if keys.contains(key) {
            let value = self[key]
            if let val = value as? [AnyHashable : Any] {
                return val
            }
        }
        return nil
    }

    public func getDictionaryValue(key : Key, defaultValue : [AnyHashable : Any]) -> [AnyHashable : Any] {
        getDictionaryValue(key: key) ?? defaultValue
    }
    
    public func getStringValueByKeyPath(keyPath : String) -> String? {
        getValueByKeyPath(keyPath: keyPath) { dictionary, key -> String? in
            dictionary?.getStringValue(key: key)
        }
    }

    public func getStringValueByKeyPath(keyPath : String, defaultValue : String) -> String {
        getStringValueByKeyPath(keyPath: keyPath) ?? defaultValue
    }

    public func getIntValueByKeyPath(keyPath : String) -> Int? {
        getValueByKeyPath(keyPath: keyPath) { dictionary, key -> Int? in
            dictionary?.getIntValue(key: key)
        }
    }

    public func getIntValueByKeyPath(keyPath : String, defaultValue : Int) -> Int {
        getIntValueByKeyPath(keyPath: keyPath) ?? defaultValue
    }

    public func getBoolValueByKeyPath(keyPath : String) -> Bool? {
        getValueByKeyPath(keyPath: keyPath) { dictionary, key -> Bool? in
            dictionary?.getBoolValue(key: key)
        }
    }

    public func getBoolValueByKeyPath(keyPath : String, defaultValue : Bool) -> Bool {
        getBoolValueByKeyPath(keyPath: keyPath) ?? defaultValue
    }

    public func getFloatValueByKeyPath(keyPath : String) -> Float? {
        getValueByKeyPath(keyPath: keyPath) { dictionary, key -> Float? in
            dictionary?.getFloatValue(key: key)
        }
    }

    public func getFloatValueByKeyPath(keyPath : String, defaultValue : Float) -> Float {
        getFloatValueByKeyPath(keyPath: keyPath) ?? defaultValue
    }

    public func getDoubleValueByKeyPath(keyPath : String) -> Double? {
        getValueByKeyPath(keyPath: keyPath) { dictionary, key -> Double? in
            dictionary?.getDoubleValue(key: key)
        }
    }

    public func getDoubleValueByKeyPath(keyPath : String, defaultValue : Double) -> Double {
        getDoubleValueByKeyPath(keyPath: keyPath) ?? defaultValue
    }

    public func getDictionaryByKeyPath(keyPath : String) -> [AnyHashable : Any]? {
        getValueByKeyPath(keyPath: keyPath) { dictionary, hashable -> [AnyHashable : Any]? in
            dictionary?.getDictionaryValue(key: hashable)
        }
    }

    public func getDictionaryByKeyPath(keyPath : String, defaultValue : [AnyHashable : Any]) -> [AnyHashable : Any] {
        getDictionaryByKeyPath(keyPath: keyPath) ?? defaultValue
    }

    public func getArrayByKeyPath(keyPath : String) -> [Any]? {
        getValueByKeyPath(keyPath: keyPath) { dictionary, hashable -> [Any]? in
            dictionary?.getArrayValue(key: hashable)
        }
    }

    public func getArrayByKeyPath(keyPath : String, defaultValue : [Any]) -> [Any] {
        getArrayByKeyPath(keyPath: keyPath) ?? defaultValue
    }

    public func toJSONString() -> String {
        if (!JSONSerialization.isValidJSONObject(self)) {
            return ""
        }
        if let data = try? JSONSerialization.data(withJSONObject: self, options: []) {
            return String(data: data, encoding: String.Encoding.utf8) ?? ""
        }
        return ""
    }

    private func getValueByKeyPath<T>(keyPath : String, lastValue : ([AnyHashable : Any]?, AnyHashable) -> T?) -> T? {
        let arr = Dictionary.splitKey(key: keyPath)
        var tmp : [AnyHashable : Any]? = self
        var index = 0
        for item in arr {
            if let key = item as? Key {
                if index >= arr.count - 1 {
                    //最后一个
                    return lastValue(tmp, key)
                } else {
                    tmp = tmp?.getDictionaryValue(key: key)
                    if tmp == nil {
                        return nil
                    }
                }
            } else {
                return nil
            }
            index += 1
        }
        return nil
    }

    private static func splitKey(key : String) -> [String] {
        var ret = [String]()
        let arr = key.split(separator: ".")
        for item in arr {
            let str = String(item).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            if str.count > 0 {
                ret.append(str)
            }
        }
        return ret
    }
}
