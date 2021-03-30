import PinLayout

private enum Const {

    static let animationSpeedCoeff: Float = 0.5
    static let contentHorizontalSpace: CGFloat = 20
    static let kActivityColor = Palette.getColor(.silverGrey)

    enum Action {
        static let buttonSideSize: CGFloat = 55
        static let rightMargin: CGFloat = 10

        static var editImage: UIImage { UIImage(named: "tableViewEditIcon")! }
        static let editImageButtonLeftSpace: CGFloat = 14
        static var deleteImage: UIImage { UIImage(named: "tableViewDeleteIcon")! }
        static let deleteImageButtonLeftSpace: CGFloat = 10
    }

    enum CornerView {
        static let cornerRadius: CGFloat = 10
        static let verticalSpace: CGFloat = 4
        static let horizontalSpace: CGFloat = 12

        enum Shadow {
            static let opacity: CGFloat = 0.1
            static let offset: CGSize = CGSize(width: 0.0, height: 3.5)
            static let radius: CGFloat = 8.0
        }
    }

    enum OtherTranslations {
        static let verticalSpace: CGFloat = 20
    }
}

final class WordContainerCell: UICollectionViewCell, CellRegistrable {

    enum State {
        case normal
        case expanded
        case deleted
    }

    static func heightForItem(
        state: WordContainerCell.State,
        viewModel: WordContainerCellViewModelProtocol,
        width: CGFloat
    ) -> CGFloat {
        switch state {
        case .deleted:
            return 0

        case .normal:
            return NormalWordCardsContentView.heightForItem(
                viewModel: viewModel,
                width: width - Const.CornerView.horizontalSpace * 2
            )

        case .expanded:
            return ExpandedWordCardsContentView.heightForItem(
                viewModel: viewModel,
                width: width - Const.CornerView.horizontalSpace * 2
            )
        }
    }

    private var state: WordContainerCell.State!

    var onSelect: VoidHandler?
    var onShowDelete: VoidHandler?
    var onEdit: VoidHandler? { didSet { editImageButton.onTap = onEdit } }
    var onDelete: VoidHandler? { didSet { deleteImageButton.onTap = onDelete } }

    private var viewModel: WordContainerCellViewModelProtocol?

    private let scrollView: UIScrollView = UIScrollView()
    private var cornerView: UIView = UIView()

    private var normalView = NormalWordCardsContentView()
    private var expandedView = ExpandedWordCardsContentView()

    // Action buttons
    private let editImageButton = AnimatableUIButton()
    private let deleteImageButton = AnimatableUIButton()
    private let rightMarginView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(scrollView)
        scrollView.addSubview(editImageButton)
        scrollView.addSubview(deleteImageButton)
        scrollView.addSubview(rightMarginView)

        scrollView.addSubview(cornerView)

        cornerView.addSubview(normalView)
        cornerView.addSubview(expandedView)

        adjustSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Layouts
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.pin.all()

        layer.speed = Const.animationSpeedCoeff

        cornerView.layer.borderColor = Palette.getColor(.whiteSmoke2).cgColor
        cornerView.layer.borderWidth = config.isDarkModeEnabled ? 0 : 1
        cornerView.layer.cornerRadius = Const.CornerView.cornerRadius
        cornerView.layer.masksToBounds = true

        cornerView.pin
            .vertically(Const.CornerView.verticalSpace)
            .horizontally(Const.CornerView.horizontalSpace)

        editImageButton.pin
            .after(of: cornerView, aligned: .center)
            .marginLeft(editImageButton.isHidden ? 0 : Const.Action.editImageButtonLeftSpace)
            .size(editImageButton.isHidden ? 0 : Const.Action.buttonSideSize)
        deleteImageButton.pin
            .after(of: editImageButton, aligned: .center)
            .marginLeft(editImageButton.isHidden ? Const.Action.editImageButtonLeftSpace : Const.Action.deleteImageButtonLeftSpace)
            .size(Const.Action.buttonSideSize)
        rightMarginView.pin.after(of: deleteImageButton)
            .top()
            .right()
            .width(Const.Action.rightMargin)
            .height(frame.height)

        normalView.pin.all()
        expandedView.pin.all()

        switch state {
        case .normal:
            normalView.layoutSubviews()
        case .expanded:
            expandedView.layoutSubviews()
        case .deleted, .none:
            break
        }

        scrollView.contentSize = CGSize(width: rightMarginView.frame.maxX, height: frame.size.height)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        scrollView.isPagingEnabled = true
        scrollView.setContentOffset(.zero, animated: false)

        normalView.prepareForReuse()
        expandedView.prepareForReuse()

        editImageButton.alpha = 1
        deleteImageButton.alpha = 1
    }

    private func adjustSubviews() {
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false

        let onSelectCellTap = UITapGestureRecognizer(target: self, action: #selector(onSelectCell))
        cornerView.addGestureRecognizer(onSelectCellTap)

        editImageButton.setImage(Const.Action.editImage, for: .normal)
        editImageButton.adjustsImageWhenHighlighted = false

        deleteImageButton.setImage(Const.Action.deleteImage, for: .normal)
        deleteImageButton.adjustsImageWhenHighlighted = false
    }

    private func setStyles() {
        backgroundColor = Palette.getColor(.white)
        scrollView.backgroundColor = Palette.getColor(.clear)

        cornerView.backgroundColor = Palette.getColor(.white, adaptiveColor: DefaultPalette.whiteSmoke2.adaptiveDarkColor)
    }

    // MARK: Public funcs
    func present(viewModel: WordContainerCellViewModelProtocol, state: WordContainerCell.State) {
        self.viewModel = viewModel
        self.state = state

        editImageButton.isHidden = viewModel.type == .cardSet

        switch state {
        case .normal:
            normalView.present(viewModel: viewModel)
        case .expanded:
            expandedView.present(viewModel: viewModel)
        case .deleted:
            break
        }

        setStyles()
    }

    func display(state: WordContainerCell.State) {
        self.state = state

        switch state {
        case .normal:
            expandedView.alpha = 0
            normalView.alpha = 1

        case .expanded:
            expandedView.alpha = 1
            normalView.alpha = 0

        case .deleted:
            expandedView.alpha = 0
            normalView.alpha = 0
        }

        setStyles()
    }

    @objc private func onSelectCell() {
        onSelect?()
    }
}

// MARK: - UIScrollViewDelegate
extension WordContainerCell: UIScrollViewDelegate {

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 {
            onShowDelete?()
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollView.isPagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - scrollView.frame.size.width)
    }
}
