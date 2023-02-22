//
//  HeaderBrandsMallView.swift
//  Sway
//
//  Created by Evgenyi on 19.02.23.
//

import UIKit

class HeaderBrandsMallView: UICollectionReusableView {
        
    static let headerIdentifier = "HeaderBrands"
    let label:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.backgroundColor = .clear
        label.tintColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        setupConstraints()
        backgroundColor = .white
    }
   
    private func setupConstraints() {
        NSLayoutConstraint.activate([label.topAnchor.constraint(equalTo: topAnchor, constant: 5), label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5), label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0), label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)])
    }
    
    func configureCell(title: String) {
        label.text = title
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(label)
        setupConstraints()
        backgroundColor = .white
//        fatalError("init(coder:) has not been implemented")
    }
}
