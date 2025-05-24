//
//  ViewController.swift
//  CleanArchitecture
//
//  Created by Thiago Monteiro on 24/05/25.
//

import UIKit

protocol MainViewControllerDisplayableLogic: AnyObject {
    func displayCepData(_ cep: CepRequestModel.ViewModel) async throws
}

final class MainViewController: UIViewController {
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
        button.setTitle("Buscar Cep", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        button.accessibilityIdentifier = "searchCepButton"
        button.addTarget(self, action: #selector(searchCep), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
            Task { try await requestCepData(cep) }
            inputedCepTextField.text = ""
        }
    }
    
    private func requestCepData(_ cep: String) async throws {
        let resquest = CepRequestModel.Request(cep: cep)
        try await interactor.load(data: resquest.cep)
    }
}

extension MainViewController: MainViewControllerDisplayableLogic {
    func displayCepData(_ cep: CepRequestModel.ViewModel) async throws {
        await MainActor.run {
            // UPDATE UI LAYER
            print(cep)
        }
    }
}

extension MainViewController {
    private func buildViews() {
        view.addSubview(inputedCepTextField)
        view.addSubview(searchCepButton)
    }
    
    private func pin() {
        NSLayoutConstraint.activate([
            inputedCepTextField.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            inputedCepTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: inputedCepTextField.trailingAnchor, multiplier: 1),
            inputedCepTextField.heightAnchor.constraint(equalToConstant: 80),
            
            searchCepButton.topAnchor.constraint(equalToSystemSpacingBelow: inputedCepTextField.bottomAnchor, multiplier: 1),
            searchCepButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: searchCepButton.trailingAnchor, multiplier: 1),
            searchCepButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func extraSetup() {
        view.backgroundColor = .systemGray
    }
}
