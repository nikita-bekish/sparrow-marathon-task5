//
//  SecondViewController.swift
//  sparrow-marathon-task5
//
//  Created by Nikita Bekish on 14.02.2024.
//

import UIKit

final class SecondViewController: UIViewController {
            
    let segmentedControl = UISegmentedControl()
    
    private let closeButton = UIButton()
    private let closeImageView = UIImageView(image: UIImage(systemName: "xmark.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28, weight: .regular, scale: .medium)))
    
    private var closeAction: (() -> Void)?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6

        setupUI()
    }
    
    func configure(closeAction: @escaping (() -> Void), action1: UIAction, action2: UIAction, selectedIndex: Int) {
        self.closeAction = closeAction
        
        segmentedControl.removeAllSegments()
        
        segmentedControl.insertSegment(action: action1, at: 0, animated: false)
        segmentedControl.insertSegment(action: action2, at: 1, animated: false)
        segmentedControl.selectedSegmentIndex = selectedIndex
    }
    
    private func setupUI() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
        view.addSubview(segmentedControl)
        
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            closeButton.widthAnchor.constraint(equalToConstant: 48),
            closeButton.heightAnchor.constraint(equalToConstant: 48),
            
            closeImageView.widthAnchor.constraint(equalToConstant: 48),
            closeImageView.heightAnchor.constraint(equalToConstant: 48),
            
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        closeButton.tintColor = .systemGray
        closeButton.setImage(closeImageView.image, for: .normal)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    @objc private func close() {
        closeAction?()
    }
}
