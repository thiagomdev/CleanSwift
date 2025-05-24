//
//  MainFactory.swift
//  CleanArchitecture
//
//  Created by Thiago Monteiro on 24/05/25.
//

import UIKit

enum MainFactory {
    static func make() -> UIViewController {
        let networking = Network(session: .shared)
        let worker = MainWorker(networking: networking)
        let presenter = MainPresenter()
        let interactor = MainInteractor(worker: worker, presenter: presenter)
        let viewController = MainViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
