
import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIs()
    }
    
    private func configureUIs() {
        
        self.tabBar.isTranslucent = false
        
        let dependencyContainer = DependencyContainer(withStore: store)
        
        let viewControllers = [
            MoviesListViewController.instanceFromCode(with: MoviesListViewModel(with: dependencyContainer)),
            CheckedMoviesListViewController()
        ]
        
        let controllers = viewControllers.enumerated().map { controller -> UINavigationController in
            
            let navigation = UINavigationController()
            navigation.navigationBar.isTranslucent = false
            navigation.setViewControllers([controller.element], animated: false)
            navigation.tabBarItem = UITabBarItem(title: String(controller.offset), image: nil, selectedImage: nil)
            
            return navigation
        }
        self.setViewControllers(controllers, animated: false)
    }
}
