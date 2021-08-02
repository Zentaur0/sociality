//
//  DataProvider.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 03.08.2021.
//

import UIKit

final class DataProvider {
    
    // MARK: - Static
    static let shared = DataProvider()
    
    // MARK: - Init
    private init() {}
    
    var allFriends = [
        Friend(givenName: "Anastasia", familyName: "Gulert", age: "23", avatar: "GulertAnastasia_Avatar", id: "1"),
        Friend(givenName: "Victor", familyName: "Miheev", age: "40", avatar: "VictorMiheev_Avatar", id: "2"),
        Friend(givenName: "Tom", familyName: "Vekerfield", age: "35", avatar: "TomVekerfield_Avatar", id: "3"),
        Friend(givenName: "Alisha", familyName: "Tompson", age: "33", avatar: "TompsonAlisha_Avatar", id: "4"),
        Friend(givenName: "Federico", familyName: "Bruno", age: "25", avatar: "FedericoBruno_Avatar", id: "5")
    ].sorted(by: { $0.givenName < $1.givenName })
}
