
import Foundation

class MoviesListViewModel: ViewModel, Injectable {
    
    typealias InjectionContainer = HasStore
    var injectionContainer: InjectionContainer

    init(with injectionContainer: InjectionContainer) {
        self.injectionContainer = injectionContainer
    }
}
