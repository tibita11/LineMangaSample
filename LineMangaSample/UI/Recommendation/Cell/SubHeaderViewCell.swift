//
//  SubHeaderViewCell.swift
//  LineMangaSample
//
//  Created by 鈴木楓香 on 2023/11/23.
//

import UIKit
import PinLayout

class SubHeaderViewCell: UICollectionViewCell {
    
    private let imageView = {
        let imageView: UIImageView = .init()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let title = {
        let title: UILabel = .init()
        title.font = UIFont.systemFont(ofSize: 10)
        title.textAlignment = .center
        return title
    }()
    
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

extension SubHeaderViewCell {
    private func configureHierarchy() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(title)
    }
    
    private func configureLayout() {
        let space = 5.0
        title.pin.horizontally().bottom(space).height(10)
        imageView.pin.horizontally().top(space).above(of: title).marginBottom(5)
    }
    
    func configure(image: String, title: String, color: UIColor) {
        self.imageView.image = UIImage(systemName: image)
        self.imageView.tintColor = color
        self.title.text = title
    }
}
