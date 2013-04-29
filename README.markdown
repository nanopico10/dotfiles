このリポジトリは何？
====================

私は複数の Linux や Windows で `Vim` や `GVim` を使用しており、個別に環境設定するよりも設定を一元化した方が<strike>カッコいい</strike>設定の書き忘れなどが無くなるなど、いろいろ良い面があるので、Github 上に一元化した設定を置いておきます。

使い方
------

Github リポジトリからクローンして、setup.sh などを実行したりします。

```bash
mkdir -p vimconf.d
git clone https://github.com/toshiki-hayashi/vimconf.d.git vimconf.d
./setup.sh
```

setup.sh の中で実行していることは以下の通りです。

1. `./setup.sh` の中で [NeoBundle](https://github.com/Shougo/neobundle.vim/) と [vimproc](https://github.com/Shougo/vimproc/) をインストールし、Linux か Mac であれば vimproc で必要なライブラリファイルをビルドします。
2. $HOME に .vimrc などの設定ファイルとプラグインがなければ、このリポジトリの中にある設定ファイルへのシンボリックリンクを貼ります。
3. 設定ファイルに記述しているプラグインを `:NeoBundleInstall` でインストールします。なお、使用しているプロトコルは https です。会社で ssh とか git なんていう<strike>怪しい</strike>オシャレなプロトコルが使えないもので…

コードも短いので、setup.sh を見ていただいたほうが早いです。

その他
------
README を日本語で書いたらハブられるって本当ですか？
