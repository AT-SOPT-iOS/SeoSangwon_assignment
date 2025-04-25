import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 62, y: 120, width: 300, height: 44))
        label.text = "TVING ID 로그인"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Pretendard-Bold", size: 23)
        label.textAlignment = .center
        return label
    }()

    // placeholder처럼 보이는 UILabel
    private let emailPlaceholderLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 60, y: 198, width: 200, height: 20))
        label.text = "아이디"
        label.textColor = UIColor.lightGray
        label.font = UIFont(name: "Pretendard-Regular", size: 16)
        return label
    }()

    private let emailTextField: UITextField = {
        let tf = UITextField(frame: CGRect(x: 47, y: 185, width: 335, height: 52))
        tf.text = ""
        tf.backgroundColor = UIColor(white: 0.4, alpha: 1)
        tf.layer.cornerRadius = 3
        tf.textColor = .white
        tf.setLeftPadding(16)
        tf.font = UIFont(name: "Pretendard-Regular", size: 16)
        return tf
    }()

    private let passwordPlaceholderLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 60, y: 288, width: 200, height: 20))
        label.text = "비밀번호"
        label.textColor = UIColor.lightGray
        label.font = UIFont(name: "Pretendard-Regular", size: 16)
        return label
    }()

    private let passwordTextField: UITextField = {
        let tf = UITextField(frame: CGRect(x: 47, y: 275, width: 335, height: 52))
        tf.text = ""
        tf.backgroundColor = UIColor(white: 0.4, alpha: 1)
        tf.layer.cornerRadius = 3
        tf.textColor = .white
        tf.setLeftPadding(16)
        tf.isSecureTextEntry = true
        tf.font = UIFont(name: "Pretendard-Regular", size: 16)
        return tf
    }()
    
    // 텍스트 지우는 X 버튼
    private lazy var clearButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "xmark")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addTarget(self, action: #selector(clearPasswordField), for: .touchUpInside)
        return button
    }()

    // 비밀번호 보기 토글 버튼
    private lazy var visibilityButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "eye_slash")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return button
    }()


    private let loginButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 47, y: 350, width: 335, height: 52))
        btn.setTitle("로그인하기", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 18)
        btn.backgroundColor = .black //초기 비활성화 색상
        btn.layer.cornerRadius = 3
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor(red: 46/255, green: 46/255, blue: 46/255, alpha: 1).cgColor
        btn.isEnabled = false // 비활성화 상태
        btn.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return btn
    }()

    private let findIDButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("아이디 찾기", for: .normal)
        btn.setTitleColor(.lightGray, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 14)
        return btn
    }()

    private let findPWButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("비밀번호 찾기", for: .normal)
        btn.setTitleColor(.lightGray, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 14)
        return btn
    }()

    private let dividerLabel: UILabel = {
        let label = UILabel()
        label.text = "|"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    private let askLabel: UILabel = {
        let label = UILabel()
        label.text = "아직 계정이 없으신가요?"
        label.textColor = .darkGray
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        return label
    }()

    private let signupButton: UIButton = {
        let btn = UIButton()
        let title = NSAttributedString(string: "닉네임 만들러가기", attributes: [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .font: UIFont(name: "Pretendard-Regular", size: 14)!,
            .foregroundColor: UIColor.white
        ])
        btn.setAttributedTitle(title, for: .normal)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPasswordRightView()
        view.backgroundColor = .black

        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(emailPlaceholderLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordPlaceholderLabel)
        view.addSubview(loginButton)
        view.addSubview(findIDButton)
        view.addSubview(findPWButton)
        view.addSubview(dividerLabel)
        view.addSubview(askLabel)
        view.addSubview(signupButton)

        emailTextField.delegate = self
        passwordTextField.delegate = self

        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
//        if let image = UIImage(named: "xmark") {
//            print("xmark 이미지 로드 성공")
//        } else {
//            print("xmark 이미지 못 찾음")
//        }
    }
    
    private func setupPasswordRightView() {
        //버튼 프레임 직접 설정
        clearButton.frame = CGRect(x: 0, y: 3, width: 24, height: 24)
        visibilityButton.frame = CGRect(x: 36, y: 3, width: 24, height: 24)

        //버튼들을 담을 컨테이너 뷰 생성
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 64, height: 30))

        //버튼을 컨테이너에 추가
        container.addSubview(clearButton)
        container.addSubview(visibilityButton)

        //텍스트필드에 연결
        passwordTextField.rightView = container
        passwordTextField.rightViewMode = .always
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // 로그인 버튼 바로 아래 줄
        findIDButton.frame = CGRect(x: 120, y: loginButton.frame.maxY + 20, width: 80, height: 20)
        dividerLabel.frame = CGRect(x: findIDButton.frame.maxX + 10, y: loginButton.frame.maxY + 20, width: 10, height: 20)
        findPWButton.frame = CGRect(x: dividerLabel.frame.maxX + 10, y: loginButton.frame.maxY + 20, width: 100, height: 20)

        // 두 번째 줄
        askLabel.frame = CGRect(x: 60, y: findIDButton.frame.maxY + 25, width: 180, height: 20)
        signupButton.frame = CGRect(x: askLabel.frame.maxX + 5, y: askLabel.frame.minY, width: 150, height: 20)
    }

    @objc private func clearPasswordField() {
        passwordTextField.text = ""
        passwordPlaceholderLabel.isHidden = false
    }

    @objc private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye" : "eye_slash"
        let newImage = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        visibilityButton.setImage(UIImage(named: imageName), for: .normal)
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        if textField == emailTextField {
            emailPlaceholderLabel.isHidden = !(textField.text?.isEmpty ?? true)
        } else if textField == passwordTextField {
            passwordPlaceholderLabel.isHidden = !(textField.text?.isEmpty ?? true)
        }

        //버튼 활성화 여부 확인
        let emailText = emailTextField.text ?? ""
        let pwText = passwordTextField.text ?? ""

        if !emailText.isEmpty && !pwText.isEmpty {
            // 활성화 상태
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor(red: 255/255, green: 20/255, blue: 60/255, alpha: 1)
        } else {
            // 비활성화 상태
            loginButton.isEnabled = false
            loginButton.backgroundColor = .black
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailPlaceholderLabel.isHidden = true
        } else if textField == passwordTextField {
            passwordPlaceholderLabel.isHidden = true
        }
    }

    // 로그인 버튼 탭 시
    @objc private func loginButtonTapped() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        if email.isEmpty || password.isEmpty {
            print("입력값이 비어 있어요!")
        } else {
            let welcomeVC = WelcomeViewController()
            welcomeVC.email = email  // 이메일 전달!
            navigationController?.pushViewController(welcomeVC, animated: true)
        }
    }
}

// Padding extension
extension UITextField {
    func setLeftPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
