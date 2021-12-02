//
//  CompletionStatus.swift
//  starwars-prozi
//
//  Created by Rodrigo Franzoi on 01/12/21.
//

public enum CompletionStatus<T> {
    case succeeded(T)
    case failed
}
