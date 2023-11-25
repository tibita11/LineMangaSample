//
//  SubHeaderView.swift
//  LineMangaSample
//
//  Created by 鈴木楓香 on 2023/11/23.
//

import UIKit
import PinLayout

class SubHeaderView: UICollectionReusableView {
    
    private var collectionView: UICollectionView!
    private var items: [HeaderButton]!
    
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

extension SubHeaderView {
    private func configureHierarchy() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SubHeaderViewCell.self, forCellWithReuseIdentifier: "cell")
        self.addSubview(collectionView)
    }
    
    private func configureLayout() {
        backgroundColor = .systemBackground
        collectionView.pin.vertically().horizontally(35)
    }
    
    func configure(items: [HeaderButton]) {
        self.items = items
    }
}

extension SubHeaderView: UICollectionViewDelegate {
    
}

extension SubHeaderView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(items.count)
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SubHeaderViewCell else {
            return UICollectionViewCell()
        }
        let item = items[indexPath.row]
        cell.configure(image: item.image, title: item.title, color: item.color)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width / CGFloat(self.items.count),
                      height: self.collectionView.bounds.height)
    }
}
