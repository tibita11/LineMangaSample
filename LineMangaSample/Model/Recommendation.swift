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
    return Recommendation(data: [topCarousel, subHeader])
}
