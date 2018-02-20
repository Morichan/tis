# TIS

Tool Information Searcher

ツールの情報を探索してくれるBotです。
プラットフォームはDialogPlayを利用しています。
決して某企業さんと関係があるわけではありません。

また、このリポジトリは任意のサーバにおいてください。
サーバには[HUG](https://github.com/timothycrosley/hug)を利用しています。



# Feature

APIサーバです。

任意のツール名とオプションを元に、欲しいツールの情報をGitHubから取得します。

全体の機能

```plantuml:
@startuml
actor ユーザ as User
participant DialogPlay as DP
participant "Hug on AWS" as Hug
participant GitHub as Github

activate User
User -> DP : ツールの情報を教えて

loop もう情報がいらないと言うまで

    activate DP
    DP -> User : ツール名を教えてください
    User --> DP: ツール名
    DP -> User : 知りたい情報を教えてください
    User --> DP: 知りたい情報（オプション）

    DP -> Hug : クエリ

    activate Hug
    Hug -> Hug : スクリプト起動

    activate Hug
    Hug -> Github : Search API with ツール名

    activate Github
    Hug <-- Github : ツール情報

    deactivate Github
    Hug -> Hug : 受取ったツール情報を整形

    alt GitHubに再リクエストする必要があるオプションの場合
        Hug -> Github : Search API with ツール名

        activate Github
        Hug <-- Github : ツール情報

        deactivate Github

        Hug -> Hug : 受取ったツール情報を整形

    end

    Hug --> Hug : 情報（空情報の可能性あり）
    deactivate Hug
    DP <-- Hug : 情報（空情報の可能性あり）
    deactivate Hug

    alt 情報があった場合
        User <-- DP : 情報を表示します
    else 情報がなかった場合
        User <-- DP : 情報は見つかりませんでした
    end

    User <- DP : 別のツールの情報が知りたいですか？

end

deactivate DP
deactivate User
@enduml
```


# Commands

```bash:使い方
$ git clone https://github.com/Morichan/tis.git
$ cd tis
$ hug -f start_hug.py
```

