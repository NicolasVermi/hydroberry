//
//  prova3View.swift
//  HydroBerry
//
//  Created by Nicolas Vermi on 18/01/21.
//


import SwiftUI
import SafariServices

struct prova3View: View {
    var body: some View {
        SafariButton()
    }
}

struct SafariButton: View {

    struct RootView: View, Hostable {
        
        @EnvironmentObject private var hostedObject: HostingObject<Self>

        var address = "https://www.sportmediaset.mediaset.it/"

        func present() { // UIKit code
            let safari = SFSafariViewController(url: URL(string: address)!)
            hostedObject.viewController?.present(safari, animated: true)
        }

        var body: some View {
            Button(address, action: present)
        }
    }

    var body: some View {
        RootView().hosting()
    }
}

///=======

struct UIViewControllerView: UIViewControllerRepresentable {
    final class ViewController: UIViewController {
        var didAppear: (UIViewController) -> Void = { _ in }
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            didAppear(self)
        }
    }

    var didAppear: (UIViewController) -> Void

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = ViewController()
        viewController.didAppear = didAppear
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        Text("")
    }
}

struct UIViewControllerViewModifier: ViewModifier {
    var didAppear: (UIViewController) -> Void
    var viewControllerView: some View {
        UIViewControllerView(didAppear:didAppear).frame(width:0,height:0)
    }
    func body(content: Content) -> some View {
        content.background(viewControllerView)
    }
}

extension View {
    func uiViewController(didAppear: @escaping (UIViewController) -> ()) -> some View {
        modifier(UIViewControllerViewModifier(didAppear:didAppear))
    }
}

class HostingObject<Content: View>: ObservableObject {
    @Published var viewController: UIViewController? = nil
}

struct HostingObjectView<Content: View>: View {
    var rootView: Content
    let hostedObject = HostingObject<Content>()
    func getHost(viewController: UIViewController) {
        hostedObject.viewController = viewController.parent
    }
    var body: some View {
        rootView
            .uiViewController(didAppear: getHost(viewController:))
            .environmentObject(hostedObject)
    }
}

protocol Hostable: View {
    associatedtype Content: View
    func hosting() -> Content
}

extension Hostable {
    func hosting() -> some View {
        HostingObjectView(rootView: self)
    }
}


struct prova3View_Previews: PreviewProvider {
    static var previews: some View {
        prova3View()
    }
}
