//
//  AlertItem.swift
//  AppetizersMMVMSwiftUIDemo
//
//  Created by Marco Alonso Rodriguez on 05/06/23.
//

import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    var title: Text
    var message: Text
    var dismissButton: Alert.Button?
}

