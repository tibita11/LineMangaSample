//
//  Recommendation.swift
//  LineMangaSample
//
//  Created by 鈴木楓香 on 2023/11/23.
//

import Foundation

struct Recommendation {
    let data: [Data]!
    
    enum Data {
        case topCarousel([CarouselImage])
        case subHeader([HeaderButton])
        case continuation([Book])
        case advertisement(Advertisement)
    }
}

func createRecommendationMockData() -> Recommendation {
    let images: [CarouselImage] = [
        CarouselImage(image: "hiroaka1"),
        CarouselImage(image: "hiroaka1"),
        CarouselImage(image: "hiroaka1"),
        CarouselImage(image: "hiroaka1")
    ]
    let topCarousel = Recommendation.Data.topCarousel(images)
    let buttons: [HeaderButton] = [
        HeaderButton(image: "dollarsign.circle.fill", title: "¥0パス", color: .red),
        HeaderButton(image: "menucard.fill", title: "新着", color: .green),
        HeaderButton(image: "giftcard.fill", title: "MY ギフト", color: .orange),
        HeaderButton(image: "ticket.fill", title: "クーポン", color: .purple)
    ]
    let subHeader = Recommendation.Data.subHeader(buttons)
    let books: [Book] = [
        Book(title: "僕のヒーローアカデミア", image: "hiroaka2", descriotion: "未読あり", isAttenstion: true, badge: .free),
        Book(title: "僕のヒーローアカデミア", image: "drstone1", descriotion: "あと22時間", isAttenstion: false, badge: nil),
        Book(title: "僕のヒーローアカデミア", image: "hiroaka2", descriotion: "恋愛", isAttenstion: false, badge: nil),
        Book(title: "僕のヒーローアカデミア", image: "drstone1", descriotion: "未読あり", isAttenstion: true, badge: .free),
        Book(title: "僕のヒーローアカデミア", image: "hiroaka2", descriotion: "未読あり", isAttenstion: true, badge: .free)
    ]
    let continuation = Recommendation.Data.continuation(books)
    let advertisement1 = Recommendation.Data.advertisement(Advertisement(image: "jujutsu1"))
    return Recommendation(data: [topCarousel, subHeader, continuation, advertisement1])
}
