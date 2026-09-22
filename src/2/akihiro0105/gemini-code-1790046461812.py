import csv
import re
import subprocess
from urllib.parse import quote

HTSVOICE_TSV = "htsvoice-akihiro0105.tsv"
DROPBOX_ID_TSV = "dropbox-id.tsv"


def generate_dropbox_id_tsv(input_filepath, output_filepath):
    """
    htsvoice-akihiro0105.tsv からキャラ名と15桁のDropbox IDを抽出して
    dropbox-id.tsv を作成する関数
    """
    id_pattern = re.compile(r"/s/([a-zA-Z0-9]{15})/")

    rows = []
    with open(input_filepath, mode="r", encoding="utf-8") as f:
        reader = csv.DictReader(f, delimiter="\t")
        for row in reader:
            char_name = row["キャラ名"].strip()
            download_url = row["ダウンロードURL"].strip()

            match = id_pattern.search(download_url)
            if match:
                dropbox_id = match.group(1)
                rows.append([char_name, dropbox_id])

    with open(output_filepath, mode="w", encoding="utf-8", newline="") as f:
        writer = csv.writer(f, delimiter="\t")
        writer.writerow(["キャラ名", "DropBoxID"])
        writer.writerows(rows)

    return rows


def make_download_urls(name_id_rows):
    """
    dropbox-id.tsvのデータ(キャラ名, DropBoxID)から直リンクURLを作成し、
    (キャラ名, 直リンクURL) のリストを返す関数
    """
    name_url_rows = []
    for char_name, dropbox_id in name_id_rows:
        # キャラ名をURLエンコード
        encoded_name = quote(char_name)
        # ドメインを dl.dropboxusercontent.com へ変更した直リンクURLを生成
        direct_url = f"https://dl.dropboxusercontent.com/s/{dropbox_id}/{encoded_name}_1.0.zip?dl=1"
        name_url_rows.append((char_name, direct_url))

    return name_url_rows


def download(name_url_rows):
    """
    キャラ名と直リンクURLのリストを受け取り、wgetで順次ダウンロードする関数
    """
    for char_name, direct_url in name_url_rows:
        filename = f"{char_name}_1.0.zip"
        cmd = ["wget", "-O", filename, direct_url]

        print(f"Downloading: {filename} ...")
        subprocess.run(cmd, check=True)


if __name__ == "__main__":
    # 1. htsvoice-akihiro0105.tsv から dropbox-id.tsv を作成
    generate_dropbox_id_tsv(HTSVOICE_TSV, DROPBOX_ID_TSV)

    # 2. dropbox-id.tsv からデータを読み込み
    name_id_rows = []
    with open(DROPBOX_ID_TSV, mode="r", encoding="utf-8") as f:
        reader = csv.reader(f, delimiter="\t")
        next(reader)  # ヘッダー行をスキップ
        for row in reader:
            if row:
                name_id_rows.append((row[0], row[1]))

    # 3. 直リンクURLリストを作成
    name_url_rows = make_download_urls(name_id_rows)

    # 4. まとめてダウンロード実行
    download(name_url_rows)