# Factory-app
https://www.factory-app.com
[![画像をクリックするとYoutubeに飛びます](https://img.youtube.com/vi/FGENKszDdQs/0.jpg)](https://www.youtube.com/watch?v=FGENKszDdQs)
## 概要
金属製品の加工をお願いしたい企業とその加工が可能な企業を繋ぐサービスです。
## 制作背景
前職で産業用機械の営業をしていたときに過去に納めたレーザー加工機に重大なトラブルが発生し、お客様の生産を完全にストップさせてしまったことがありました。

その生産の埋め合わせをするために代わりに加工をしてくれる業者を探しましたが
1件の取引先しか依頼のあてがなく、お客様の生産はさらに遅れてしまいました。

結果的にお客様は1ヶ月以上必要数の納品ができなくなる事態となり、
大変なご迷惑をおかけしてしまいました。

それ以来この問題をデジタルで解決するとしたらどんなサービスがあったら良いかを考えるようになり、
Factory-appはこれを具現化するために制作しました。
将来は製造業や行政など成熟した業界にデジタルの影響を与えられるようなエンジニアになりたいと考えております。
## 使用技術
- フロントエンド
  - HTML/CSS
  - JQuery
  - TailwindCSS
- バックエンド
  - Ruby(3.0.2)
  - Ruby on Rails(6.1.3)
  - MySQL(5.6)
  - Rubocop
  - RSpec(テスト)
- インフラ・開発環境
  - Docker/Docker-Compose
  - AWS（ECR,ECS(EC2起動タイプ),VPC,S3,Route53,ALB,RDS,ACM）
  - CircleCI（自動テストのみ）
## 工夫した点
### 非同期通信を用いて画面遷移の回数を削減
- 投稿した依頼の編集・保存
- プロフィールの編集・保存
- トップページの依頼を探す・ユーザーを探す機能の切り替え
- トップページの投稿・ユーザー検索の結果表示
- フォロー、コメント、お気に入り、リクエスト送信それぞれの保存・削除

→ これらの機能に非同期通信を採用し、ユーザーストレスの軽減を目指しました。

### 非同期通信を用いて一度に作られるSQL文の発行回数を削減
- ユーザー詳細画面への遷移時にフォロー・フォロワーの情報は取得せず、タブが押された時のみ必要なSQL文を発行
- ユーザー詳細画面にて投稿済み、お気に入り、発注済み、受注済みそれぞれ情報を4つのタブにし、それぞれのタブがクリックされたときに必要なSQL文を発行

→ これらの対策で大量のSQL文発行を防止し、アプリの動作遅延を防ぎました。

## 苦労した点
### N+1問題への対処
トップページには「あなたへのおすすめ」「あなたの地域の投稿」「その他の投稿一覧表示」の3段階で表示されて、この表示では多くの条件分岐が存在します。 
- その投稿はログインユーザー自身の投稿ではないか？
- その投稿は募集終了している投稿ではないか？
- その投稿は「あなたへのおすすめ」で表示されたか？
- その投稿は「あなたと同じ地域の投稿」で表示されたか？
- その投稿はログインユーザーによってお気に入りされているか？

これらの条件をくぐり抜けながら上述の3段階の表示がされますが、if文の書き方によってはN+1問題の起因になります。
さらに投稿主の情報表示も必要になるため非常に多くのN＋1問題の起因が潜んでおり、これらを回避するための対策に苦労しました。

この問題の対策として、SQL文の発行の仕方や条件分岐をRailsのメソッドに置き換えを行いました。
- includesメソッドを用いた関連する情報の追加取得
- pluckメソッドを用いた特定のカラムのみのデータを取得
- pluckメソッドとinclude?メソッドを用いた判定
- selectやrejectを用いた条件分岐の削減

これらのメソッドを活用し、N＋1問題を回避することができました。

## インフラ構成図
![infrastructure](https://user-images.githubusercontent.com/87586109/140628191-9540a03a-67f3-4472-bd12-fa15bdf0714b.png)
## ER図
![factory_er](https://user-images.githubusercontent.com/87586109/140602645-d39f045d-f4f6-415e-86ce-c692a2e8ceb5.png)
## 機能一覧
- ユーザー関連
  - ユーザー登録
  - ログイン機能(ゲストログイン機能あり)
  - プロフィール登録・編集
  - フォロー
- 投稿関連
  - 依頼投稿・編集・削除
  - お気に入り
  - コメント
  - 加工のリクエスト送信
  - 依頼の募集終了登録(契約済みの依頼として保存される)
  - 依頼検索
  - おすすめ依頼表示(ログインユーザーのプロフィール情報からマッチ度の高い依頼をおすすめとして表示する)
  - ユーザー検索
  - おすすめユーザー表示(ログインユーザーの投稿からマッチ度の高い他ユーザーをおすすめとして表示する)
  - お気に入り数ランキング
  - 募集終了した依頼の一覧表示
- その他
  - 非同期通信
  - レスポンシブデザイン
