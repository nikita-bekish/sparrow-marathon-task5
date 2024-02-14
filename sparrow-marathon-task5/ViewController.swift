//
//  ViewController.swift
//  sparrow-marathon-task5
//
//  Created by Nikita Bekish on 14.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private let actionButton = UIButton()
    let secondVC = SecondViewController()
    private let triangleView = TriangleVieww()

    
    private lazy var controllerHeightConstraint = secondVC.view.heightAnchor.constraint(equalToConstant: 280)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupUI()
    }

    private func setupUI() {
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        actionButton.setTitle("Present", for: .normal)
        actionButton.setTitleColor(.systemBlue, for: .normal)
        actionButton.addTarget(self, action: #selector(showController), for: .touchUpInside)
    }
    
    @objc private func showController() {
        secondVC.view.translatesAutoresizingMaskIntoConstraints = false
        triangleView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(triangleView)
        view.addSubview(secondVC.view)
        
        view.tintAdjustmentMode = .dimmed
        
        let action1 = UIAction(title: "280pt", handler: { _ in
            UIView.animate(withDuration: 0.3) {
                self.controllerHeightConstraint.constant = 280
                self.view.layoutIfNeeded()
            }
        })
        let action2 = UIAction(title: "150pt", handler: { _ in
            UIView.animate(withDuration: 0.3) {
                self.controllerHeightConstraint.constant = 150
                self.view.layoutIfNeeded()
            }
        })
        
        secondVC.configure(closeAction: { [weak self] in
            self?.hideController()
        }, action1: action1, action2: action2, selectedIndex: controllerHeightConstraint.constant == 280 ? 0 : 1)
        
        NSLayoutConstraint.activate([
            triangleView.bottomAnchor.constraint(equalTo: secondVC.view.topAnchor),
            triangleView.centerXAnchor.constraint(equalTo: secondVC.view.centerXAnchor),
            triangleView.widthAnchor.constraint(equalToConstant: 40),
            triangleView.heightAnchor.constraint(equalToConstant: 20),
            
            secondVC.view.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 20),
            secondVC.view.widthAnchor.constraint(equalToConstant: 300),
            controllerHeightConstraint,
            secondVC.view.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        secondVC.modalPresentationStyle = .overFullScreen
        secondVC.didMove(toParent: self)
    }
    
    @objc private func hideController() {
        secondVC.willMove(toParent: nil)
        secondVC.view.removeFromSuperview()
        triangleView.removeFromSuperview()
        secondVC.removeFromParent()
        view.tintAdjustmentMode = .normal
    }
}


class TriangleVieww: UIView {

    override func draw(_ rect: CGRect) {

        let layerHeight = layer.frame.height
        let layerWidth = layer.frame.width

        let bezierPath = UIBezierPath()

        bezierPath.move(to: CGPoint(x: 0, y: layerHeight))
        bezierPath.addLine(to: CGPoint(x: layerWidth, y: layerHeight))
        bezierPath.addLine(to: CGPoint(x: layerWidth / 2, y: 0))
        bezierPath.addLine(to: CGPoint(x: 0, y: layerHeight))
        bezierPath.close()

        UIColor.systemGray6.setFill()
        bezierPath.fill()

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        layer.mask = shapeLayer
    }
}
