//
//  Requester.swift
//  Web-Consuming
//
//  Created by Natália Brocca dos Santos on 02/07/21.
//

import Foundation

class Requester {
    static func request(apiRouter: APIRouterProtocol, completionHandler: @escaping (Data?) -> Void) {
        guard let url = URL(string: apiRouter.path) else {
            completionHandler(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil)
                return
            }
            completionHandler(data)
        }
        .resume()
    }
}
