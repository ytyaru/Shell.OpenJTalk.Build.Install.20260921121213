#!/usr/bin/env python3
import csv
from bs4 import BeautifulSoup

# http://akihiro0105.web.fc2.com/Downloads/Downloads-htsvoice.html
# HTMLテキスト（ファイルから読み込む場合は open('index.html').read() に差し替えてください）
#html_content = """
#"""

#html_content = None; 
#with open("base.html", "r", encoding="utf-8") as f:
#    html_content = f.read()

from pathlib import Path
html_content = Path("base.html").read_text(encoding="utf-8")

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
    #img_url = img['src'] if img and img.get('src') else ""
    img_url = 'http://akihiro0105.web.fc2.com/Downloads/' + img['src'] if img and img.get('src') else ""
    
    rows.append([name, add_date, provider, site_url, illustrator, img_url, download_url])

"""
# TSVファイルとして保存
with open('htsvoice-akihiro0105.tsv', 'w', encoding='utf-8', newline='') as f:
#with open(__file__ + '/htsvoice-akihiro0105.tsv', 'w', encoding='utf-8', newline='') as f:
    writer = csv.writer(f, delimiter='\t')
    writer.writerows(rows)
"""

def makeTsvFile():
    # 1. 実行中のスクリプト（.py）がある場所を正しく取得
    current_dir = Path(__file__).resolve().parent
    file_path = current_dir / "htsvoice-akihiro0105.tsv"
    # 2. csv.writer に path オブジェクトをそのまま渡して保存
    with open(file_path, "w", encoding="utf-8", newline="") as f:
        writer = csv.writer(f, delimiter="\t")
        writer.writerows(rows)

print("TSVファイルの作成が完了しました。")


"""
def outfileHere(filename):
    # 1. 実行中のスクリプト（.py）があるディレクトリの絶対パスを取得
    current_dir = Path(__file__).resolve().parent
    # 2. 出力したいファイル名と結合
    output_path = current_dir / "output.html"
    # 3. 1行で書き込み（ファイルがなければ自動作成、あれば上書き）
    output_path.write_text(html_content, encoding="utf-8")
"""


