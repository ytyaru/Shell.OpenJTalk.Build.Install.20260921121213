#!/usr/bin/env python3
import os
import csv
from bs4 import BeautifulSoup
from pathlib import Path

# このスクリプトがある場所に移動する
script_dir = Path(__file__).resolve().parent
os.chdir(script_dir)

# スクレイピングするhtmlファイルをテキストで読み込む
html_content = Path("base.html").read_text(encoding="utf-8")

# HTMLテキストを構造化したデータに変換する
def makeRows(html_content):
    soup = BeautifulSoup(html_content, 'html.parser')

    # TSVヘッダー
    headers = ["キャラ名", "追加日", "音声データ提供者名", "キャラクターサイトURL", "イラスト著者名", "イラストURL", "ダウンロードURL"]

    rows = [headers]

    # 各キャラクター要素（<div style="height: 341px;">）を取得
    items = soup.find_all('div', style=lambda value: value and 'height: 341px' in value)

    for item in items:
        # キャラ名
        h2 = item.find('h2')
        name = h2.get_text(strip=True) if h2 else ""
        
        # 追加日、音声データ提供者名、キャラクターサイトURL、ダウンロードURL
        add_date = ""
        provider = ""
        site_url = ""
        download_url = ""
        
        ul = item.find('ul')
        if ul:
            for li in ul.find_all('li'):
                text = li.get_text()
                if "追加日" in text:
                    add_date = text.replace("追加日", "").strip()
                elif "音声データ提供者" in text:
                    provider = text.replace("音声データ提供者", "").strip()
                elif "キャラクターサイト" in text:
                    a = li.find('a')
                    if a and a.get('href'):
                        site_url = a['href']
                        
            download_a = ul.find('a', class_='button-dark')
            if download_a and download_a.get('href'):
                download_url = download_a['href']
                
        # イラスト著者名
        illustrator = ""
        excerpt = item.find('p', class_='the-excerpt')
        if excerpt:
            excerpt_text = excerpt.get_text(strip=True)
            if "イラスト：" in excerpt_text:
                illustrator = excerpt_text.replace("イラスト：", "").strip()
                
        # イラストURL（サイト内に画像URLが含まれる場合）
        img = item.find('img')
        img_url = 'http://akihiro0105.web.fc2.com/Downloads/' + img['src'] if img and img.get('src') else ""
        
        rows.append([name, add_date, provider, site_url, illustrator, img_url, download_url])

    return rows

# 構造化したデータからTSVファイルを出力する
def makeTsvFile(rows):
    # 1. 実行中のスクリプト（.py）がある場所を正しく取得
    file_path = script_dir / "htsvoice-akihiro0105.tsv"
    # 2. csv.writer に path オブジェクトをそのまま渡して保存
    with open(file_path, "w", encoding="utf-8", newline="") as f:
        writer = csv.writer(f, delimiter="\t")
        writer.writerows(rows)

#実行する
makeTsvFile(makeRows(html_content))

print("TSVファイルの作成が完了しました。")

