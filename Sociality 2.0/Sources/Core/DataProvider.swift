//
//  DataProvider.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 03.08.2021.
//

final class DataProvider {
    
    // MARK: - Static
    static let shared = DataProvider()
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Properties
    var allFriends: [Friend] = []
    
    var myGroups: [Group] = []
    
    var allGroups: [Group] = [
//        Group(nickname: "Cars",
//              bio: "everythin about cars",
//              areaOfInterests: "#cars, #speed",
//              avatar: "carsAvatar",
//              id: "1"),
//        Group(nickname: "Travels",
//              bio: "just buy a ticket and be free",
//              areaOfInterests: "#countries, #vaterfalls, #nature",
//              avatar: "travelAvatar",
//              id: "2"),
//        Group(nickname: "Mems",
//              bio: "ahahahah",
//              areaOfInterests: "#fun, #jokes, #hillariousthings",
//              avatar: "memsAvatar", id: "3"),
//        Group(nickname: "Accecories",
//              bio: "rings, bracelets and etc.",
//              areaOfInterests: "#beauty, #lifestyle",
//              avatar: "accecoriesAvatar",
//              id: "4"),
//        Group(nickname: "Psychology",
//              bio: "find your inner self",
//              areaOfInterests: "#lifeasitis, #health",
//              avatar: "psychologyAvatar",
//              id: "5")
    ]
}
