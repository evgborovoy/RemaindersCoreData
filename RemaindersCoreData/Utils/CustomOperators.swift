//
//  CustomOperators.swift
//  RemaindersCoreData
//
//  Created by Evgeniy Borovoy on 12/16/24.
//

import SwiftUI

public func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
