
import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIs()
    }
    
    private func configureUIs() {
        
        self.tabBar.isTranslucent = false
        
        let networkService: NetworkService = NetworkService(withBaseUrl: URL(string: "https://api.themoviedb.org/3/")!, andApiKey: "3afafd21270fe0414eb760a41f2620eb")
        let dependencyContainer = DependencyContainer(withStore: store, withNetworkService: networkService)
        
        let viewControllers = [
            MoviesListViewController.instanceFromCode(with: MoviesListViewModel(with: dependencyContainer)),
            CheckedMoviesListViewController.instanceFromCode(with: CheckedMoviesListViewModel(with: dependencyContainer))
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
