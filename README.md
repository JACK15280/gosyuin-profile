# Gosyuin-Profile
御朱印の投稿、編集、管理が出来るアプリケーション。
友人や家族等、他ユーザーと共有も楽しめる。


## 本番環境
[Gosyuin-Profile](https://gosyuin-profile.herokuapp.com)
- テストアカウント  
ユーザー名 :テスト  
メールアドレス: t@t  
パスワード: 111111


## 制作意図
エンジニアという職業の根幹は、プログラミングなどのツールを使用して、想いを形にすることである。  
職業に就く上で行う業務としては、人の想いを形にすることである。  
人の想いを形にするためには、まず自分の想いを形にできるようにしたいと考え、趣味である御朱印のアプリを作りたいと思った。


## 工夫した点
御朱印ブームもあった中、もちろん自分もアプリを使用して御朱印管理をしていた。  
**だが、どのアプリにも自分が欲しいと思っている機能が無かった。**  
当時、祖父母や友人と御朱印を集めに行くことが多かった自分は、その道中の思い出も残したいと考えており、日記としても扱える機能が必要だった。  
技術を学んだことで、あの時必要だったアプリを自ら制作することを実現できた。
- 新規投稿ページにテキスト欄を設けることで、自由に記録を残せるよう実装した。(日記機能)
- GoogleMapのAPIを取得し、場所の特定や、道中を思い出すヒントを増やせるよう、マップ機能を実装した。
- 文字列での投稿検索機能を実装した。
- 現在の投稿や、投稿の編集の際 どの画像を投稿したか可視化するため、JavaScriptで画像表示を実装した。
- 視覚的に変化が分かりやすいよう、フラッシュメッセージを実装した。
- コメントの際、ユーザーに対してのストレス緩和の為、JavaScriptでコメント表示を実装した。
- 投稿のまとめの為、ユーザーの投稿一覧と、投稿のグループ化機能を実装した。


## 使用技術(開発環境)
- HTML, CSS, Ruby, Ruby on Rails, JavaScript, Haml, Sass


## 課題や今後実装したい機能
- 投稿のお気に入り機能
- レスポンシブデザイン


## DB設計

### postsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer||
|title|string||
|content|text||
|image|string||

#### Association
- belongs_to :user
- has_many :comments
- has_many :group_posts, dependent: :destroy
- has_many :groups, through: :group_posts, dependent: :destroy
- validates :image, :title, presence: true


### usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false|
|encrypted_password|string|null: false|

#### Association
- has_many :posts, dependent: :destroy
- has_many :groups
- has_many :comments
- validates :name, presence: true, uniqueness: true


### groupsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|user_id|integer||

#### Association
- has_many :group_posts, dependent: :destroy
- has_many :posts, through: :group_posts, dependent: :destroy
- belongs_to :user
- validates :name, presence: true, uniqueness: true


### commentsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer||
|post_id|integer||
|text|text||

#### Association
- belongs_to :post
- belongs_to :user
- validates :text, presence: true


### group_postsテーブル
|Column|Type|Options|
|------|----|-------|
|group_id|references|foreign_key: true|
|post_id|references|foreign_key: true|

#### Association
- belongs_to :group
- belongs_to :post