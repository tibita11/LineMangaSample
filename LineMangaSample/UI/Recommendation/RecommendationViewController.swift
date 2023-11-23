//
//  RecommendationViewController.swift
//  LineMangaSample
//
//  Created by 鈴木楓香 on 2023/11/10.
//

import UIKit
import PinLayout

// 2番目のHeaderを先に作る
// 3番目のCellを作る
// 1番目をHeaderに変更する

final class RecommendationViewController: UIViewController {
    
    enum Section {
        case topCarousel
        case subHeader
    }
    
    enum Item: Hashable {
        case topCarousel(image: CarouselImage)
    }

    private var collectionView: UICollectionView!
    private lazy var tabHeight: CGFloat = {
        tabBarController?.tabBar.bounds.height ?? 0
    }()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        configureHierarchy()
        cofigureDataSource()
        apply()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.tintColor = .black
    }
}

extension RecommendationViewController {
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self]
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self else { return nil }
            switch dataSource.snapshot().sectionIdentifiers[sectionIndex] {
            case .topCarousel:
                return createTopCarouselLayout()
            case .subHeader:
                return createSubHeader()
            }
        }
        return layout
    }
    
    private func createTopCarouselLayout() -> NSCollectionLayoutSection {
        let width = collectionView.bounds.width
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .absolute(width * (3 / 4)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        return section
    }
    
    private func createSubHeader() -> NSCollectionLayoutSection {
        // Cellのサイズが、0.0よりも大きくなければならない
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(.leastNonzeroMagnitude))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(55.0))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "subHeader", alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
}

extension RecommendationViewController {
    private func configureHierarchy() {
        navigationController?.addCommonButton(to: self)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.contentInsetAdjustmentBehavior = .never
        self.view.addSubview(collectionView)
    }
    
    private func configureLayout() {
        collectionView.pin.top().horizontally().bottom(tabHeight)
    }
    
    private func cofigureDataSource() {
        let topCarouselCell = UICollectionView.CellRegistration<RecommendationTopCarouselCell, Item> { cell, indexPath, itemIdentifier in
            switch itemIdentifier {
            case let .topCarousel(carouselImage):
                cell.configure(UIImage(named: carouselImage.image)!)
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .topCarousel:
                return collectionView.dequeueConfiguredReusableCell(using: topCarouselCell, for: indexPath, item: itemIdentifier)
            }
        })
    }
}

extension RecommendationViewController {
    private func apply() {
        let mockData = createRecommendationMockData()
        let subHeaderRegistration = UICollectionView.SupplementaryRegistration<SubHeaderView>(elementKind: "subHeader") { supplementaryView, elementKind, indexPath in
            if case .subHeader(let hederButton) = mockData.data[indexPath.section] {
                supplementaryView.configure(items: hederButton)
            }
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            switch kind {
            case "subHeader":
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: subHeaderRegistration, for: index)
            default:
                return nil
            }
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        mockData.data.forEach {
            switch $0 {
            case let .topCarousel(carouselImages):
                snapshot.appendSections([.topCarousel])
                var items: [Item] = []
                carouselImages.forEach {
                    items.append(Item.topCarousel(image: $0))
                }
                snapshot.appendItems(items, toSection: .topCarousel)
            case .subHeader:
                snapshot.appendSections([.subHeader])
            }
        }
        dataSource.apply(snapshot)
    }
}
