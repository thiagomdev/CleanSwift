# 🧼 CleanSwift

Projeto de exemplo demonstrando a arquitetura **Clean Swift (VIP)** em iOS, usando uma requisição simples à API do ViaCEP para ilustrar a separação de responsabilidades entre as camadas.

## 🏛 Arquitetura

```
Clean Swift (VIP)

Main/
├── MainViewController   → apresentação e captura de eventos
├── MainInteractor       → lógica de negócio e orquestração
├── MainPresenter        → formata os dados para a View
├── MainWorker           → comunicação com serviços externos
└── MainModels           → Request, Response e ViewModel

Fluxo
View → Interactor → Worker → API → Interactor → Presenter → View
```

## 🛠 Tecnologias

- Swift
- UIKit
- URLSession
- Sem dependências externas

## 🧪 Testes

```
XCTest · Spies e Mocks · cobertura nas camadas VIP

CleanSwiftTests/
└── Scenes/
    └── Main/
        ├── MainInteractorTests
        ├── MainPresenterTests
        └── MainWorkerTests
```

## 📂 Estrutura de Pastas

```
CleanSwift/
├── Scenes/
│   └── Main/
│       ├── MainViewController.swift
│       ├── MainInteractor.swift
│       ├── MainPresenter.swift
│       ├── MainWorker.swift
│       └── MainModels.swift
├── Services/
│   └── Network/
└── Resources/

CleanSwiftTests/
└── Scenes/
    └── Main/
```

## 🌐 API

```
GET https://viacep.com.br/ws/{cep}/json/
```

## 🚀 Como rodar

1. Clone o repositório
2. Abra o `CleanSwift.xcodeproj`
3. Rode no simulador
