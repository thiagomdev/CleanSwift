# CleanSwift

Um projeto de exemplo demonstrando a aplicação da arquitetura **Clean Swift (VIP)** em iOS, utilizando uma requisição simples à API do [ViaCEP](https://viacep.com.br/) para ilustrar a separação de responsabilidades entre as camadas.

---

## 🏛 Arquitetura

O projeto adota o padrão **Clean Swift (VIP)** — uma adaptação da Clean Architecture do Uncle Bob para iOS, organizada em um ciclo unidirecional de fluxo de dados:

```
View → Interactor → Presenter → View
```

Cada cena (scene) é composta pelas seguintes camadas:

- **View (ViewController):** responsável pela apresentação e captura de eventos do usuário
- **Interactor:** orquestra a lógica de negócio e coordena chamadas a serviços
- **Presenter:** formata os dados recebidos do Interactor para exibição
- **Worker:** isola a comunicação com serviços externos (API, banco de dados, etc.)
- **Models:** define os tipos `Request`, `Response` e `ViewModel` para cada caso de uso

Essa separação torna o fluxo de dados previsível, facilita a testabilidade e isola cada responsabilidade em seu próprio arquivo.

---

## 🛠 Tecnologias

- **Swift**
- **UIKit**
- **URLSession** (sem dependências externas)
- **XCTest** para testes unitários

---

## 🧪 Testes

O projeto conta com testes unitários cobrindo as camadas VIP — **Interactor**, **Presenter** e **Worker** — utilizando *spies* e *mocks* para isolar cada componente e validar suas interações.

Para rodar os testes no Xcode, basta usar `Cmd + U` com o scheme do projeto selecionado.

Pela linha de comando:

```bash
xcodebuild test \
  -project CleanSwift.xcodeproj \
  -scheme CleanSwift \
  -destination 'platform=iOS Simulator,name=iPhone 14'
```

---

## 📂 Estrutura do projeto

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
```

> O projeto contém uma única cena (`Main`), organizada nos arquivos típicos do ciclo VIP.

---

## 🌐 API utilizada

O app consome a API pública do [ViaCEP](https://viacep.com.br/), que retorna os dados de um endereço a partir de um CEP brasileiro:

```
GET https://viacep.com.br/ws/{cep}/json/
```

Exemplo de resposta:

```json
{
  "cep": "01001-000",
  "logradouro": "Praça da Sé",
  "complemento": "lado ímpar",
  "bairro": "Sé",
  "localidade": "São Paulo",
  "uf": "SP"
}
```

---

## 🚀 Como rodar

```bash
# 1. Clone o repositório
git clone https://github.com/thiagomdev/CleanSwift.git
cd CleanSwift

# 2. Abra o projeto
open CleanSwift.xcodeproj
```

Em seguida, escolha um simulador (iPhone 14, por exemplo) e rode com `Cmd + R`.

---

## 🤝 Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para abrir uma *issue* relatando algo que poderia ser melhor, ou abrir um *pull request* com sugestões. Antes de enviar um PR:

1. Faça um fork do projeto
2. Crie uma branch a partir de `main` (`git checkout -b feature/minha-feature`)
3. Commit suas alterações (`git commit -m 'feat: adiciona minha feature'`)
4. Push para a branch (`git push origin feature/minha-feature`)
5. Abra um Pull Request

---

## 👨‍💻 Autor

Feito por **Thiago M.** — [@thiagomdev](https://github.com/thiagomdev)

Se este projeto te ajudou a entender Clean Swift, considere deixar uma ⭐ no repositório!
