
import UIKit
import RxReduce
import RxCocoa
import RxSwift

let store: Store<AppState> = {
    let appState = AppState(
        moviesListState: .empty,
        movieDetailState: .empty,
        checkedMoviesState: .empty
    )
    let store = Store<AppState>(withState: appState)
    
    store.register(mutator: AppMutators.movieListMutator)
    store.register(mutator: AppMutators.movieDetailMutator)
    store.register(mutator: AppMutators.checkedMoviesMutator)
    
    return store
}()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let disposeBag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
        
        return true
    }

}
