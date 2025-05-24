//
//  Fixture.swift
//  CleanArchitecture
//
//  Created by Thiago Monteiro on 24/05/25.
//

@testable import CleanArchitecture
extension Cep {
    static func fixture(cep: String) -> Self {
        return .init(
            cep: cep,
            logradouro: "",
            bairro: "",
            localidade: "",
            complemento: "",
            unidade: "",
            uf: "",
            estado: "",
            regiao: "",
            ibge: "",
            gia: "",
            ddd: "",
            siafi: ""
        )
    }
}
