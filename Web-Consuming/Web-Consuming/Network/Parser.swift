//
//  Parser.swift
//  Web-Consuming
//
//  Created by Natália Brocca dos Santos on 02/07/21.
//

import Foundation
import UIKit

class Parser<T: Codable> {
    func parse(data: Data) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print(error)
            return nil
        }
        
    }
}
