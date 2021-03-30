import UIKit

protocol RestorePasswordRoutingLogic: CommonRouter {
    func routeBack()
}

protocol RestorePasswordDataPassing {
    var dataStore: RestorePasswordDataStore? { get }
}

class RestorePasswordRouter: NSObject, RestorePasswordRoutingLogic, RestorePasswordDataPassing {
    weak var viewController: RestorePasswordViewController?
    var dataStore: RestorePasswordDataStore?
    var fromController: UIViewController? {
        viewController
    }

    // MARK: - Routing

    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
