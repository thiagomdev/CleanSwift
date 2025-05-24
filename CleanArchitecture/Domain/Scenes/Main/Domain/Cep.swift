//
//  Cep.swift
//  CleanArchitecture
//
//  Created by Thiago Monteiro on 24/05/25.
//

import Foundation

struct Cep: Codable, Hashable, Equatable {
    var cep: String
    var logradouro: String
    var bairro: String
    var localidade: String
    var complemento: String
    var unidade: String
    var uf: String
    var estado: String
    var regiao: String
    var ibge: String
    var gia: String
    var ddd: String
    var siafi: String
    
    init(
        cep: String,
        logradouro: String,
        bairro: String,
        localidade: String,
        complemento: String,
        unidade: String,
        uf: String,
        estado: String,
        regiao: String,
        ibge: String,
        gia: String,
        ddd: String,
        siafi: String) {
            
        self.cep = cep
        self.logradouro = logradouro
        self.bairro = bairro
        self.localidade = localidade
        self.complemento = complemento
        self.unidade = unidade
        self.uf = uf
        self.estado = estado
        self.regiao = regiao
        self.ibge = ibge
        self.gia = gia
        self.ddd = ddd
        self.siafi = siafi
    }
}
