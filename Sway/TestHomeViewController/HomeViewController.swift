//
//  HomeViewController.swift
//  Sway
//
//  Created by Evgenyi on 30.01.23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    var section: [MSectionImage]!
    var segmentedControl: UISegmentedControl = {
        let item = ["Woman","Man"]
        let segmentControl = UISegmentedControl(items: item)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(didTapSegmentedControl(_:)), for: .valueChanged)
        return segmentControl
    }()
    
    var collectionViewLayout:UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<MSectionImage, MImage>?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HomeVC"
        self.view.backgroundColor = .systemBackground
        view.addSubview(segmentedControl)
        section = MSectionImage.getData()
        setupCollectionView()
        setupConstraints()
        createDataSource()
        reloadData()
    }
    @objc func didTapSegmentedControl(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            print("Tap segment Woman")
        case 1:
            print("Tap segment Man")
        default:
            print("break")
            break
        }
    }
    private func setupCollectionView() {
        
        collectionViewLayout = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionViewLayout.translatesAutoresizingMaskIntoConstraints = false
        collectionViewLayout.backgroundColor = .clear
//        collectionViewLayout.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionViewLayout)
        collectionViewLayout.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseID)
        collectionViewLayout.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseID)
        collectionViewLayout.register(MallsViewCell.self, forCellWithReuseIdentifier: MallsViewCell.reuseID)
        collectionViewLayout.register(HeaderProductView.self, forSupplementaryViewOfKind: "HeaderProduct", withReuseIdentifier: HeaderProductView.headerIdentifier)
        collectionViewLayout.register(HeaderCategoryView.self, forSupplementaryViewOfKind: "HeaderCategory", withReuseIdentifier: HeaderCategoryView.headerIdentifier)
        collectionViewLayout.register(HeaderMallsView.self, forSupplementaryViewOfKind: "HeaderMalls", withReuseIdentifier: HeaderMallsView.headerIdentifier)
        
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor), segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor), collectionViewLayout.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor), collectionViewLayout.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor), collectionViewLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor), collectionViewLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor)])
    }
    
    private func createDataSource() {

        dataSource = UICollectionViewDiffableDataSource<MSectionImage, MImage>(collectionView: collectionViewLayout, cellProvider: { collectionView, indexPath, cellData in
            switch self.section[indexPath.section].section {
            case "Malls":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MallsViewCell.reuseID, for: indexPath) as? MallsViewCell
                
                cell?.configureCell(model: cellData, currentFrame: cell?.frame.size ?? CGSize())
                
                return cell
            case "Category":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseID, for: indexPath) as? ImageCell
                cell?.configureCell(model: cellData)
                return cell
            case "Product":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseID, for: indexPath) as? ProductCell
                cell?.configureCell(model: cellData)
                return cell
            default:
                print("default createDataSource")
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseID, for: indexPath) as? ImageCell
                cell?.configureCell(model: cellData)
                return cell
            }
        })
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, IndexPath in
            
            if kind == "HeaderProduct" {
                let cell = collectionView.dequeueReusableSupplementaryView(ofKind: HeaderProductView.headerIdentifier, withReuseIdentifier: HeaderProductView.headerIdentifier, for: IndexPath) as? HeaderProductView
                cell?.configureCell(title: "Product")
                return cell
            } else if kind == "HeaderCategory" {
                let cell = collectionView.dequeueReusableSupplementaryView(ofKind: HeaderCategoryView.headerIdentifier, withReuseIdentifier: HeaderCategoryView.headerIdentifier, for: IndexPath) as? HeaderCategoryView
                cell?.configureCell(title: "Category")
                return cell
            } else if kind == "HeaderMalls" {
                let cell = collectionView.dequeueReusableSupplementaryView(ofKind: HeaderMallsView.headerIdentifier, withReuseIdentifier: HeaderMallsView.headerIdentifier, for: IndexPath) as? HeaderMallsView
                cell?.configureCell(title: "Malls")
                return cell
            } else {
                return nil
            }
        }
    }
    
    private func reloadData() {

        var snapshot = NSDiffableDataSourceSnapshot<MSectionImage, MImage>()
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
            case "Malls":
                return self.mallsBannerSections()
            case "Category":
                return self.categorySections()
            case "Product":
                return self.productSection()
            default:
                print("default createLayout")
                return self.mallsBannerSections()
            }
        }
        layout.register(BackgroundViewCollectionReusableView.self, forDecorationViewOfKind: "background")
    return layout
    }
    
    private func mallsBannerSections() -> NSCollectionLayoutSection {
//        .fractionalHeight(0.25)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        absolute(225)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalWidth(1/2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        let sizeHeader = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sizeHeader, elementKind: "HeaderMalls", alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func categorySections() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/5), heightDimension: .fractionalWidth(1/5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        
        
        let sizeHeader = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sizeHeader, elementKind: "HeaderCategory", alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
//        .fractionalWidth(2/3)
    private func productSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension:  .fractionalWidth(2/3)), subitem: item, count: 2)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        
        let background = NSCollectionLayoutDecorationItem.background(elementKind: "background")
        background.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        section.decorationItems = [background]
        
        let sizeHeader = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(20))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sizeHeader, elementKind: "HeaderProduct", alignment: .top)
        header.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [header]
        return section
    }
}


// MARK: - SwiftUI
import SwiftUI
struct ListProvider: PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        
        let listVC = HomeViewController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<ListProvider.ContainterView>) -> HomeViewController {
            return listVC
        }
        
        func updateUIViewController(_ uiViewController: ListProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<ListProvider.ContainterView>) {
            
        }
    }
}
