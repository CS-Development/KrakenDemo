//
//  URLSession-Ext.swift
//  KrakenDemoApp
//
//  Created by Christian Slanzi on 12.03.22.
//

import Foundation
import Combine

typealias Output = URLSession.DataTaskPublisher.Output

extension URLSession {

    func dataTaskPublisher(for url: URL,
                           cachedResponseOnError: Bool) -> AnyPublisher<Output, Error> {

        return self.dataTaskPublisher(for: url)
            // handles errors by either replacing it with another publisher or throwing a new error
            .tryCatch { [weak self] (error) -> AnyPublisher<Output, Never> in
                // attempt to fetch response from the cache or rethrow error
                guard cachedResponseOnError,
                    let urlCache = self?.configuration.urlCache,
                    let cachedResponse = urlCache.cachedResponse(for: URLRequest(url: url))
                else {
                    throw error
                }

                // send cached response if found
                return Just(Output(
                    data: cachedResponse.data,
                    response: cachedResponse.response
                )).eraseToAnyPublisher()
                
        }.eraseToAnyPublisher()
    }
}
