//
//  ImageCell.swift
//  Sway
//
//  Created by Evgenyi on 30.01.23.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    static var reuseID: String = "ImageCell"
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        addSubview(imageView)
        setupConstraints()
    }
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: topAnchor), imageView.trailingAnchor.constraint(equalTo: trailingAnchor), imageView.leadingAnchor.constraint(equalTo: leadingAnchor), imageView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
    
    func configureCell(imageName: String) {
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
