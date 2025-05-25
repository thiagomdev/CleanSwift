//
//  NetworkTests.swift
//  CleanArchitectureTests
//
//  Created by Thiago Monteiro on 24/05/25.
//

import Testing
import Foundation
@testable import CleanArchitecture

@Suite("NetworkTest", .serialized)
final class NetworkTests {
    
    @Test(arguments: [("00000000")])
    func fetch(cep: String) async throws {
        let (sut, mock) = makeSut()
        let cepData = """
          {
             "cep": "\(cep)",
             "logradouro": "Praça da Sé",
             "complemento": "lado ímpar",
             "unidade": "",
             "bairro": "Sé",
             "localidade": "São Paulo",
             "uf": "SP",
             "estado": "São Paulo",
             "regiao": "Sudeste",
             "ibge": "3550308",
             "gia": "1004",
             "ddd": "11",
             "siafi": "7107"
          }
          """.data(using: .utf8)!
        
        mock.mockData = cepData
        mock.mockResponse = HTTPURLResponse(
            url: URL(string: "https://viacep.com.br/ws/\(cep)/json/")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: ["Content-Type": "application/json"])
        
        do {
            let result = try await sut.fetchCep(cep)
            #expect(result != nil)
            #expect(result?.cep == cep)
            #expect(result?.logradouro == "Praça da Sé")
            #expect(result?.localidade == "São Paulo")
            #expect(result?.uf == "SP")
        } catch {
            Issue.record(error, "Expected success but got error: \(error)")
        }
    }
    
    @Test("Fetch CEP com diferentes códigos de status HTTP")
    func fetchCepDifferentStatusCodes() async throws {
        let (sut, mock) = makeSut()
        
        // ViaCEP retorna esse JSON quando o CEP não existe
        let errorData = """
           {
               "erro": "true"
           }
           """.data(using: .utf8)!
        
        mock.mockData = errorData
        mock.mockResponse = HTTPURLResponse(
            url: URL(string: "https://viacep.com.br/ws/00000000/json/")!,
            statusCode: 200, // ViaCEP retorna 200 mesmo para CEPs inválidos
            httpVersion: nil,
            headerFields: nil
        )
        
        // When & Then - Este teste deve falhar no decode porque o modelo Cep não tem campo "erro"
        await #expect(throws: DecodingError.self) {
            try await sut.fetchCep("00000000")
        }
    }
}

extension NetworkTests {
    private func makeSut() -> (sut: Network, mock: NetworkMock) {
        let mock = NetworkMock()
        let sut = Network(session: mock)
        return (sut, mock)
    }
}
