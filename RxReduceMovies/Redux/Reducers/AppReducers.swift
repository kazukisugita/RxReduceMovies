
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

func movieDetailReducer(state: AppState, action: Action) -> MovieDetailState {
    
    guard let action = action as? MovieAction else {
        return state.movieDetailState
    }
    
    switch action {
    case .startLoadingMovies, .loadMovies(_):
        return .empty
        
    case .loadMovie(let movieId):
        guard case let .loaded(movies) = state.moviesListState else { return state.movieDetailState }
        let movie = movies.filter { $0.id == movieId }.first
        if let movieDetail = movie {
            
            if case var .checked(checkedMovies) = state.checkedMoviesState {
                checkedMovies.append(movieDetail)
            }
            return .loaded(movieDetail)
        }
        return state.movieDetailState
    default:
        return state.movieDetailState
     }
}

func checkedMoviesReducer(state: AppState, action: Action) -> CheckedMoviesState {
    
    guard let action = action as? MovieAction else {
        return state.checkedMoviesState
    }
    
    switch action {
    case .asChecked(let movieId):
        guard case let .loaded(movies) = state.moviesListState else {
            return state.checkedMoviesState
        }
        let movie = movies.filter { $0.id == movieId }.first
        guard let checkedMovie = movie else { return state.checkedMoviesState }
        
        if case var .checked(checkedMovies) = state.checkedMoviesState {
            checkedMovies.append(checkedMovie)
            return .checked(checkedMovies)
        }
        else {
            return .checked([checkedMovie])
        }
        
    case .getChecked:
        return state.checkedMoviesState
    default:
        return state.checkedMoviesState
    }
}
