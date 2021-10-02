//
//  Post.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 05.08.2021.
//

import UIKit

// MARK: - NewsResponse

struct NewsResponse: Decodable {
    let response: NewsResponseItem
}

// MARK: - NewsResponseItem

struct NewsResponseItem: Decodable {
    let groups: [NewsGroup]
    let items: [NewsItem]
    let profiles: [NewsProfile]
}

// MARK: - NewsGroup

struct NewsGroup: Decodable {
    let id: Int
    let photo: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case photo = "photo_200"
        case name
    }
}

// MARK: - NewsItem

struct NewsItem: Decodable {
    let id: Int
    let date: Date
    let text: String
    let attachments: [NewsItemAttachment]?
    let sourceID: Int
    let comments: NewsItemComments?
    let likes: NewsItemLikes?
    
    enum CodingKeys: String, CodingKey {
        case id = "post_id"
        case date
        case text
        case attachments
        case sourceID = "source_id"
        case comments
        case likes
    }
}

// MARK: - NewsItemComments

struct NewsItemComments: Decodable {
    let count: Int
}

// MARK: - NewsItemLikes

struct NewsItemLikes: Decodable {
    let count: Int
    let userLikes: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - NewsProfile

struct NewsProfile: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_100"
    }
}

// MARK: - NewsItemAttachment

struct NewsItemAttachment: Decodable {
    let photo: NewsPhoto?
}

// MARK: - NewsPhoto

struct NewsPhoto: Decodable {
    let id: Int
    let sizes: [NewsPhotoSize]
}

// MARK: - NewsPhotoSize

struct NewsPhotoSize: Decodable {
    let width: Int
    let height: Int
    let url: String
}

//comments =                 {
//                    "can_post" = 1;
//                    count = 0;
//                    "groups_can_post" = 1;
//                };
//                date = 1632247052;
//likes =                 {
//                    "can_like" = 1;
//                    "can_publish" = 1;
//                    count = 1;
//                    "user_likes" = 0;
//                };


//{
//    response =     {
//        groups =         (
//            {
//                id = 27282322;
//                "is_admin" = 0;
//                "is_advertiser" = 0;
//                "is_closed" = 0;
//                "is_member" = 1;
//                name = "\U0421\U0415\U0420\U0418\U0410\U041b\U042b | \U0410\U0418\U0423: \U0414\U0432\U043e\U0439\U043d\U043e\U0439 \U0441\U0435\U0430\U043d\U0441. \U041a\U0440\U043e\U0432\U0430\U0432\U044b\U0439 \U043f\U0440\U0438\U043b\U0438\U0432";
//                "photo_100" = "https://sun1-14.userapi.com/s/v1/ig2/gp72jUEXoxWAS7ct4P46kYJf1COrDEfniH3OtiG7tzMpslUC8z8RtU68SEJtBI4Pa_Q3VYsqNkOO940KWZqh8vsV.jpg?size=100x100&quality=95&crop=196,130,727,727&ava=1";
//                "photo_200" = "https://sun1-14.userapi.com/s/v1/ig2/AT2MqS7idjqKaCmh3_-9ugctLuRG1V4rDmCCEHzCml3hOwiq_5XGazPsQ6aNCjRn_3u8mSE70NlOyalLYZ23uFnQ.jpg?size=200x200&quality=95&crop=196,130,727,727&ava=1";
//                "photo_50" = "https://sun1-14.userapi.com/s/v1/ig2/F6o78hDfKbzka8eMgmF6pRJdInN7-oF3eXfnaCY7ElXdkbOUQBmKuqDf2XkE-qDcoAXzYuyS7Dkp-VX0cBYSHvSE.jpg?size=50x50&quality=95&crop=196,130,727,727&ava=1";
//                "screen_name" = "ahs_tv";
//                type = page;
//            },
//            {
//                id = 98141195;
//                "is_admin" = 0;
//                "is_advertiser" = 0;
//                "is_closed" = 0;
//                "is_member" = 1;
//                name = "Killing Eve | \U0423\U0431\U0438\U0432\U0430\U044f \U0415\U0432\U0443 | \U0441\U0435\U0440\U0438\U0430\U043b";
//                "photo_100" = "https://sun1-99.userapi.com/s/v1/ig2/0nBenIY8219Whst3VFA31rjp-6nbpHTnrASDjvPFvgqiygqU2srEbVemx3p6x94wCqAyzX3s6sf4vV7sCMItSpFx.jpg?size=100x100&quality=96&crop=0,135,1080,1080&ava=1";
//                "photo_200" = "https://sun1-99.userapi.com/s/v1/ig2/XyrV-NEJ7zX2vhZS9jemYzB61wajlu0ZEwekr-3g_1XlEEQZmRMOF2cSZaatHOcMGRBxPMSVuMzm3uE_47vvggKy.jpg?size=200x200&quality=96&crop=0,135,1080,1080&ava=1";
//                "photo_50" = "https://sun1-99.userapi.com/s/v1/ig2/SbQauVFma257fMI8aUQj1eJxEHuhOYgYAX6wlql7WR9OEteAE9vpkyByzJrJoe50zC1FhRtm4BvbYz76bjrz5Cfa.jpg?size=50x50&quality=96&crop=0,135,1080,1080&ava=1";
//                "screen_name" = club98141195;
//                type = group;
//            },
//            {
//                id = 101972843;
//                "is_admin" = 0;
//                "is_advertiser" = 0;
//                "is_closed" = 0;
//                "is_member" = 1;
//                name = "\U0410\U0440\U0445\U0438\U0432 \U044d\U0441\U043a\U0438\U0437\U043e\U0432 \U0434\U043b\U044f \U0442\U0430\U0442\U0443.";
//                "photo_100" = "https://sun1-97.userapi.com/s/v1/if1/wQDAG_m4kAPHxf4TMd-l316Gk0LtscR9HcvKgUcKNeVX9PF-wATtR75JcFupF-fzL1aU5Leu.jpg?size=100x100&quality=96&crop=0,30,401,401&ava=1";
//                "photo_200" = "https://sun1-97.userapi.com/s/v1/if1/H9B8ADO35jpjGqxtmKt9hSxPC89GiGfg-fNBct1ldN8bLDB8VjwsfwwZ7WYSMzk1PGDu4w6J.jpg?size=200x200&quality=96&crop=0,30,401,401&ava=1";
//                "photo_50" = "https://sun1-97.userapi.com/s/v1/if1/9RKTVA0szS_-l54A5z2rV9NVnM7w5tCeOotCrrZBumSMqorLj0PJIVW5EGYKj_gr6YD28Yci.jpg?size=50x50&quality=96&crop=0,30,401,401&ava=1";
//                "screen_name" = mytattooeskiz;
//                type = page;
//            }
//        );
//        items =         (
//            {
//                attachments =                 (
//                    {
//                        photo =                         {
//                            "access_key" = 4db25b919a0dc747bc;
//                            "album_id" = "-7";
//                            date = 1632247052;
//                            "has_tags" = 0;
//                            id = 457246284;
//                            "owner_id" = "-98141195";
//                            "post_id" = 17235;
//                            sizes =                             (
//                            {
//                            height = 130;
//                            type = m;
//                            url = "https://sun9-27.userapi.com/impg/pt03C835JryBuqExCYJ_al3gdQuj0_IVkNMc_g/hVGKksmFfHw.jpg?size=130x130&quality=96&sign=10baeb1301475478b084335a7e04f876&c_uniq_tag=VdBAzR4UW1VEVynevbB--lzUBtGpPNw9rUHeCIy3ntY&type=album";
//                            width = 130;
//                            }
//                            );
//                            text = "";
//                            "user_id" = 100;
//                        };
//                        type = photo;
//                    }
//                );
//                "can_doubt_category" = 0;
//                "can_set_category" = 0;
//                comments =                 {
//                    "can_post" = 1;
//                    count = 0;
//                    "groups_can_post" = 1;
//                };
//                date = 1632247052;
//                donut =                 {
//                    "is_donut" = 0;
//                };
//                "is_favorite" = 0;
//                likes =                 {
//                    "can_like" = 1;
//                    "can_publish" = 1;
//                    count = 1;
//                    "user_likes" = 0;
//                };
//                "marked_as_ads" = 0;
//                "post_id" = 17235;
//                "post_source" =                 {
//                    platform = iphone;
//                    type = api;
//                };
//                "post_type" = post;
//                reposts =                 {
//                    count = 0;
//                    "user_reposted" = 0;
//                };
//                "short_text_rate" = "0.8";
//                "signer_id" = 265882253;
//                "source_id" = "-98141195";
//                text = "#KillingEve";
//                type = post;
//                views =                 {
//                    count = 13;
//                };
//            },
//            {
//                attachments =                 (
//                    {
//                        photo =                         {
//                            "access_key" = 66988be03067e8bf96;
//                            "album_id" = "-7";
//                            date = 1632243483;
//                            "has_tags" = 0;
//                            id = 457419830;
//                            "owner_id" = "-101972843";
//                            "post_id" = 271023;
//                            sizes =                             (
//                            {
//                            height = 130;
//                            type = m;
//                            url = "https://sun1-97.userapi.com/impg/LKaQ-rS9hIZSSrobNJsLPSepdkmqMrMk6mEKzg/DVjvTUBDXTQ.jpg?size=98x130&quality=96&sign=8c8738fcaeef621c451f6cfbc9cf0b4e&c_uniq_tag=h3jGGB0Ulvzkz9vPbPJNFiwTY7X-abfK029YSfk4_TQ&type=album";
//                            width = 98;
//                            }
//                            );
//                            text = "";
//                            "user_id" = 100;
//                        };
//                        type = photo;
//                    }
//                );
//                "can_doubt_category" = 0;
//                "can_set_category" = 0;
//                comments =                 {
//                    "can_post" = 1;
//                    count = 0;
//                    "groups_can_post" = 1;
//                };
//                date = 1632247020;
//                donut =                 {
//                    "is_donut" = 0;
//                };
//                "is_favorite" = 0;
//                likes =                 {
//                    "can_like" = 1;
//                    "can_publish" = 1;
//                    count = 5;
//                    "user_likes" = 0;
//                };
//                "marked_as_ads" = 0;
//                "post_id" = 271031;
//                "post_source" =                 {
//                    type = api;
//                };
//                "post_type" = post;
//                reposts =                 {
//                    count = 0;
//                    "user_reposted" = 0;
//                };
//                "short_text_rate" = "0.8";
//                "source_id" = "-101972843";
//                text = "\U0416\U0435\U0441\U0442\U044c \Ud83d\Ude31";
//                type = post;
//                views =                 {
//                    count = 288;
//                };
//            },
//            {
//                attachments =                 (
//                    {
//                        photo =                         {
//                            "access_key" = 9875220e9ee2ff8a65;
//                            "album_id" = "-7";
//                            date = 1632246964;
//                            "has_tags" = 0;
//                            id = 457302754;
//                            "owner_id" = "-27282322";
//                            "post_id" = 731044;
//                            sizes =                             (
//                            {
//                            height = 130;
//                            type = m;
//                            url = "https://sun1-86.userapi.com/impg/DqKebcUsQnU-cuRMYKolqWecZQcnXk0SIIKunA/GNZAbFu79cA.jpg?size=130x130&quality=96&sign=27868bc01126daeb612f251554861c63&c_uniq_tag=9B0BEfgQlU9TMNtmndFOX1emKZCIJsFNMnkgymUR3Xw&type=album";
//                            width = 130;
//                            }
//                            );
//                            text = "";
//                            "user_id" = 100;
//                        };
//                        type = photo;
//                    }
//                );
//                "can_doubt_category" = 0;
//                "can_set_category" = 0;
//                comments =                 {
//                    "can_post" = 1;
//                    count = 0;
//                };
//                date = 1632246964;
//                donut =                 {
//                    "is_donut" = 0;
//                };
//                "is_favorite" = 0;
//                likes =                 {
//                    "can_like" = 1;
//                    "can_publish" = 1;
//                    count = 5;
//                    "user_likes" = 0;
//                };
//                "marked_as_ads" = 0;
//                "post_id" = 731044;
//                "post_source" =                 {
//                    type = api;
//                };
//                "post_type" = post;
//                reposts =                 {
//                    count = 0;
//                    "user_reposted" = 0;
//                };
//                "short_text_rate" = "0.8";
//                "source_id" = "-27282322";
//                text = "\U042d\U0432\U0430\U043d \U043f\U043e\U0441\U043b\U0435 \U0432\U0435\U0447\U0435\U0440\U0438\U043d\U043a\U0438 \"\U042d\U043c\U043c\U0438\"\n\U041e\U043d \U0432\U044b\U0433\U043b\U044f\U0434\U0438\U0442 \U0442\U0430\U043a\U0438\U043c \U0441\U0447\U0430\U0441\U0442\U043b\U0438\U0432\U044b\U043c \Ud83d\Ude0d";
//                type = post;
//                views =                 {
//                    count = 135;
//                };
//            }
//        );
//        "next_from" = "3/5_-27282322_731044:1932607381";
//        profiles =         (
//            {
//                "can_access_closed" = 1;
//                "first_name" = "\U0410\U0434\U043c\U0438\U043d\U0438\U0441\U0442\U0440\U0430\U0446\U0438\U044f \U0412\U041a\U043e\U043d\U0442\U0430\U043a\U0442\U0435";
//                id = 100;
//                "is_closed" = 0;
//                "last_name" = "";
//                online = 0;
//                "online_info" =                 {
//                    "is_mobile" = 0;
//                    "is_online" = 0;
//                    visible = 1;
//                };
//                "photo_100" = "https://sun1-87.userapi.com/s/v1/if1/FPQPV_koiq2Wl3rP-mMR4pMWVfjBEbMgEpf53VqwjWE3mg3efUlWDODXclQYS6ABnmtMJD0Y.jpg?size=100x100&quality=96&crop=0,0,400,400&ava=1";
//                "photo_50" = "https://sun1-87.userapi.com/s/v1/if1/G4xihi1FT7BnS-Y0mUNUoLLVXT-48Vvd0EqjZFm_hnj4_KazXUExv8vvpCxm-y-wWkMQJJNR.jpg?size=50x50&quality=96&crop=0,0,400,400&ava=1";
//                "screen_name" = id100;
//                sex = 1;
//            },
//            {
//                "can_access_closed" = 0;
//                "first_name" = "\U041d\U0438\U043d\U0430";
//                id = 265882253;
//                "is_closed" = 1;
//                "last_name" = "\U0421\U0438\U043c\U043e\U043d";
//                online = 1;
//                "online_app" = 3140623;
//                "online_info" =                 {
//                    "app_id" = 3140623;
//                    "is_mobile" = 1;
//                    "is_online" = 1;
//                    "last_seen" = 1632247140;
//                    visible = 1;
//                };
//                "online_mobile" = 1;
//                "photo_100" = "https://sun1-25.userapi.com/s/v1/ig2/-9ZMXvnu51r73q1_3llFCQdqcYSU1Op9H_u2DTUEhJsdkOyGFBTvHpwy-xMAp64_eGWLJYNZmqy2bMfpoDGwOQ2S.jpg?size=100x100&quality=96&crop=0,0,515,515&ava=1";
//                "photo_50" = "https://sun1-25.userapi.com/s/v1/ig2/GwDsFG2j9LL86jsIQEOGc33dUNiSCZha0s-gkNkkpNtGTVfTUWgGb3pveYeLzalfPMpVkgEJeO4StUPqG4xx5HuL.jpg?size=50x50&quality=96&crop=0,0,515,515&ava=1";
//                "screen_name" = id265882253;
//                sex = 1;
//            }
//        );
//    };
//}
