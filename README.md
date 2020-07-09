# zsksample_rails01

チーム開発体験用プロジェクト

# 前提事項

- Macでの開発を前提としています。
- Bashがデフォルトのシェルであることを前提としています。(zshを使用している方は適宜読み替えてください)

# 手順

- まずはこちらのリポジトリをチームの代表者の方のリポジトリにforkしてください。
- そのリポジトリにチームメンバーの方たちを招待してください。
- (後で追記していく)
  - developブランチをデフォルトブランチに設定してください。
  - masterブランチはherokuへのデプロイ用に使用します。
  - master、develop、その他のブランチそれぞれにブランチ保護の設定をおこなってください。

# 環境構築手順

## rbenvとRubyのインストール

- 下記のページの情報等を参考にして、rbenvとRubyのインストールを行ってください。
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

# アプリケーションの実行

```
docker-compose up -d
bundle exec rake db:setup
rails s

# ブラウザで下記のURLにアクセス
http://localhost:3000/users
```

# アプリケーションのテスト

```
docker-compose up -d
bundle exec rake db:setup
bundle exec rake test
```
