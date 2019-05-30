
import Foundation
import RxReduce

protocol HasStore {
    var store: Store<AppState> { get }
}
