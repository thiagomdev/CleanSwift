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
    }
}
