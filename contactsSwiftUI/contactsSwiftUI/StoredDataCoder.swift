//
//  StoredDataCoder.swift
//  contactsSwiftUI
//
//  Created by Bogdan Moroz on 07.07.2022.
//

import Foundation
// StoredDataCoder - encodes and decodes data to store in UserDefaults
class StoredDataCoder<T: Codable> {
    func encodeData(data: [T]) -> Data? {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(data)
            return data
        } catch {
            print("Unable to Encode (\(error))")
            return nil
        }
    }

    func decodeData(forKey: String) -> [T]? {
        if let data = UserDefaults.standard.data(forKey: forKey) {
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode([T].self, from: data)
                return data

            } catch {
                print("Unable to Decode (\(error))")
            }
        }
        return nil
    }
}
