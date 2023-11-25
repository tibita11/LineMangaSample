//
//  RecommendationViewController.swift
//  LineMangaSample
//
//  Created by 鈴木楓香 on 2023/11/10.
//

import UIKit
import PinLayout

final class RecommendationViewController: UIViewController {
    
    enum Section {
        case topCarousel
        case subHeader
        case continuation
        case advertisement
    }
    
    enum Item: Hashable {
        case topCarousel(image: CarouselImage)
        case continuation(item: Book)
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
            case .continuation:
                return createContinuationLayout()
            case .advertisement:
                return createAdvertisementLayout()
            }
        }
        layout.register(SectionBackgroundDecorationView.self, forDecorationViewOfKind: "backgroundView")
        return layout
    }
    
    private func createTopCarouselLayout() -> NSCollectionLayoutSection {
        let width = collectionView.bounds.width
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(.leastNonzeroMagnitude))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let headerSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .absolute(width * (3 / 4)))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "topHeader", alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func createSubHeader() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(.leastNonzeroMagnitude))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(55.0))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "subHeader", alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        return section
    }
    
    private func createContinuationLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let with: CGFloat = collectionView.bounds.width * ( 60 / 360 )
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(with), heightDimension: .absolute(with * (16 / 9)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 15, trailing: 20)
        // 背景色
        let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: "backgroundView")
        section.decorationItems = [sectionBackgroundDecoration]
        // Header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50.0))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "continuationHeader", alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func createAdvertisementLayout() -> NSCollectionLayoutSection {
        let with = collectionView.bounds.width - 40
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(.leastNonzeroMagnitude))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        let headerSize = NSCollectionLayoutSize(widthDimension: .absolute(with), heightDimension: .absolute(with * (1 / 3)))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "advertisementHeader", alignment: .top)
        section.boundarySupplementaryItems = [header]
        // 背景色
        let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: "backgroundView")
        section.decorationItems = [sectionBackgroundDecoration]
        return section
    }
}

extension RecommendationViewController {
    private func configureHierarchy() {
        navigationController?.addCommonButton(to: self)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = .systemGray6
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
            default:
                break
            }
        }
        
        let continuationCell = UICollectionView.CellRegistration<ContinuationBookCell, Item> { cell, indexPath, itemIdentifier in
            switch itemIdentifier {
            case let .continuation(book):
                cell.configure(book: book)
            default:
                break
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .topCarousel:
                return collectionView.dequeueConfiguredReusableCell(using: topCarouselCell, for: indexPath, item: itemIdentifier)
            case .continuation:
                return collectionView.dequeueConfiguredReusableCell(using: continuationCell, for: indexPath, item: itemIdentifier)
            }
        })
    }
}

extension RecommendationViewController {
    // mockDataにsectionの色を持っている場合に、動的に背景色が変わるようにする
    private func apply() {
        let mockData = createRecommendationMockData()
        let topHeaderRegistration = UICollectionView.SupplementaryRegistration<RecommendationTopCarouselView>(elementKind: "topHeader") { supplementaryView, elementKind, indexPath in
            if case .topCarousel(let carouselImage) = mockData.data[indexPath.section] {
                supplementaryView.configure(items: carouselImage)
            }
        }
        
        let subHeaderRegistration = UICollectionView.SupplementaryRegistration<SubHeaderView>(elementKind: "subHeader") { supplementaryView, elementKind, indexPath in
            if case .subHeader(let hederButton) = mockData.data[indexPath.section] {
                supplementaryView.configure(items: hederButton)
            }
        }
        
        let continuationHeaderRegistration = UICollectionView.SupplementaryRegistration<BookHeaderView>(elementKind: "continuationHeader") { supplementaryView, elementKind, indexPath in
            supplementaryView.configure(title: "続きを読もう！")
        }
        
        let advertisementHeaderRegistration = UICollectionView.SupplementaryRegistration<AdvertisementView>(elementKind: "advertisementHeader") { supplementaryView, elementKind, indexPath in
            if case let .advertisement(item)  = mockData.data[indexPath.section] {
                supplementaryView.configure(image: item.image)
            }
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            switch kind {
            case "topHeader":
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: topHeaderRegistration, for: index)
            case "subHeader":
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: subHeaderRegistration, for: index)
            case "continuationHeader":
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: continuationHeaderRegistration, for: index)
            case "advertisementHeader":
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: advertisementHeaderRegistration, for: index)
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
            case let .continuation(books):
                snapshot.appendSections([.continuation])
                var item: [Item] = []
                books.forEach {
                    item.append(Item.continuation(item: $0))
                }
                snapshot.appendItems(item, toSection: .continuation)
            case .advertisement:
                snapshot.appendSections([.advertisement])
            }
        }
        dataSource.apply(snapshot)
    }
}
