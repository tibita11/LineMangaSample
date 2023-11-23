//
//  RecommendationTopCarouselCell.swift
//  LineMangaSample
//
//  Created by 鈴木楓香 on 2023/11/19.
//

import UIKit
import PinLayout

class RecommendationTopCarouselCell: UICollectionViewCell {
    
    private let imageView: UIImageView = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureLayout()
    }
}

extension RecommendationTopCarouselCell {
    private func configureHierarchy() {
        contentView.addSubview(imageView)
    }
    
    private func configureLayout() {
        imageView.pin.all()
    }
    
    func configure(_ image: UIImage) {
        self.imageView.image = image
    }
}
