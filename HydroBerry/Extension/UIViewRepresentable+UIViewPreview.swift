//
//  UIViewRepresentable+UIViewPreview.swift
//  Mecha
//
//  Created by Mattia Valzelli on 06/04/2020.
//  Copyright © 2020 DuckMa srl. All rights reserved.
//

import SwiftUI

struct UIViewPreview<View: UIView>: UIViewRepresentable {
  let view: View
  let verticalHugging: UILayoutPriority
  let horizontalHugging: UILayoutPriority

  init(
    verticalHugging: UILayoutPriority = .defaultHigh,
    horizontalHugging: UILayoutPriority = .defaultHigh,
    _ builder: @escaping () -> View
  ) {
    self.verticalHugging = verticalHugging
    self.horizontalHugging = horizontalHugging
    self.view = builder()
  }

  // MARK: - UIViewRepresentable

  func makeUIView(context _: Context) -> UIView {
    view
  }

  func updateUIView(_ view: UIView, context _: Context) {
    view.setContentHuggingPriority(horizontalHugging, for: .horizontal)
    view.setContentHuggingPriority(verticalHugging, for: .vertical)
  }
}
