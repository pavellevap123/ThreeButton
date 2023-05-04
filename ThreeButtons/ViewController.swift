//
//  ViewController.swift
//  ThreeButtons
//
//  Created by Pavel Paddubotski on 4.05.23.
//

import UIKit

class ViewController: UIViewController {
    
    var shrinkAnimator: UIViewPropertyAnimator?
    
    lazy var firstButton = createButton(with: "First Button")
    lazy var secondMediumButton = createButton(with: "Second Medium Button")
    lazy var thirdButton = createButton(with: "Third", action: thirdButtonAction)
    
    lazy var thirdButtonAction = UIAction { [weak self] _ in
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemBackground
        self?.present(viewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(firstButton)
        view.addSubview(secondMediumButton)
        view.addSubview(thirdButton)
        
        layout()
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            // firstButton
            firstButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //secondMediumButton
            secondMediumButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 8),
            secondMediumButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //thirdButton
            thirdButton.topAnchor.constraint(equalTo: secondMediumButton.bottomAnchor, constant: 8),
            thirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func createButton(with title: String, action: UIAction? = nil) -> UIButton {
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.image = UIImage(systemName: "arrow.forward.circle.fill")
        configuration.imagePadding = 8
        configuration.imagePlacement = .trailing
        configuration.preferredSymbolConfigurationForImage
        = UIImage.SymbolConfiguration(scale: .medium)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14)
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if let action {
            button.addAction(action, for: .touchUpInside)
        }
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchDown)
        button.addTarget(self, action: #selector(buttonReleased), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonReleased), for: .touchUpOutside)
        
        return button
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        shrinkAnimator?.stopAnimation(true)
        
        shrinkAnimator = UIViewPropertyAnimator(duration: 0.6, dampingRatio: 0.5) {
            sender.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }
        shrinkAnimator?.startAnimation()
    }
    
    @objc func buttonReleased(_ sender: UIButton) {
        shrinkAnimator?.stopAnimation(true)
        
        let unshrinkAnimator = UIViewPropertyAnimator(duration: 0.6, dampingRatio: 0.5) {
            sender.transform = .identity
        }
        unshrinkAnimator.startAnimation()
    }
}
