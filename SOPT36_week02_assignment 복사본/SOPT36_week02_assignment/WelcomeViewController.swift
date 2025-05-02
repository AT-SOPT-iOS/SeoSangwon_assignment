import UIKit

class WelcomeViewController: UIViewController {
    
    var email: String = ""
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tvingimage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Pretendard-Bold", size: 20)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let mainButton: UIButton = {
        let button = UIButton()
        button.setTitle("메인으로", for: .normal)
        button.backgroundColor = UIColor(red: 255/255, green: 20/255, blue: 60/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 18)
        button.addTarget(self, action: #selector(backToRoot), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        welcomeLabel.text = "\(email) 님\n반가워요!"
        
        view.addSubview(imageView)
        view.addSubview(welcomeLabel)
        view.addSubview(mainButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageView.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 200)
        welcomeLabel.frame = CGRect(x: 50, y: 350, width: view.frame.width - 100, height: 60)
        mainButton.frame = CGRect(x: 20, y: 800, width: 400, height: 52)
        //        print(view.frame.height)
        //        print(view.frame.width)
    }
    
    @objc private func backToRoot() {
        let mainVC = MainViewController()
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true, completion: nil)
    }
}
