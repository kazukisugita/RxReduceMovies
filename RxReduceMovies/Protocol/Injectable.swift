
import Foundation

protocol Injectable {
    associatedtype InjectionContainer
    var injectionContainer: InjectionContainer { get set }
}
