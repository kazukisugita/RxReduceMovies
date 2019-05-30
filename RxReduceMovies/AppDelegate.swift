
import UIKit
import RxReduce

let store: Store<AppState> = {
    let appState = AppState(
        moviesListState: .empty,
        movieDetailState: .empty,
        checkedMoviesState: .empty
    )
    let store = Store<AppState>(withState: appState)
    return store
}()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
        
        return true
    }

}
