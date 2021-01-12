//
//  PagerView.swift
//  Mecha
//
//  Created by Mattia Valzelli on 17/04/2020.
//  Copyright © 2020 DuckMa srl. All rights reserved.
//

import DuckMaUI
import SwiftUI

struct PagerView: View {
  private var viewControllers: [UIViewController]
  @State private var currentPage = 0

  init<Page: View>(_ views: [Page]) {
    self.viewControllers = views.map(UIHostingController.init(rootView:))
    viewControllers.forEach { $0.view.backgroundColor = .clear }
  }

  init(_ urls: [URL]) {
    self.viewControllers = urls.map(FullImageViewController.withURL(_:))
  }

  var body: some View {
    VStack {
      PageViewController(controllers: viewControllers, currentPage: $currentPage)
      if viewControllers.count > 1 {
        PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
      }
    }
  }
}

struct PageViewController: UIViewControllerRepresentable {
  var controllers: [UIViewController]
  @Binding var currentPage: Int

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  func makeUIViewController(context: Context) -> UIPageViewController {
    let pageViewController = UIPageViewController(
      transitionStyle: .scroll,
      navigationOrientation: .horizontal
    )
    pageViewController.dataSource = context.coordinator
    pageViewController.delegate = context.coordinator

    return pageViewController
  }

  func updateUIViewController(_ pageViewController: UIPageViewController, context _: Context) {
    pageViewController.setViewControllers(
      [controllers[currentPage]], direction: .forward, animated: true
    )
  }

  class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var parent: PageViewController

    init(_ pageViewController: PageViewController) {
      self.parent = pageViewController
    }

    func pageViewController(
      _: UIPageViewController,
      viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
      guard let index = parent.controllers.firstIndex(of: viewController),
        parent.controllers.count > 1
      else {
        return nil
      }
      if index == 0 {
        return parent.controllers.last
      }
      return parent.controllers[index - 1]
    }

    func pageViewController(
      _: UIPageViewController,
      viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
      guard let index = parent.controllers.firstIndex(of: viewController),
        parent.controllers.count > 1
      else {
        return nil
      }
      if index + 1 == parent.controllers.count {
        return parent.controllers.first
      }
      return parent.controllers[index + 1]
    }

    func pageViewController(
      _ pageViewController: UIPageViewController, didFinishAnimating _: Bool,
      previousViewControllers _: [UIViewController], transitionCompleted completed: Bool
    ) {
      if completed,
        let visibleViewController = pageViewController.viewControllers?.first,
        let index = parent.controllers.firstIndex(of: visibleViewController)
      {
        parent.currentPage = index
      }
    }
  }
}

struct PageControl: UIViewRepresentable {
  var numberOfPages: Int
  @Binding var currentPage: Int

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  func makeUIView(context: Context) -> UIPageControl {
    let control = UIPageControl()
    control.numberOfPages = numberOfPages
    control.pageIndicatorTintColor = ColorTheme.current.gray.p50
    control.currentPageIndicatorTintColor = ColorTheme.current.gray.p100
    control.addTarget(
      context.coordinator,
      action: #selector(Coordinator.updateCurrentPage(sender:)),
      for: .valueChanged
    )

    return control
  }

  func updateUIView(_ uiView: UIPageControl, context _: Context) {
    uiView.currentPage = currentPage
  }

  class Coordinator: NSObject {
    var control: PageControl

    init(_ control: PageControl) {
      self.control = control
    }

    @objc
    func updateCurrentPage(sender: UIPageControl) {
      control.currentPage = sender.currentPage
    }
  }
}
