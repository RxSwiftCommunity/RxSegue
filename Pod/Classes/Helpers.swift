//
//  Helpers.swift
//  Pods
//
//  Created by Segii Shulga on 3/19/16.
//
//

import Foundation

func bindingErrorToInterface(_ error: Error) {
    let errorMessage = "Binding error to UI: \(error)"
    #if DEBUG
        fatalError(errorMessage)
    #else
        print(errorMessage)
    #endif
}
