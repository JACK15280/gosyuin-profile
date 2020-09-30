# Gosyuin-Profile
御朱印の投稿、編集、管理が出来るアプリケーション。
友人や家族等、他ユーザーと共有も楽しめる。


## 本番環境
[Gosyuin-Profile](https://gosyuin-profile.herokuapp.com)
- テストアカウント  
※ログインページ下部の「ゲストログイン（閲覧用）」にアスセスしてください  
ユーザー名 :テスト  
メールアドレス: guest@example.com  
パスワード: ※自動生成されます
### 機能紹介
- ユーザー新規登録、編集、削除機能
- 投稿の新規作成、編集、削除機能 
※トップページ右上より新規投稿が可能です(https://gyazo.com/a9715bab4a8b0f4fccc3ed1b694a48d8)
- 投稿をグループ化させる機能(グループの新規作成、編集、削除機能)
- 投稿へのコメント機能
- コメント通知機能
- 投稿検索機能、投稿詳細検索機能
- 投稿の非公開、公開機能
- 投稿のお気に入り機能

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
- ユーザー同士のコミュニケーションがスムーズになるように、コメントの通知機能を実装した。



## 使用技術(開発環境)
- HTML/ CSS/ Ruby/ Ruby on Rails/ JavaScript/ jQuery/ Haml/ SCSS/ Git/ GitHub/ AWS/ MySQL


## 課題や今後実装したい機能
- デバイスに応じたレスポンシブデザイン


## DB設計

### postsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer||
|status|intefer|null: false|
|title|string|null: false|
|content|text||
|image|string|null: false|

#### Association
- belongs_to :user
- has_many :comments
- has_many :group_posts, dependent: :destroy
- has_many :groups, through: :group_posts, dependent: :destroy
- has_many :favorites, dependent: :destroy
- has_many :notifications, dependent: :destroy


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
- has_many :favorites, dependent: :destroy
- has_many :active_notifications, foreign_key:"visitor_id", class_name: "Notification", dependent: :destroy
- has_many :passive_notifications, foreign_key:"visited_id", class_name: "Notification", dependent: :destroy


### groupsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|user_id|integer||

#### Association
- has_many :group_posts, dependent: :destroy
- has_many :posts, through: :group_posts, dependent: :destroy
- belongs_to :user


### commentsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer||
|post_id|integer||
|text|text||

#### Association
- belongs_to :post
- belongs_to :user
- has_many :notifications, dependent: :destroy


### group_postsテーブル
|Column|Type|Options|
|------|----|-------|
|group_id|references|foreign_key: true|
|post_id|references|foreign_key: true|

#### Association
- belongs_to :group
- belongs_to :post


### favoritesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true|
|post_id|references|foreign_key: true|

#### Association
- belongs_to :user
- belongs_to :post


#### notificationsテーブル
|Column|Type|Options|
|------|----|-------|
|visitor_id|references|foreign_key:{ to_table: :users }, null: false|
|visited_id|references|foreign_key:{ to_table: :users }, null: false|
|post_id|references|foreign_key: true|
|comment_id|references|foreign_key: true|
|action|string|null: false|
|checked|boolean|default: false, null: false|

#### Association
- belongs_to :visitor, class_name: "User", optional: true
- belongs_to :visited, class_name: "User", optional: true
- belongs_to :post, optional: true
- belongs_to :comment, optional: true