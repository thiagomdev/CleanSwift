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
    
        enum InfoCep {
            case logradouro
            case estado
            case bairro
            case regiao
        }
        
        func perform(formatted string: InfoCep) -> String {
            switch string {
            case .logradouro:
                "Logradouro: \(cep.logradouro)"
            case .estado:
                "Estado: \(cep.estado)"
            case .bairro:
                "Bairro: \(cep.bairro)"
            case .regiao:
                "Região: \(cep.regiao)"
            }
        }
    }
}
