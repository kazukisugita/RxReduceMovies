
import Foundation
import RxReduce

func movieListReducer(state: AppState, action: Action) -> MoviesListState {
    
    guard let action = action as? MovieAction else {
        return state.moviesListState
    }
    
    switch action {
    case .startLoadingMovies:
        return .loading
    case .loadMovies(let movies):
        return .loaded(movies)
    default:
        return state.moviesListState
    }
}
