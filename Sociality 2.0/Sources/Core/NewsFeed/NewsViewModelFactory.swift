//
//  NewsViewModelFactory.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 07.11.2021.
//

final class NewsViewModelFactory {
    
    func constructNewsViewModels(groups: [GroupModel],
                                 items: [ItemsModel],
                                 profiles: [ProfileModel],
                                 nextFrom: String) -> NewsFeedItems {
        self.makeNewsFeedItemViewModel(groups: groups, items: items, profiles: profiles, nextFrom: nextFrom)
    }
    
    func constructProfileViewModels(profiles: [NewsProfile]) -> [ProfileModel] {
        profiles.compactMap(self.makeProfileViewModel)
    }
    
    func constructGroupViewModels(groups: [NewsGroup]) -> [GroupModel] {
        groups.compactMap(self.makeGroupViewModel)
    }
    
    func constructItemViewModels(items: [NewsItem]) -> [ItemsModel] {
        items.compactMap(self.makeItemViewModel)
    }
    
    private func makeProfileViewModel(from profile: NewsProfile) -> ProfileModel {
        ProfileModel(id: profile.id, firstName: profile.firstName, lastName: profile.lastName, photo: profile.photo)
    }
    
    private func makeGroupViewModel(from group: NewsGroup) -> GroupModel {
        GroupModel(id: group.id, name: group.name, photo: group.photo, date: 0)
    }
    
    private func makeItemViewModel(from item: NewsItem) -> ItemsModel {
        ItemsModel(
            id: item.id,
            date: item.date,
            sourceID: item.sourceID,
            comments: item.comments?.count ?? 0,
            likes: item.likes?.count ?? 0,
            text: item.text,
            photoURL: item.attachments?.last?.photo?.sizes.last?.url ?? "",
            photoWidth: item.attachments?.last?.photo?.sizes.last?.width ?? 0,
            photoHeight: item.attachments?.last?.photo?.sizes.last?.height ?? 0,
            isLiked: item.likes?.userLikes == 1 ? true : false
        )
    }
    
    private func makeNewsFeedItemViewModel(groups: [GroupModel],
                                           items: [ItemsModel],
                                           profiles: [ProfileModel],
                                           nextFrom: String) -> NewsFeedItems {
        NewsFeedItems(groups: groups, items: items, profiles: profiles, nextFrom: nextFrom)
    }
    
}
