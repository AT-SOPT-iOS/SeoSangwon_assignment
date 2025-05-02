import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    // MARK: - Header UI
    private let topHeaderView = UIView()
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "tvingLogo")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "searchIcon"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let profileButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "profileIcon"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    // MARK: - Menu Bar
    private let menuBarView = UIView()
    private let menuTitles = ["홈", "드라마", "예능", "영화", "스포츠", "뉴스"]
    private var menuButtons: [UIButton] = []
    private let menuUnderline = UIView()
    private let menuStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
    }()
    
    // MARK: - Scrollable Content
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "your name poster")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘의 티빙 TOP 20"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 160, height: 180)
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    private let posterImageNames = [
        "signal poster",
        "harry potter poster",
        "the lord of the rings poster"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupView()
        setupLayout()
        setupMenu()
    }
    
    private func setupView() {
        view.addSubview(topHeaderView)
        topHeaderView.addSubview(logoImageView)
        topHeaderView.addSubview(searchButton)
        topHeaderView.addSubview(profileButton)
        
        view.addSubview(menuBarView)
        menuBarView.addSubview(menuStackView)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(topLabel)
        contentView.addSubview(collectionView)
        
        menuBarView.addSubview(menuUnderline)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TopCell.self, forCellWithReuseIdentifier: "TopCell")
    }
    
    private func setupLayout() {
        topHeaderView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(180)
            $0.height.equalTo(78)
        }
        
        profileButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        searchButton.snp.makeConstraints {
            $0.trailing.equalTo(profileButton.snp.leading).offset(-16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        menuBarView.snp.makeConstraints {
            $0.top.equalTo(topHeaderView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        menuStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(menuBarView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(550)
        }
        
        topLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(topLabel.snp.bottom).offset(10)
            $0.height.equalTo(180)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-40)
        }
    }
    
    private func setupMenu() {
        for (index, title) in menuTitles.enumerated() {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 14)
            button.tag = index
            button.addTarget(self, action: #selector(menuTapped(_:)), for: .touchUpInside)
            menuStackView.addArrangedSubview(button)
            menuButtons.append(button)
        }
        
        // 밑줄 초기 설정
        if let firstButton = menuButtons.first, let titleLabel = firstButton.titleLabel {
            titleLabel.sizeToFit()
            menuUnderline.backgroundColor = .white
            menuUnderline.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(2)
                $0.height.equalTo(2)
                $0.width.equalTo(titleLabel.intrinsicContentSize.width)
                $0.centerX.equalTo(titleLabel)
            }
        }
    }
    
    @objc private func menuTapped(_ sender: UIButton) {
        guard let titleLabel = sender.titleLabel else { return }
        titleLabel.sizeToFit()
        
        UIView.animate(withDuration: 0.25) {
            self.menuUnderline.snp.remakeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(2)
                $0.height.equalTo(2)
                $0.width.equalTo(titleLabel.intrinsicContentSize.width)
                $0.centerX.equalTo(titleLabel)
            }
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - CollectionView
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posterImageNames.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCell", for: indexPath) as? TopCell else {
            return UICollectionViewCell()
        }
        let imageName = posterImageNames[indexPath.item]
        cell.configure(rank: indexPath.item + 1, imageName: imageName)
        return cell
    }
}

// MARK: - TopCell
class TopCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let rankLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = false
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        
        contentView.addSubview(imageView)
        contentView.addSubview(rankLabel)
        
        imageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalTo(120)
        }
        
        rankLabel.textColor = .white
        rankLabel.font = UIFont(name: "Pretendard-Bold", size: 32)
        rankLabel.textAlignment = .center
        
        rankLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.bottom.equalTo(imageView.snp.bottom).inset(4)
        }
    }
    
    func configure(rank: Int, imageName: String) {
        imageView.image = UIImage(named: imageName)
        rankLabel.text = "\(rank)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

