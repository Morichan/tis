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

![シーケンス図](http://www.plantuml.com/plantuml/png/fLHHQnf147xVNx7atJzGIaaWqFHD2ANF5tCa1rSLFLlwbjrDmYKc65giI1-qJQBMGAGqRMWmxOyPLk_Dlz2PlTFi6LiQweFStSptpJVVpknoEN1AGUMbpvnSK2XnK1rGGv3VkLFcpyjkYHKnxkMyefCF-Ahd-8MjhE-yeV1gDXLSMgjiyKAUhxnONw8mlgRYJxrWhR914NpQhcmmAkczSW8tBaH_FFC4QVaZrB5BEjG5YCkHsjFjBo3VZkfD42683cD-eL3a82M8_IGiZa3iWZm0qQS7qOjwEnW5yHD4rwg5gh42rZ7rh4hwvDYk0Q86eWsYZco9DYCkZKXpZLld80z1j11pN_MV6U_Z9iCGP1zK0-Grg2wehvFX0KkgaT4eGmv0za3rhUR8SufQIJyeJnag5KRVhdMrlXWGdmfYrbsdbDlcAzbd_3L-I_Tx1qrEaT2FCvax-2mzxeInJNSUazQeQmrTUm_Yb0n8WurzL_hs4zRrfoC4uaBl7rDFiGFOea9_co2h-jTUr15c5YI-pbc8iwJRL_eaP1n_3skR4FDjJ5d-tZvbBR30al0G6zpyPcBV33YRcF7dc-aoNEhQ85AtevskSUAGfiSIGSUEiqJ2_ul3d8grW3AMRxbivfpgcBMUjHDzx8tFRa0qp7uscUkNNPi8TxZwRrnY47KmzOm0j4D8zm7aErnwmzwA7KkWCLA7vzZTWYj67DcRQ2XmTwkJOIintceVxn7hpTnWovY3L-bl)

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

