//
//  FullImageViewController.swift
//  Mecha
//
//  Created by Mattia Valzelli on 13/05/2020.
//  Copyright © 2020 DuckMa srl. All rights reserved.
//

//import SDWebImage
import UIKit

final class FullImageViewController: UIViewController {
  let imageView = UIImageView()
  var url: URL?

  static func withURL(_ url: URL?) -> FullImageViewController {
    let controller = FullImageViewController()
    controller.url = url
    return controller
  }

  override func loadView() {
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(imageView)

    NSLayoutConstraint.activate([
      imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      imageView.topAnchor.constraint(equalTo: view.topAnchor),
      imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])

    imageView.enableZoom()
    //imageView.sd_setImage(with: url)
  }
}

extension UIImageView {
  fileprivate func enableZoom() {
    let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
    isUserInteractionEnabled = true
    addGestureRecognizer(pinchGesture)
  }

  @objc
  private func startZooming(_ sender: UIPinchGestureRecognizer) {
    let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
    guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
    sender.view?.transform = scale
    sender.scale = 1
  }
}
