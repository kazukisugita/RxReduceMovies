
import Foundation
import RxReduce
import RxCocoa
import RxSwift

final class CheckedMoviesListViewModel: ViewModel, Injectable {
    
    typealias InjectionContainer = HasStore & HasNetworkService
    var injectionContainer: InjectionContainer
    
    init(with injectionContainer: InjectionContainer) {
        self.injectionContainer = injectionContainer
    }
    
    func fetchCheckedList() -> Driver<CheckedMoviesState> {
        
        return self.injectionContainer
            .store
            .dispatch(action: MovieAction.getChecked) { $0.checkedMoviesState }
            .asDriver(onErrorJustReturn: .empty)
    }
}
