//
//  AdvertisementView.swift
//  LineMangaSample
//
//  Created by 鈴木楓香 on 2023/11/25.
//

import UIKit
import PinLayout

class AdvertisementView: UICollectionReusableView {
    
    private let imageView = {
        let imageView: UIImageView = .init()
        imageView.contentMode = .scaleToFill
        return imageView
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

extension AdvertisementView {
    private func configureHierarchy() {
        addSubview(imageView)
    }
    
    private func configureLayout() {
        imageView.pin.all()
    }
    
    func configure(image: String) {
        self.imageView.image = UIImage(named: image)
    }
}
