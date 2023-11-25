//
//  SectionBackgroundDecorationView.swift
//  LineMangaSample
//
//  Created by 鈴木楓香 on 2023/11/24.
//

import UIKit

class SectionBackgroundDecorationView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension SectionBackgroundDecorationView {
    private func configureHierarchy() {
        backgroundColor = .systemBackground
    }
}

