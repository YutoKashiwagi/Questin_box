# Ukarimi

<img width="1433" alt="スクリーンショット 2020-04-13 19 22 14" src="https://user-images.githubusercontent.com/58618766/79113556-2073b900-7dbc-11ea-8c74-ca0b1f9baaef.png">

## URL
https://www.ukarimi.com
## 概要
Ukarimiは大学受験用のQ＆Aサイトです。わかる、繋がるをテーマとして作成しました。一般的なQ＆Aサイトの機能に加えツイッターのようなつぶやき、フォロー機能も実装しており、ユーザー同士で繋がることが出来ます。ユーザー層を考慮し、レスポンシブ対応済みです
## 使用技術

- Ruby2.6.3
- Rails5.2.0
- RSpec
- slim
- jQuery
- Bootstrap4
- MySQL5.7
- Docker/docker-compose(開発環境)
- CircleCI(RSpec, rubocop自動化)
- AWS(VPC, RDS, EC2, S3, ALB, Route53, ACM)
## ER図

<img width="778" alt="スクリーンショット 2020-04-15 5 30 21" src="https://user-images.githubusercontent.com/58618766/79271305-8c4c4380-7eda-11ea-9ff1-2c69c37be02b.png">

## サービス構成図

![Untitled](https://user-images.githubusercontent.com/58618766/79271293-85bdcc00-7eda-11ea-88fc-bc44ee348d30.png)

## 当サービスについて
### 作成動機
エンジニアリングを勉強していて、以下のような条件を満たすサービスに強い魅力を感じました

- Qiitaさんやスタックオーバーフローさんなど、その業界にとってなくてはならない知識の貯蔵庫のようなもの
- ユーザーさん同士が盛り上げてくれて、サービス自体が自走すること

この二つの状態がうまく噛み合えば、自動的に価値が上がっていくサービスを作り出せるのではないかと思ったところが始まりです

上記のような知識ベースのサービスが成り立っているのはエンジニア界隈特有のオープンソース精神も大きいと思いますが、他の業界でもこのような知識の貯蔵庫を作る余地があるのではないか、という思いから大学受験界隈に受験生が無料で使える巨大なQ＆Aサイトを作り上げようと考えました

### なぜQ&Aサイトか
#### 結論
プログラミングの勉強中にQ＆Aサイトを利用していく中で、Q＆Aサイトには以下のような特性があると感じました
  - 質問者の悩みを解決すればするほどノウハウが貯まっていき、サービス自体の価値が向上する

この特性は上記の知識ベースのサービスと非常に相性が良さそうだと感じたのが大きな理由です。
#### 考察
Q＆Aサイトのユーザーである質問者と回答者はそれぞれ以下のような理由でサイトを利用すると思っています

- 質問者
  - 悩みを解決したい
- 回答者
  - 悩みを解決してあげたい。またはQ＆Aサイト内での地位を向上させ、自分の専門分野での影響力を高めたい(宣伝目的)

質問者、回答者それぞれのニーズを満たしていくのは難しいと思いますが、うまく満たせれば下記のサイクルを回すことができ、強いサービスになると考えました

<img width="1018" alt="スクリーンショット 2020-04-15 12 47 11" src="https://user-images.githubusercontent.com/58618766/79296745-42ce1980-7f17-11ea-8fca-a71077d3a06c.png">

### なぜ大学受験か

自分がある程度精通している分野かつ、大学受験にテーマを絞った無料のQ＆Aサイトが存在しないため

### Q&Aサイトとしての差別化要素
大学受験界隈のQ＆Aサイトといえば、yahoo!知恵袋さんを利用するのが一般的かと思います。
そこで当サービスを使っていただくための差別化要素として「繋がる」という部分にも重点をおいて作成しました

志望校や受験科目の異なる大学受験において同じ志を持った意識の高い仲間を見つけるのは中々難しいため、当サイトを通して繋がることができれば大きな差別化要素となり、ユーザー獲得に繋がると考えています

具体的には、つぶやき機能、ユーザーフォロー機能等が挙げられます。
今後はユーザーさん同士でコミュニティを作る機能も実装する予定です

### 理想像
質問に解答する側は学習塾サイドを想定していて、学習塾サイドが宣伝のために質問に解答するようになることを理想としています

「学習塾スタッフが暇なとき、塾の宣伝のために当サイトで回答してくれるようになる」

こんな形が出来たら理想かと思っています。質問する受験生は主に質問に答えてくれる相手のいない独学か宅浪の方がメインになると思うので、生徒がほしい小規模の学習塾サイドと噛み合うのではないかと思っています

## ポートフォリオとしての見所
- 機能数の多さ（機能一覧参照)
- ポリモーフィズムを使用したモデル構成
- サブクエリ等を使用し、パフォーマンス面を考慮している
- デプロイ後に実際に使ってもらい、頂いた意見を元に改良している
- ファットコントローラ対策
  - 条件分岐等の処理はできるだけモデル層に押し込み、「コントローラを太くしない」 && 「安全なメソッドを作成する」ということを意識しました
    - https://github.com/YutoKashiwagi/Ukarimi/blob/master/app/models/user.rb
    - https://github.com/YutoKashiwagi/Ukarimi/blob/master/app/models/question.rb
- テストをしっかりと書いている(330examples超)
  - 保守性を高めるためテストは場合分け、正常値、異常値を意識して多めに書いています
  - 機能の改修を何度も行っているためテストの重要性は身に染みており、機能の実装とテストはセットのつもりで開発しました
## 機能一覧
### 認証周り
- ログイン、サインアップ機能(devise)
  - email、パスワード、ユーザー名必須(ログイン時はemailとパスワードのみ)
  - ゲストログイン機能(ゲストユーザーは退会、プロフィール変更不可)
### 質問機能
- CRUD機能
- いいね機能(polymorphic)
- コメント機能(polymorphic)
- カテゴリー付け機能(polymorphic)
- 同カテゴリーの質問を「関連する質問」として表示(サブクエリを使用)
### 回答機能
- CRUD機能
- いいね機能(polymorphic)
- コメント機能(polymorphic)
### ベストアンサー機能
いいね機能とは別に、質問が解決出来たかどうかの目安として作成しました。一度決めたら変更できない仕様にしています
### 投稿機能
- CRUD機能
- いいね機能(polymorphic)
- コメント機能(polymorphic)
- カテゴリー付け機能(polymorphic)

Q&Aだけでなく、ユーザー同士で繋がることができるようにツイッターのような投稿機能を作成しました。大学受験に関する勉強の進捗や問題に関する部分などをしっかり呟けるように、上限を1000文字に設定しています。
### ユーザーフォロー機能
ユーザー同士の繋がり、またフォロワーが増えていくことが回答者側の影響力増加に繋がると思い作成
### カテゴリー機能
- 質問、投稿、ユーザーにポリモーフィックで紐づけ
- ユーザーに対してはカテゴリーをフォローという形で紐づけ
- 現状は科目名のみですが、今後は科目の分野毎などさらに細かく作り込んでいこうと思っています
### コメント機能
- 質問、回答、投稿にポリモーフィックで紐づけ

情報の少ない質問に対するレスポンスが回答だけでは不便なので作成しました。
また回答に対してもお礼を言ったり、さらに質問したりできたら便利だと思い、回答に対してもポリモーフィックで実装しました。ついでにつぶやきにも取り付けました。
### いいね機能
- 質問、回答、投稿に対してポリモーフィックで紐付け

質問者と似たような悩みを抱えて質問にたどり着いた人が、その質問や回答が役に立ったということを示せるように、ベストアンサーとは別の評価方法として実装しました。ついでにつぶやき機能にも取り付けました

### フィード機能
- フォロー中のユーザー、カテゴリーの質問、つぶやきが表示されます。サブクエリを使用し、クエリ数が少なく済むように工夫しました
### 検索機能(ransack)
- カテゴリー別、解決済み、未解決、フリーワードで質問を検索可能
### ストック機能
- 質問をストック可能
- ストックした質問はストック一覧ページで確認可能

Qiitaを使用していて、ストック機能がとても便利だったのでこのアプリにも組み込みました。
### 通知機能
- 通知されるアクション
  - 質問に回答が来た時
  - 回答がベストアンサーに決定された時
  - 質問、投稿、回答にコメントがついた時(コメント対象のユーザー、コメントしたユーザー全員に通知)
  - フォローされた時
  - 質問がストックされた時

どのアクションを通知すべきかだいぶ悩みました。今後も必要に応じて変えていきたいです。また、ユーザー側で特定の通知をオフにできる機能も実装する予定です。

### ランキング機能
- 回答数、質問数で評価

回答者の影響力増加のために作成。今後はいいね数、ベストアンサー数なども評価の指標に加えられるようにポイント制の導入も検討。

## 苦労した点
### 設計
モデルを設計した後、機能の追加や改善を行っていくうちに過去の自分の設計やわかりづらいネーミングに頭を抱えることが多かったです。

逆に機能の設計さえきちんと行えていれば、機能の実装、追加や保守改修もある程度スムーズに行えると感じました。今後はDB設計もしっかり学び、パフォーマンスや安全性を考慮した設計を行います

### UI/UX
EC2にデプロイし、一旦完成として周りの方に実際に使用してもらい意見を求めたところ、UI/UXについて辛辣な意見をいただくことが多かったです

- 基本的なデザインについての知識が足りていなかったこと
- ユーザー側の目線に立てていなかったこと

が原因として挙げられます。今後はwebデザインの基礎的なことも勉強しておくべきだと感じました。また、「自分でもサービスをしっかり使う」「他者に使ってもらう」という事は今後も自分のサービスを作っていく上で絶対に必要だと感じました

頂いた意見はissueを立てて随時反映しています

## 参考(競合分析)にさせていただいたサービス

- yahoo!知恵袋様
  - https://chiebukuro.yahoo.co.jp
- teratail様
  - https://teratail.com
- スタックーバーフロー様
  - https://ja.stackoverflow.com
- Qiita様
  - https://qiita.com
- DMM英会話 英語でなんてuKnow?様
  - https://eikaiwa.dmm.com/uknow

## 今後
### 実装予定の機能
issuesをご覧ください

https://github.com/YutoKashiwagi/Ukarimi/issues
### フィードバック
実際に使ってもらって、頂いた意見をこちらにまとめています。随時対応しています

- 一度目のフィードバック
  - https://github.com/YutoKashiwagi/Ukarimi/issues/113#issue-593400578
- 二度目のフィードバック
  - https://github.com/YutoKashiwagi/Ukarimi/issues/132#issue-598469874
- 三度目のフィードバック
  - https://github.com/YutoKashiwagi/Ukarimi/issues/140#issue-600053517
