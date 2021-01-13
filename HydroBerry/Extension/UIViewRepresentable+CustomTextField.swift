
import Combine
import SwiftUI

struct CustomTextField: UIViewRepresentable {
  let verticalHugging: UILayoutPriority
  let horizontalHugging: UILayoutPriority
  @Binding var text: String
  let builder: () -> UITextField

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  func makeUIView(context: Context) -> UITextField {
    let field = builder()
    field.delegate = context.coordinator as UITextFieldDelegate
    return field
  }

  func updateUIView(_ uiView: UITextField, context _: Context) {
    uiView.text = text
    uiView.setContentHuggingPriority(horizontalHugging, for: .horizontal)
    uiView.setContentHuggingPriority(verticalHugging, for: .vertical)
  }

  class Coordinator: NSObject, UITextFieldDelegate {
    private let parent: CustomTextField

    init(_ textField: CustomTextField) {
      self.parent = textField
      super.init()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
      parent.text = textField.text ?? ""
    }

    func textFieldDidEndEditing(
      _ textField: UITextField,
      reason _: UITextField.DidEndEditingReason
    ) {
      parent.text = textField.text ?? ""
    }
  }
}
