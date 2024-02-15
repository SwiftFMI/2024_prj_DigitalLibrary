//
//  Encodable+Extension.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 27.01.24.
//

import Foundation

extension Encodable {
    func toDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }

        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}
