# zsksample_rails01

チーム開発体験用プロジェクト

# 前提事項

- Macでの開発を前提としています。
- Bashがデフォルトのシェルであることを前提としています。(zshを使用している方は適宜読み替えてください)

# GitHubとZenHubの設定

- まずは[こちら](https://github.com/kenta-polyglot/zsksample_rails01/wiki/GitHub%E3%81%A8ZenHub%E3%81%AE%E8%A8%AD%E5%AE%9A)のwikiに記載されている手順に従って、GitHub/ZenHub/Herokuの設定、およびチームメンバーの方たちのGitHubへの招待等を完了させておいてください。

# 環境構築手順

- GitHubやZenHubの設定が完了したら、forkしたリポジトリをローカルにcloneして、下記の手順で開発環境を構築してください。
  - fork元のリポジトリではなく、必ずfork先のリポジトリからcloneするようにしてください。

- チーム代表者の方は、下記の手順を実行して`config/credentials.yml.enc`および`config/master.key`を再作成して、`config/master.key`をチームの他のメンバーの方たちに共有してください。(この作業も作業ブランチを作成しておこなってください。また、`master.key`は一応SlackのDMを使用してお渡しする方が望ましいと思います)
  - チームの他のメンバーの方たちは、代表者の方たちから共有された`master.key`を、リポジトリの`config/master.key`にコピーしておいてください。
  - `config/master.key`はバージョン管理に含まれていないためリポジトリをforkしてきた段階では作成されていないのでご注意ください。
```
# 既存のconfig/credentials.yml.encを削除
rm -f config/credentials.yml.enc

# 下記のコマンドを実行して特に編集は行わずに:wqで保存する
EDITOR=vim rails credentials:edit

# config/credentials.yml.encとconfig/master.keyが再作成される
```

## rbenvとRubyのインストール

- 下記のページの情報等を参考にして、必要に応じてrbenvとRubyのインストールを行ってください。
- インストールするRubyのバージョンは、.ruby-versionに記載されているバージョンに合わせてください。

  [【完全版】MacでRails環境構築する手順の全て](https://qiita.com/kodai_0122/items/56168eaec28eb7b1b93b)

## gemのインストール

```
# bundle install時のパスを固定
bundle config set path 'vendor/bundle'

# gemをインストール
bundle install
```

## shellcheckのインストール

- shellcheckはbashスクリプトのvalidationを行うツール。

```
# インストール
brew install shellcheck

# shellcheckを使用してBashスクリプトをvalidate
script/shellcheck
```

## hadolintのインストール

- hadolintはDockefile用のlinter。

```
# インストール
brew install hadolint

# hadolintを使用してDockerfile*をlint
script/dockerlint
```

## アプリケーションの実行

```
docker-compose up -d
bundle exec rake db:setup
rails s

# ブラウザで下記のURLにアクセス
http://localhost:3000/users
```

## アプリケーションのテスト

```
docker-compose up -d
bundle exec rake db:setup
bundle exec rspec
```

# チーム開発手順

- 作業内容はRails TutorialのToyアプリケーションの作成とほぼ同様です。

## Epicの追加

- ZenHubのBoardの「Epic」パイプラインに、下記のエピックを追加してください。(こちらは「プロダクトバックログ」のようなものと考えてください)
  - Userのテストを完成させる
  - Micropostを追加する
  - 便利機能を追加する
    - EpicはIssueと同じ画面で作成できます。保存する際に「Create an Epic」ボタンをクリックするとEpicとして保存されます。(Issueを後からEpicに変換することも可能です)

## ToDoの追加

- 作成したEpicの子Issue(Issueを作成する際に「Epics」の欄で、適切なEpicと関連付けてください)として、下記のようなIssueを追加してToDoパイプラインに表示されるようにしてください。(こちらは「スプリントバックログ」のようなものと考えてください)
  - Userのテストを完成させる
    - Userモデルのテストを完成させる
    - Userリクエストのテストを完成させる
  - Micropostを追加する
    - Micropost用のModel/View/Controller/Rspecファイル等を追加する
      - Modelのフィールドは「content」(text型)と「user_id」(integer型)
    - Micropostモデルのテストを完成させる
    - Micropostリクエストのテストを完成させる
    - Micropostの最大文字数を140文字に制限する
    - UserとMicropostを1対多の関係にする
  - 便利機能を追加する
    - User一覧画面にページネーション機能を追加する
    - Micropost一覧画面にページネーション機能を追加する
    - MicropostにActiveStorageを使用した画像アップロード機能を追加する

## タスクのアサインと見積り

- どのIssueをどのメンバーが担当するか、相談して決めてください。
  - 一つのEpicが完了するごとにHerokuへのデプロイを実行する予定なので、基本的には「Userのテストを完成させる」→「Micropostを追加する」→「便利機能を追加する」の順でIssueが消化されるようにしてください。(もし参加者が多くてIssueが足りない場合は、短時間で終わりそうな適当なIssueを追加してください)
- 作業担当者が決まったら、各担当者は自分が直近で担当するIssueに対して下記の設定をおこなってください。
  - Assigneesに自分を割り当てる
  - Labelsで適切なラベルを選択する。(どのラベルを選択するかは関してはチーム内で相談してください)
  - Milestoneで適切なマイルストーンを選択する。
    - スプリント期間は1週間です。
  - Estimateに見積もり工数を入力する。
    - 「0.1 = 1時間」「1 = 1日」として換算してください。

## タスクの対応とコードレビュー

- Issueへの対応が完了したら、作業ブランチをpushして、developブランチに対してプルリクを発行してください。
  - この際、「フォーク元」のリポジトリに対してプルリクを発行しないようにご注意ください。
  - また、コミットメッセージに関しては[こちら](https://qiita.com/numanomanu/items/45dd285b286a1f7280ed)のルールを適用してください。(本文に日本語を使うか英語を使うかはチーム内で相談して決めてください)
  - 作業ブランチを作成する際も、ブランチのプレフィックスは上記のドキュメントのルールに従っておいてください。(`feat/xx`や`chore/xx`等)
  - プルリクのテンプレートは事前に決められています。下記を参考にして簡潔に情報を記述してください。
    - close：このプルリクと対応しているIssueのURLを入力してください。
    - 概要：このプルリクでおこなった改修の概要を入力してください。
    - 修正内容の検証方法：このプルリクでおこなった改修の検証手順(ローカル環境でのテストの実行方法等)を記述してください。
    - この修正が正しい理由：この改修が正しい理由(テストコマンドが正常に完了したことを確認した等)を記述してください。
  - プルリクを発行したら、Reviewersの欄に他のメンバーを全員設定し、Assigneesに自分自身を設定してください。
  - また、プルリク画面下部の「Connect this pull request with an existing issue」で、このプルリクの対象となるIssueを選択しておいてください。
- 他のチームメンバーは[こちら](https://bake0937.hatenablog.com/entry/2019/10/24/145241)や[こちら](https://qiita.com/YumaInaura/items/8223add6d8335a2eda7f)を参考にして、適切なレビューをおこなってください。(単にApproveするだけの場合は、コメントは「LGTMです」だけで問題ありません)
  - 「Start a review」ボタンでレビューを開始するとどういう挙動になるのか、「Comment、Approve、Request Changes」のどれを使うのが適切なのかは、是非お互いに色々といじって実験してみてください。
- GitHub ActionsのCheckワークフロー(`.github/workflows/check.yml`で定義されています)が完了し、1人以上のレビュアーからApproveされたらプルリクのマージが可能になります。マージは基本的にプルリクの発行者がおこなってください。
  - Checkワークフローの実行ログは、「Actions」タブ、もしくはプルリク画面の下部の対象のワークフローの「Details」リンクから参照できます。

## Herokuへのデプロイとタグの設定

- 一つのEpicが完了したら、developブランチからmasterブランチに対してプルリクを作成してください。
  - プルリクのタイトルは「Merge develop to master」等にしておいてください。
  - 一応Reviewersにチームメンバー全員を設定して、Assigneesに自分自身を設定しておいてください。
- GitHub ActionsのCheckワークフローが完了したら、ReviewersのどなたかがApproveしてください。
- このプルリクをマージすると、GitHub ActionsのDeployワークフロー(`.github/workflows/deploy.yml`で定義されています)が実行され、[こちら](https://github.com/kenta-polyglot/zsksample_rails01/wiki/GitHub%E3%81%A8ZenHub%E3%81%AE%E8%A8%AD%E5%AE%9A)のwikiの作業で事前に設定されているGitHub Secretsの情報を使用して、Herokuへのデプロイが実行されます。
- デプロイ完了後は、https://アプリケーション名.herokuapp.com/users でアプリケーションが参照できるようになります。
- デプロイが成功したら、[こちら](https://docs.github.com/ja/enterprise/2.15/user/articles/creating-releases)のドキュメントを参考にして、masterブランチの最新コミットに対してリリースとタグを設定しておきましょう。(最初のバージョンのリリース名とタグ名は「v0.0.1」でよいでしょう。以降「v0.0.2」や「v0.0.3」のように、新しいコミットをdevelopブランチからマージしてデプロイした際は新しいタグを追加していってください)
