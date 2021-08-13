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
    var allFriends: [Friend] = [
//        Friend(givenName: "Anastasia",
//               familyName: "Gulert",
//               age: 23,
//               avatar: "GulertAnastasia_Avatar",
//               id: "1",
//               images: ["1", "15", "2", "5", "7"]),
//        Friend(givenName: "Victor",
//               familyName: "Miheev",
//               age: 40,
//               avatar: "VictorMiheev_Avatar",
//               id: "2",
//               images: ["0", "3", "14"]),
//        Friend(givenName: "Tom",
//               familyName: "Vekerfield",
//               age: 35,
//               avatar: "TomVekerfield_Avatar",
//               id: "3",
//               images: ["4", "6", "13", "8"]),
//        Friend(givenName: "Alisha",
//               familyName: "Tompson",
//               age: 33,
//               avatar: "TompsonAlisha_Avatar",
//               id: "4",
//               images: ["9", "16", "10"]),
//        Friend(givenName: "Federico",
//               familyName: "Bruno",
//               age: 25,
//               avatar: "FedericoBruno_Avatar",
//               id: "5",
//               images: ["11", "12"])
    ]
    
    var myGroups: [Group] = []
    
    var allGroups: [Group] = [
        Group(nickname: "Cars",
              bio: "everythin about cars",
              areaOfInterests: "#cars, #speed",
              avatar: "carsAvatar",
              id: "1"),
        Group(nickname: "Travels",
              bio: "just buy a ticket and be free",
              areaOfInterests: "#countries, #vaterfalls, #nature",
              avatar: "travelAvatar",
              id: "2"),
        Group(nickname: "Mems",
              bio: "ahahahah",
              areaOfInterests: "#fun, #jokes, #hillariousthings",
              avatar: "memsAvatar", id: "3"),
        Group(nickname: "Accecories",
              bio: "rings, bracelets and etc.",
              areaOfInterests: "#beauty, #lifestyle",
              avatar: "accecoriesAvatar",
              id: "4"),
        Group(nickname: "Psychology",
              bio: "find your inner self",
              areaOfInterests: "#lifeasitis, #health",
              avatar: "psychologyAvatar",
              id: "5")
    ]
}
