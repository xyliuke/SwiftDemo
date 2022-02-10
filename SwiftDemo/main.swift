//
//  main.swift
//  SwiftDemo
//
//  Created by 刘科 on 2022/2/8.
//

import Foundation

print("Hello, World!")

struct Model: Codable {
    let text: String
    let other: [String: AnyBasicTypeCodable]?
    let array: [AnyBasicTypeCodable]?
    
    @Default<Bool.True>
    var b: Bool
//    let other: [String: Int]?
    
    enum CodingKeys: String, CodingKey {
        case text
        case other
        case array
        case b
    }
}

let dic = """
{
    "text": "this is demo",
    "other": {"a": 2, "b": 3.5, "c": "cc", "d": 922337203685477580, "e": {"a": 2, "b": 3.5, "c": "cc", "d": 922337203685477580}, "array":[{"a":"1"}, {"a":"2"}, {"a":"3"}, {"a":"4"}, {"a":"5"}]},
    "array": [1, 2, 3, 4, 5, 6]
    
}
"""
//, "b": 3.2, "c": "cc", "d": 922337203685477580, "e": {"a": 2, "b": 3.2, "c": "cc", "d": 922337203685477580}

//if let data = dic.data(using: String.Encoding.utf8) {
//    if let dict = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
//        print(dict)
//    }
//}


if let data = dic.data(using: .utf8) {
    if let model = try? JSONDecoder().decode(Model.self, from: data) {
        print(model.text)
        print(model.other)
        print(model.array)
//        if (!JSONSerialization.isValidJSONObject(model.other)) {
//            print("")
//        }
//        if let data = try? JSONSerialization.data(withJSONObject: model.other, options: []) {
//            let str = String(data: data, encoding: String.Encoding.utf8) ?? ""
//            print(str)
//        }
        
        
        if let dd = try? JSONEncoder().encode(model.other) {
            if let newStr = (String(data: dd, encoding: .utf8)) {
                print(newStr)
//                if let newData = newStr.data(using: String.Encoding.utf8) {
//                    if let dict = try? JSONSerialization.jsonObject(with: newData,
//                                    options: .mutableContainers) as? [String : Any] {
//                        print(dict)
//                    }
//                }
            }
        }
    }
}



//if let data = try? JSONEncoder().encode(dic) {
////    if let string = String(data: data, encoding: .utf8) {
//        print(dic)
//        if let model = try? JSONDecoder().decode(Model.self, from: data) {
//            print(model.text)
//        }
////    }
//}
