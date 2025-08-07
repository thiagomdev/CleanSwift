//
//  ViewController.swift
//  CleanArchitecture
//
//  Created by Thiago Monteiro on 24/05/25.
//

import UIKit

protocol MainViewControllerDisplayableLogic: AnyObject {
    func displayCepData(_ viewModel: CepRequestModel.ViewModel) async throws
    func requestCepData(_ cep: String) async throws
}

final class MainViewController: UIViewController {
    private var cancellable: Task<Void, Error>?
    private let interactor: MainInteracting
    
    public lazy var inputedCepTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Digite um cep válido"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.accessibilityIdentifier = "inputedCepTextField"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    public lazy var searchCepButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Buscar", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        button.accessibilityIdentifier = "searchCepButton"
        button.addTarget(self, action: #selector(searchCep), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackViewContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var logradouroLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var estadoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bairro: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var regiao: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(interactor: MainInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        pin()
        extraSetup()
    }
    
    @objc
    private func searchCep() {
        if let cep = inputedCepTextField.text {
            cancellable?.cancel()
            cancellable = Task { [weak self] in
                do {
                    try await self?.requestCepData(cep)
                } catch {
                    await MainActor.run {
                        let alert = UIAlertController(title: "Erro", message: "Não foi possível buscar o CEP. Tente novamente.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(alert, animated: true)
                    }
                }
            }
            inputedCepTextField.text = ""
        }
    }
}

extension MainViewController: MainViewControllerDisplayableLogic {
    func requestCepData(_ cep: String) async throws {
        let request = CepRequestModel.Request(cep: cep)
        try await interactor.load(data: request.cep)
    }
    
    func displayCepData(_ viewModel: CepRequestModel.ViewModel) async throws {
        await MainActor.run {
            logradouroLabel.text = viewModel.logradouro
            estadoLabel.text = viewModel.estado
            bairro.text = viewModel.bairro
            regiao.text = viewModel.regiao
        }
    }
}

extension MainViewController {
    private func buildViews() {
        view.addSubview(inputedCepTextField)
        view.addSubview(searchCepButton)
        view.addSubview(stackViewContainer)
        stackViewContainer.addArrangedSubview(estadoLabel)
        stackViewContainer.addArrangedSubview(logradouroLabel)
        stackViewContainer.addArrangedSubview(bairro)
        stackViewContainer.addArrangedSubview(regiao)
    }
    
    private func pin() {
        NSLayoutConstraint.activate([
            inputedCepTextField.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1.5),
            inputedCepTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: inputedCepTextField.trailingAnchor, multiplier: 1),
            inputedCepTextField.heightAnchor.constraint(equalToConstant: 80),
            
            searchCepButton.topAnchor.constraint(equalToSystemSpacingBelow: inputedCepTextField.bottomAnchor, multiplier: 1),
            searchCepButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: searchCepButton.trailingAnchor, multiplier: 1),
            searchCepButton.heightAnchor.constraint(equalToConstant: 40),
            
            stackViewContainer.topAnchor.constraint(equalToSystemSpacingBelow: searchCepButton.bottomAnchor, multiplier: 3),
            stackViewContainer.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: stackViewContainer.trailingAnchor, multiplier: 1),
        ])
    }
    
    private func extraSetup() {
        view.backgroundColor = .systemBackground
    }
}
