//
//  ServiceError.swift
//  globoplay
//
//  Created by Luan Cabral on 10/01/25.
//

import Foundation

enum ServiceError: Error {
    case network
    case other
    
    var message: String {
        switch self {
        case .network:
            return "Problema de conexão. Por favor verifique se está conectado a internet"
        case .other:
            return "Não foi possível completar a solicitação. Tente novamente"
        }
    }
}

