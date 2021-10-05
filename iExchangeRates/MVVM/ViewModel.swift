//
//  ViewModel.swift
//  ExchangeRate MVVM Demo
//
//  Created by Héctor Ullate Catalán on 5/10/21.
//

import Foundation
import Combine

protocol ViewModel: ObservableObject where ObjectWillChangePublisher.Output == Void {
    associatedtype State
    associatedtype Input
    var state: State { get }
    func trigger(_ input: Input)
}

extension AnyViewModel: Identifiable where State: Identifiable {
    var id: State.ID { state.id }
}

@dynamicMemberLookup
final class AnyViewModel<State, Input>: ViewModel {

    //Stored properties
    private let wrappedObjectWillChange: () -> AnyPublisher<Void, Never>
    private let wrappedState: () -> State
    private let wrappedTrigger: (Input) -> Void

    //Computed properties
    var objectWillChange: AnyPublisher<Void, Never> { wrappedObjectWillChange() }
    var state: State { wrappedState() }

    //Methods
    func trigger(_ input: Input) {
        wrappedTrigger(input)
    }

    subscript<Value>(dynamicMember keyPath: KeyPath<State, Value>) -> Value {
        state[keyPath: keyPath]
    }

    //Initialization
    init<V: ViewModel>(_ viewModel: V) where V.State == State, V.Input == Input {
        self.wrappedObjectWillChange = { viewModel.objectWillChange.eraseToAnyPublisher() }
        self.wrappedState = { viewModel.state }
        self.wrappedTrigger = viewModel.trigger
    }

}
