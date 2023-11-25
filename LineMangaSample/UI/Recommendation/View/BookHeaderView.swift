//
//  BookOriginalHeaderView.swift
//  LineMangaSample
//
//  Created by 鈴木楓香 on 2023/11/24.
//

import UIKit
import PinLayout

class BookHeaderView: UICollectionReusableView {
    
    private let title = {
        let title: UILabel = .init()
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return title
    }()
    
    private let button = {
        let button: UIButton = .init()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .lightGray
        return button
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

extension BookHeaderView {
    private func configureHierarchy() {
        addSubview(title)
        addSubview(button)
    }
    
    private func configureLayout() {
        button.pin.bottom().right().size(30)
        title.pin.bottom().left().before(of: button, aligned: .center).height(of: button)
    }
    
    func configure(title: String) {
        self.title.text = title
    }
}
