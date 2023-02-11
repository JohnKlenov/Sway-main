//
//  ProductCell.swift
//  Sway
//
//  Created by Evgenyi on 4.02.23.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    static var reuseID = "ProductCell"
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    let brandLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.backgroundColor = .clear
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let modelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13)
        label.backgroundColor = .clear
        label.textColor = .black.withAlphaComponent(0.8)
        label.numberOfLines = 0
        return label
    }()
    
    let mallLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13)
        label.backgroundColor = .clear
        label.textColor = .orange.withAlphaComponent(0.8)
        label.numberOfLines = 0
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.backgroundColor = .clear
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 0
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackView()
        contentView.addSubview(imageView)
        contentView.addSubview(stackView)
        setupConstraints()
//        backgroundColor = .lightGray
    }
    
    private func configureStackView() {
        let arrayViews = [brandLabel, modelLabel, mallLabel, priceLabel]
        arrayViews.forEach { view in
            stackView.addArrangedSubview(view)
        }
    }
    
    private func setupConstraints() {
        
        let topImageViewCnstr = imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0)
        topImageViewCnstr.priority = UILayoutPriority(999)
        topImageViewCnstr.isActive = true
        
        let trailingImageViewCnstr = imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
//        trailingImageViewCnstr.priority = UILayoutPriority(1000)
        trailingImageViewCnstr.isActive = true
        
        let leadingImageViewCnstr = imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0)
//        leadingImageViewCnstr.priority = UILayoutPriority(1000)
        leadingImageViewCnstr.isActive = true
        
        let heightImageViewCnstr = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1)
//        heightImageViewCnstr.priority = UILayoutPriority(1000)
        heightImageViewCnstr.isActive = true
        
        let topStackCnstr = stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0)
//        topStackCnstr.priority = UILayoutPriority(1000)
        topStackCnstr.isActive = true
        
        let trailingStackCnstr = stackView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
//        trailingStackCnstr.priority = UILayoutPriority(1000)
        trailingStackCnstr.isActive = true
        
        let leadingStackCnstr = stackView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor)
//        leadingStackCnstr.priority = UILayoutPriority(1000)
        leadingStackCnstr.isActive = true
        
        let bottomStackCnstr = stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        bottomStackCnstr.priority = UILayoutPriority(999)
        bottomStackCnstr.isActive = true
    }
    
    func configureCell(model: MImage) {
        imageView.image = UIImage(named: model.image)
            brandLabel.text = model.brand
            modelLabel.text = model.model
            mallLabel.text = model.mall
            priceLabel.text = model.price
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
//            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
//            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
//            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1),
//
//            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
//            stackView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
//            stackView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
////            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
////            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
////            stackView.heightAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1/2),
////            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
//        ])
