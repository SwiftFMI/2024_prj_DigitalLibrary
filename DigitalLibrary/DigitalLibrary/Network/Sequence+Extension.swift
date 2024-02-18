//
//  Sequence+Extension.swift
//  DigitalLibrary
//
//  Created by Desislav Adamov on 19.02.24.
//

extension Sequence {
    func asyncMap<T>(_ transform: (Element) async throws -> T) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            try await values.append(transform(element))
        }

        return values
    }
}
