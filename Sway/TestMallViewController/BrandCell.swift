//
//  BrandCell.swift
//  Sway
//
//  Created by Evgenyi on 19.02.23.
//

import UIKit

class BrandCell: UICollectionViewCell {
    
    static var reuseID: String = "BrandCell"
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 4
        image.clipsToBounds = true
        return image
    }()
    
    let labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .black
        label.backgroundColor = .orange
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(labelName)
        addSubview(imageView)
        setupConstraints()
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.black.cgColor
    }
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: topAnchor),
                                     imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1),
                                     labelName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
                                     labelName.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     labelName.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     labelName.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
    
    func configureCell(model: MImage) {
        imageView.image = UIImage(named: model.image)
        labelName.text = model.brand
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
