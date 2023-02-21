//
//  MallViewController.swift
//  Sway
//
//  Created by Evgenyi on 19.02.23.
//

import UIKit

class MallViewController: UIViewController {

    var heightCnstrCollectionView: NSLayoutConstraint!
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let stackViewContainerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let testView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        view.heightAnchor.constraint(equalToConstant: 900).isActive = true
        return view
    }()
 
    private var section: [MallSection]!
    private var collectionViewLayout:UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<MallSection, MImage>!
    weak var delegate: PagingSectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        section = MallSection.getData()
        setupScrollView()
        setupCollectionView()
        setupSubviews()
        createDataSource()
        reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        heightCnstrCollectionView.constant = collectionViewLayout.collectionViewLayout.collectionViewContentSize.height
        heightCnstrCollectionView.isActive = true
        print("collectionViewContentSize -  \(collectionViewLayout.collectionViewLayout.collectionViewContentSize.height)")
    }
    
    private func setupScrollView() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackViewContainerView)
        
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        stackViewContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackViewContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackViewContainerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackViewContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackViewContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    private func setupSubviews() {
        stackViewContainerView.addArrangedSubview(collectionViewLayout)
        stackViewContainerView.addArrangedSubview(testView)
    }
    
    private func setupCollectionView() {
        collectionViewLayout = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionViewLayout.translatesAutoresizingMaskIntoConstraints = false
        collectionViewLayout.backgroundColor = .clear
        collectionViewLayout.register(MallCell.self, forCellWithReuseIdentifier: MallCell.reuseID)
        collectionViewLayout.register(BrandCell.self, forCellWithReuseIdentifier: BrandCell.reuseID)
        collectionViewLayout.register(PagingSectionFooterView.self, forSupplementaryViewOfKind: "FooterMall", withReuseIdentifier: PagingSectionFooterView.footerIdentifier)
        collectionViewLayout.register(HeaderBrandsMallView.self, forSupplementaryViewOfKind: "HeaderBrands", withReuseIdentifier: HeaderBrandsMallView.headerIdentifier)
        heightCnstrCollectionView = collectionViewLayout.heightAnchor.constraint(equalToConstant: 0)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([collectionViewLayout.topAnchor.constraint(equalTo: stackViewContainerView.topAnchor), collectionViewLayout.bottomAnchor.constraint(equalTo: testView.topAnchor), collectionViewLayout.trailingAnchor.constraint(equalTo: stackViewContainerView.trailingAnchor), collectionViewLayout.leadingAnchor.constraint(equalTo: stackViewContainerView.leadingAnchor)])
    }
    
    private func createDataSource() {

        dataSource = UICollectionViewDiffableDataSource<MallSection, MImage>(collectionView: collectionViewLayout, cellProvider: { collectionView, indexPath, cellData in
            switch self.section[indexPath.section].section {
            case "Mall":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MallCell.reuseID, for: indexPath) as? MallCell
                cell?.configureCell(model: cellData, currentFrame: cell?.frame.size ?? CGSize())
                return cell
            case "Brands":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandCell.reuseID, for: indexPath) as? BrandCell
                cell?.configureCell(model: cellData)
                return cell
            default:
                print("default createDataSource")
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandCell.reuseID, for: indexPath) as? BrandCell
                cell?.configureCell(model: cellData)
                return cell
            }
        })
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, IndexPath in
            
            if kind == "FooterMall" {
                let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: PagingSectionFooterView.footerIdentifier, withReuseIdentifier: PagingSectionFooterView.footerIdentifier, for: IndexPath) as? PagingSectionFooterView
                let itemCount = self.dataSource.snapshot().numberOfItems(inSection: self.section[IndexPath.section])
                footerView?.configure(with: itemCount)
                self.delegate = footerView
                return footerView
            } else if kind == "HeaderBrands" {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: HeaderBrandsMallView.headerIdentifier, withReuseIdentifier: HeaderBrandsMallView.headerIdentifier, for: IndexPath) as? HeaderBrandsMallView
                headerView?.configureCell(title: "Brands for mall")
                return headerView
            } else {
                return nil
            }
        }
    }
    
    private func reloadData() {

        var snapshot = NSDiffableDataSourceSnapshot<MallSection, MImage>()
        snapshot.appendSections(section)

        for item in section {
            snapshot.appendItems(item.items, toSection: item)
        }
        dataSource?.apply(snapshot)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = self.section[sectionIndex]
            
            switch section.section {
            case "Mall":
                return self.mallBannerSections()
            case "Brands":
                return self.brandsSection()
            default:
                print("default createLayout")
                return self.mallBannerSections()
            }
        }
//        layout.register(BackgroundViewCollectionReusableView.self, forDecorationViewOfKind: "background")
    return layout
    }
    
    private func mallBannerSections() -> NSCollectionLayoutSection {
//        .fractionalHeight(0.25)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
//        absolute(225)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
//        groupPagingCentered
//        section.orthogonalScrollingBehavior = .paging
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        let sizeFooter = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(20))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sizeFooter, elementKind: "FooterMall", alignment: .bottom)
        section.boundarySupplementaryItems = [footer]
        
        section.visibleItemsInvalidationHandler = { [weak self] (visibleItems, offset, env) -> Void in
            guard let self = self else {return}
            let currentPage = visibleItems.last?.indexPath.row ?? 0
            print("currentPage - \(currentPage)")
            self.delegate?.currentPage(index: currentPage)
        }
        
        return section
    }
    
    private func brandsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(20) )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: NSCollectionLayoutSpacing.fixed(10), trailing: nil, bottom: nil)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(20))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        
//        let background = NSCollectionLayoutDecorationItem.background(elementKind: "background")
//        background.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
//        section.decorationItems = [background]
        
        let sizeHeader = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(20))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sizeHeader, elementKind: "HeaderBrands", alignment: .top)
        header.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [header]
        return section
    }
}

//}
