//
//  APIConfiguration.swift
//  globoplay
//
//  Created by Luan Cabral on 10/01/25.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}
