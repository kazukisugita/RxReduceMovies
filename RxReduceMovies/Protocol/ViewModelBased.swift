
import UIKit
import Reusable

protocol ViewModel {}

protocol ViewModelBased {
    associatedtype ViewModelType: ViewModel
    var viewModel: ViewModelType! { get set }
}

extension ViewModelBased where Self: UIViewController {
    
    static func instanceFromCode(with viewModel: ViewModelType) -> Self {
        var viewController = self.init()
        viewController.viewModel = viewModel
        return viewController
    }
}
extension ViewModelBased where Self: StoryboardBased & UIViewController {
    
    static func instanceFromSB(with viewModel: ViewModelType) -> Self {
        var viewController = Self.instantiate()
        viewController.viewModel = viewModel
        return viewController
    }
}
