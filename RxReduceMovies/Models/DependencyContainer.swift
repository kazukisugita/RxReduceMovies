
import Foundation
import RxReduce

final class DependencyContainer: HasStore, HasNetworkService {
    
    let store: Store<AppState>
    let networkService: NetworkService
    
    init(withStore store: Store<AppState>, withNetworkService networkService: NetworkService) {
        self.store = store
        self.networkService = networkService
    }
}
