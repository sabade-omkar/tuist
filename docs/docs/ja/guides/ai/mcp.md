---
title: モデルコンテキストプロトコル(MCP)
titleTemplate: :title · AI · Guides · Tuist
description: Tuist MCPサーバーを使用して、アプリ開発環境に自然言語インターフェースを導入する方法を学びましょう。
---

# モデルコンテキストプロトコル (MCP)

[MCP](https://www.claudemcp.com) は、LLM（大規模言語モデル）が開発環境と連携するための標準仕様として、[Claude](https://claude.ai) によって提案されたプロトコルです。
これは、LLM における USB-C のような存在と考えることができます。つまり、さまざまな開発環境とスムーズに接続できる、LLM 向けの共通インターフェースのようなものです。
貨物輸送を相互運用可能にしたコンテナや、アプリケーション層とトランスポート層を分離した通信プロトコルのように、MCPは[Claude](https://claude.ai/) のような LLMを活用したアプリケーションと、[Zed](https://zed.dev) や[Cursor](https://www.cursor.com) のようなエディタを、他のドメインと相互運用可能にします。
これは、LLM における USB-C のような存在と考えることができます。つまり、さまざまな開発環境とスムーズに接続できる、LLM 向けの共通インターフェースのようなものです。
貨物輸送を相互運用可能にしたコンテナや、アプリケーション層とトランスポート層を分離した通信プロトコルのように、MCPは[Claude](https://claude.ai/) のような LLMを活用したアプリケーションと、[Zed](https://zed.dev) や[Cursor](https://www.cursor.com) のようなエディタを、他のドメインと相互運用可能にします。

Tuist provides a local server through its CLI so that you can interact with your **app development environment**.
クライアントアプリをこのサーバーに接続することで、自然言語を用いてプロジェクトと対話できるようになります。

このページではMCPの設定方法と、その機能について学ぶことができます。

> [!NOTE]
> Tuist MCPサーバーは、操作対象となるプロジェクトの情報源として、Xcodeの最新プロジェクトを利用します。

## 導入手順

### [Claude](https://claude.ai)

[Claude desktop](https://claude.ai/download) を使用している場合は、<LocalizedLink href="/cli/mcp/setup/claude">tuist mcp setup claude</LocalizedLink> コマンドを実行することで、Claude 環境を構成できます。

または、 `~/Library/Application\ Support/Claude/claude_desktop_config.json` にあるファイルを手動で編集し、Tuist MCPサーバーを追加することもできます：

:::code-group

```json [Global Tuist installation (e.g. Homebrew)]
{
  "mcpServers": {
    "tuist": {
      "command": "tuist",
      "args": ["mcp", "start"]
    }
  }
}
```

```json [Mise installation]
{
  "mcpServers": {
    "tuist": {
      "command": "mise",
      "args": ["x", "tuist@latest", "--", "tuist", "mcp", "start"] // Or tuist@x.y.z to fix the version
    }
  }
}
```

:::

## 主な機能

以下のセクションでは、Tuist MCPサーバーの機能について解説します。

### 参考文献

#### 最近使用したプロジェクトとワークスペース

Tuistは、最近操作したXcodeプロジェクトおよびワークスペースの記録を保持しており、アプリケーションがそれらの依存関係グラフにアクセスできるようにすることで、強力な分析や可視化を可能にします。 このデータに対してクエリを実行することで、例えば以下のようなプロジェクトの構造や依存関係などの詳細情報を把握できます： このデータに対してクエリを実行することで、例えば以下のようなプロジェクトの構造や依存関係などの詳細情報を把握できます： このデータに対してクエリを実行することで、例えば以下のようなプロジェクトの構造や依存関係などの詳細情報を把握できます： このデータに対してクエリを実行することで、例えば以下のようなプロジェクトの構造や依存関係などの詳細情報を把握できます： このデータに対してクエリを実行することで、例えば以下のようなプロジェクトの構造や依存関係などの詳細情報を把握できます： このデータに対してクエリを実行することで、例えば以下のようなプロジェクトの構造や依存関係などの詳細情報を把握できます： このデータに対してクエリを実行することで、例えば以下のようなプロジェクトの構造や依存関係などの詳細情報を把握できます： このデータに対してクエリを実行することで、例えば以下のようなプロジェクトの構造や依存関係などの詳細情報を把握できます：

- 特定のターゲットに対する直接的および推移的な依存関係は何か？
- 最も多くのソースファイルを含むターゲットはどれで、いくつのファイルが含まれているか？
- グラフ内に含まれるすべての静的プロダクト（スタティックライブラリやフレームワークなど）は何か？
- すべてのターゲットを名前とプロダクトの種類（アプリ、フレームワーク、ユニットテストなど）とともに、アルファベット順で並び替えは可能か？
- 特定のフレームワークや外部依存関係に依存しているターゲットはどれか？
- プロジェクト内のすべてのターゲットに含まれるソースファイルの合計数はいくつか？
- ターゲット間に循環依存は存在するか？ある場合は、その発生箇所はどこか？
- 特定のリソース（画像や plistファイルなど）を使用しているターゲットはどれか？
- グラフ内で最も深い依存関係のチェーンは何か？また、それに関与しているターゲットはどれか？
- すべてのテストターゲットと、それぞれが関連付けられているアプリまたはフレームワークのターゲットを表示することは可能か？
- 最近の操作履歴に基づいて、ビルド時間が最も長いターゲットはどれか？
- 2つの特定のターゲット間で依存関係にどのような違いがあるか？
- プロジェクトに使用されていないソース ファイルやリソースはあるか？
- どのターゲットが共通の依存関係を持っており、それらは何か？

Tuist を使えば、これまでにない方法でXcodeプロジェクトを深く掘り下げて理解でき、複雑な構成であっても、理解・最適化・管理がより簡単になります！
