//
//  BookCell.swift
//  LineMangaSample
//
//  Created by 鈴木楓香 on 2023/11/24.
//

import UIKit
import PinLayout

class ContinuationBookCell: UICollectionViewCell {
    
    private let imageView = {
        let imageView: UIImageView = .init()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let descriptionLabel = {
        let title: UILabel = .init()
        title.font = UIFont.systemFont(ofSize: 10)
        title.textAlignment = .center
        return title
    }()
    
    private let badgeImageView = {
        let imageView: UIImageView = .init()
        imageView.contentMode = .scaleAspectFill
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

extension ContinuationBookCell {
    private func configureHierarchy() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(descriptionLabel)
        self.imageView.addSubview(badgeImageView)
    }
    
    private func configureLayout() {
        descriptionLabel.pin.horizontally().bottom().height(10)
        imageView.pin.horizontally().top().above(of: descriptionLabel).marginBottom(5)
        badgeImageView.pin.topLeft().size(20)
    }
    
    func configure(book: Book) {
        self.imageView.image = UIImage(named: book.image)
        self.descriptionLabel.text = book.descriotion
        if book.isAttenstion {
            self.descriptionLabel.textColor = .red
        } else {
            self.descriptionLabel.textColor = .lightGray
        }
        switch book.badge {
        case .free:
            self.badgeImageView.image = UIImage(named: "free1")
        case .pass:
            self.badgeImageView.image = UIImage(named: "free1")
        default:
            self.badgeImageView.image = UIImage()
        }
    }
}
