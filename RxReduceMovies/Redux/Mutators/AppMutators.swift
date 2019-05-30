
import Foundation
import RxReduce

struct AppMutators {
    
    static let movieListMutator = Mutator<AppState, MoviesListState>(
        lens: AppLenses.movieListLens,
        reducer: movieListReducer
    )
}
