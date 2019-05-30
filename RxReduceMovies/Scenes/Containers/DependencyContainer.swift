
import Foundation
import RxReduce

final class DependencyContainer: HasStore {
    
    let store: Store<AppState>
    
    init(withStore store: Store<AppState>) {
        self.store = store
    }
}
