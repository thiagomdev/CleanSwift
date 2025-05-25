//
//  MainFactory.swift
//  CleanArchitecture
//
//  Created by Thiago Monteiro on 24/05/25.
//

import UIKit

enum MainFactory {
    static func make() -> UIViewController {
        let session = URLSession.shared
        let networking = Network(session: session)
        let worker = MainWorker(networking: networking)
        let presenter = MainPresenter()
        let interactor = MainInteractor(worker: worker, presenter: presenter)
        let viewController = MainViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
