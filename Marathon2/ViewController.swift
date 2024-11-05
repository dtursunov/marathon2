import UIKit

extension ViewController {
    enum Constants {
        static let buttonImage: UIImage? = .init(systemName: "arrow.right.circle.fill")
    }
}

final class ViewController: UIViewController {
    
    private let firstButton = MyButton(
        title: "First Button",
        image: Constants.buttonImage
    )

    private let secondButton = MyButton(
        title: "Second Medium Button",
        image: Constants.buttonImage
    )
    
    private let thirdButton = MyButton(
        title: "Third",
        image: Constants.buttonImage
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        [firstButton, secondButton, thirdButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        let action = UIAction { [weak self] _ in
            let controller = UIViewController()
            controller.view.backgroundColor = .systemBackground
            self?.present(controller, animated: true)
        }
        
        thirdButton.addAction(action, for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 8),
            thirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thirdButton.topAnchor.constraint(equalTo: secondButton.bottomAnchor, constant: 8)
        ])
    }
}



extension MyButton {
    enum Constants {
        static let contentInset: NSDirectionalEdgeInsets = .init(top: 10, leading: 14, bottom: 10, trailing: 14)
        static let imagePadding: CGFloat = 8
        static let cornerRadius: CGFloat = 10
        static let animnationDuration: TimeInterval = 0.2
        static let scale: CGAffineTransform = .init(scaleX: 0.9, y: 0.9)
    }
}

class MyButton: UIButton {
    init(title: String, image: UIImage?) {
        super.init(frame: .zero)
        
        var config = UIButton.Configuration.filled()
        config.imagePlacement = .trailing
        config.cornerStyle = .medium
        config.contentInsets = Constants.contentInset
        config.imagePadding = Constants.imagePadding
        config.background.backgroundColorTransformer = .init { old in
            var new = old
            switch self.tintAdjustmentMode {
            case .dimmed: // когда презентован
                new = .systemGray2
            default:
                new = .systemBlue
            }
            return new
        }
        
        config.titleTextAttributesTransformer = .init { old in
            var new = old
            switch self.tintAdjustmentMode {
            case .dimmed: // когда презентован
                new.foregroundColor = .systemGray3
            default:
                new.foregroundColor = .white
            }
            return new
        }
        
        config.imageColorTransformer = .init { old in
            var new = old
            switch self.tintAdjustmentMode {
            case .dimmed: // когда презентован
                new = .systemGray3
            default:
                new = .white
            }
            return new
        }
        
        config.title = title
        config.image = image
        configuration = config

    }
        
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: Constants.animnationDuration) {
            self.transform = Constants.scale
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: Constants.animnationDuration) {
            self.transform = .identity
        }
    }
}
