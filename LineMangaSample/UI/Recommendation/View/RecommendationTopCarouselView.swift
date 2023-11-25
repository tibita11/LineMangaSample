//
//  RecommendationTopCarouselView.swift
//  LineMangaSample
//
//  Created by 鈴木楓香 on 2023/11/25.
//

import UIKit

class RecommendationTopCarouselView: UICollectionReusableView {
    
    private var collectionView: UICollectionView!
    private var items: [CarouselImage] = []
    
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

extension RecommendationTopCarouselView {
    private func configureHierarchy() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(RecommendationTopCarouselCell.self, forCellWithReuseIdentifier: "cell")
        addSubview(collectionView)
    }
    
    private func configureLayout() {
        collectionView.pin.all()
    }
    
    func configure(items: [CarouselImage]) {
        self.items = items
        collectionView.reloadData()
    }
}

extension RecommendationTopCarouselView: UICollectionViewDelegate {
    
}

extension RecommendationTopCarouselView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? RecommendationTopCarouselCell else {
            return UICollectionViewCell()
        }
        cell.configure(UIImage(named: items[indexPath.row].image) ?? UIImage())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width, height: self.collectionView.bounds.height)
    }
}
