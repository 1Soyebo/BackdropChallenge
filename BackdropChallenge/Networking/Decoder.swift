//
//  Decoder.swift
//  BackdropChallenge
//
//  Created by Ibukunoluwa Soyebo on 27/10/2022.
//

import Foundation

class Decoder<T: Decodable> {
    func decode(from data: Data) -> (Result<T,Error>) {
        do {
            let jsonDecoder = Utils.jsonDecoder
            let json = try jsonDecoder.decode(T.self, from: data)
            return .success(json)
        } catch {
            return .failure(error)
        }
    }
}
