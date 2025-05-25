//
//  CepModel.swift
//  CleanArchitecture
//
//  Created by Thiago Monteiro on 24/05/25.
//

import Foundation

enum CepRequestModel {
    struct Request {
        let cep: String
    }
    
    struct Response {
        let cep: Cep
    }
    
    struct ViewModel {
        let cep: Cep
    
        var logradouro: String {
            "Logradouro: \(cep.logradouro)"
        }
        
        var estado: String {
            "Estado: \(cep.estado)"
        }
        
        var bairro: String {
            "Bairro: \(cep.bairro)"
        }
        
        var regiao: String {
            "Região: \(cep.regiao)"
        }
    }
}
