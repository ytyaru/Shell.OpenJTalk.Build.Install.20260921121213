#!/bin/bash
sudo apt -y install unar
# OpenJTalkをダウンロード・展開・配置する。
VOICE_INSTALL_PATH=/home/pi/root/sys/env/tool/openjtalk/voice
mkdir -p "${VOICE_INSTALL_PATH}"
install() { if which open_jtalk >/dev/null 2>&1; then echo "open_jtalkはインストール済みです。"; else download; install_engine; install_openjtalk; install_dic; install_voices; fi; }
# 音声合成エンジンOpenJTalkに必要なファイルをダウンロードする
download() {
	# engine
#	wget https://sourceforge.net/projects/hts-engine/files/latest/download
#	wget https://sourceforge.net/projects/open-jtalk/files/latest/download
	wget -O "hts_engine_API-1.10.tar.gz" "https://twds.dl.sourceforge.net/project/hts-engine/hts_engine%20API/hts_engine_API-1.10/hts_engine_API-1.10.tar.gz?viasf=1&fid=22480efa5eb3a4b1&e=1790033218&st=Rl1nAQiGBxWoe48QnjCxGQ"
	wget -O "open_jtalk-1.11.tar.gz" "https://twds.dl.sourceforge.net/project/open-jtalk/Open%20JTalk/open_jtalk-1.11/open_jtalk-1.11.tar.gz?viasf=1&fid=83ba95fe1ff9cba8&e=1790033414&st=t9c7J0aS_i-H7W_5APiB9w"
	# dic
	wget -O "open_jtalk_dic_utf_8-1.11.tar.gz" "https://twds.dl.sourceforge.net/project/open-jtalk/Dictionary/open_jtalk_dic-1.11/open_jtalk_dic_utf_8-1.11.tar.gz?viasf=1&fid=39ad4302bb70441e&e=1790045321&st=_c2bwt_mH8UhSRJkwXbWzA"
	# voice
#	wget https://sourceforge.net/projects/open-jtalk/files/HTS%20voice/hts_voice_nitech_jp_atr503_m001-1.05/hts_voice_nitech_jp_atr503_m001-1.05.tar.gz/download
	wget -O "hts_voice_nitech_jp_atr503_m001-1.05.tar.gz" "https://twds.dl.sourceforge.net/project/open-jtalk/HTS%20voice/hts_voice_nitech_jp_atr503_m001-1.05/hts_voice_nitech_jp_atr503_m001-1.05.tar.gz?viasf=1&fid=ab2d5cdf4bec34c8&e=1790033858&st=Cg97KzfEk9w2--MgsAIsmg"
#	wget https://sourceforge.net/projects/mmdagent/files/latest/download
	wget -O "MMDAgent_Example-1.8.zip" "https://twds.dl.sourceforge.net/project/mmdagent/MMDAgent_Example/MMDAgent_Example-1.8/MMDAgent_Example-1.8.zip?viasf=1&fid=16a21c78e4405f30&e=1790034088&st=1b5pU25nQWA0rN8GRpdD2g"
	git clone https://github.com/icn-lab/htsvoice-tohoku-f01
	cp -r htsvoice-tohoku-f01 $HOME/root/sys/env/tool/openjtalk/voice/
	for type in A B G T alpha beta; do
		wget -O "type-${type}.htsvoice" "https://github.com/anoyetta/ACT.Hojoring/blob/master/source/ACT.TTSYukkuri/ACT.TTSYukkuri.Core/OpenJTalk/voice/type-${type}.htsvoice?raw=true"
	done
	# http://akihiro0105.web.fc2.com/Downloads/Downloads-htsvoice.html
	wget "https://www.dropbox.com/s/lhjwmh6tosmv7tm/%E6%83%B3%E9%9F%B3%E3%81%84%E3%81%8F%E3%82%8B_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/5yrh8j4gaqmbn89/%E6%83%B3%E9%9F%B3%E3%81%84%E3%81%8F%E3%81%A8_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/x1f7bldwjrmzton/%E4%BA%AC%E6%AD%8C%E3%82%AB%E3%82%AA%E3%83%AB_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/qy24nlfwqhbtzvd/%E6%B2%99%E9%9F%B3%E3%81%BB%E3%82%80_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/vsrsxx0h368ru2m/20%E4%BB%A3%E7%94%B7%E6%80%A701_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/rb4t4x1p8x7182r/%E3%81%AA%E3%81%AA%E3%81%84%E3%82%8D%E3%83%8B%E3%82%B8_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/aibhqzakxv6a7iw/%E9%81%A0%E8%97%A4%E6%84%9B_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/0afvd64suh51e9g/%E9%81%8A%E9%9F%B3%E4%B8%80%E8%8E%89_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/letu9qbtspuqa68/%E3%82%B9%E3%83%A9%E3%83%B3%E3%82%AD_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/1q7ayg05bv8c95x/%E8%92%BC%E6%AD%8C%E3%83%8D%E3%83%AD_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/fbr6wcaoaj6gfs5/%E7%B7%8B%E6%83%BA_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/cqfuwsns0kveo75/%E5%A4%A9%E6%9C%88%E3%82%8A%E3%82%88%E3%82%93_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/o6vd5d43spnqiqw/%E5%8F%A5%E9%9F%B3%E3%82%B3%E3%83%8E%E3%80%82_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/1oqbtc4mqo76r7d/%E5%94%B1%E5%9C%B0%E3%83%A8%E3%82%A8_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/ueivoklj4w5alec/%E3%82%AB%E3%83%9E%E5%A3%B0%E3%82%AE%E3%83%AB%E5%AD%90_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/dhhxe5ax8gq9wf7/%E3%83%AF%E3%82%BF%E3%82%B7_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/0a9sdvdc97y8cjy/%E9%A3%B4%E9%9F%B3%E3%82%8F%E3%82%81%E3%81%82_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/wzg3elfzpj3r1nn/%E8%83%BD%E6%B0%91%E9%9F%B3%E3%82%BD%E3%82%A6_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/565p1ezszoukfy7/%E7%A9%BA%E5%94%84%E3%82%AB%E3%83%8A%E3%82%BF_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/divfct7u7deilpa/%E6%88%AF%E6%AD%8C%E3%83%A9%E3%82%AB%E3%83%B3_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/biaaofnmd9idit1/%E8%AA%A0%E9%9F%B3%E3%82%B3%E3%83%88_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/9ecqymm6jccgldk/%E7%99%BD%E7%8B%90%E8%88%9E_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/ji63elmcjk60esf/%E6%9D%BE%E5%B0%BEP_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/r9upv0z7wa8psb6/%E7%91%9E%E6%AD%8C%E3%83%9F%E3%82%BA%E3%82%AD_Talk_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/9ocd1o0a8adabuy/%E8%96%AA%E5%AE%AE%E9%A2%A8%E5%AD%A3_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/4bawa2afl4hqzu4/%E5%92%8C%E9%9F%B3%E3%82%B7%E3%83%90_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/sny6b16eeeayee3/%E3%82%B0%E3%83%AA%E3%83%9E%E3%83%AB%E3%82%AD%E3%83%B3_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/7ut7pfmjoaqdaj3/%E9%97%87%E5%A4%9C%20%E6%A1%9C_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/vf4je8a4y2v1znz/%E6%9C%88%E9%9F%B3%E3%83%A9%E3%83%9F_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/t96gik07qrn2oes/%E6%A1%83%E9%9F%B3%E3%83%A2%E3%83%A2_1.0.zip?dl=1"
	wget "https://www.dropbox.com/s/elt5kbgbzeaksls/%E7%8D%A3%E9%9F%B3%E3%83%AD%E3%82%A6_1.0.zip?dl=1"
	for file in *\?dl=1; do
		[ -e "$file" ] || continue
		new_name="${file%\?dl=1}"
		mv "$file" "$new_name"
	done
	install_ragolun
}
urlencode() { echo -n "$1" | jq -sRr @uri; }
# https://ragolun.exblog.jp/
# https://ragolun.exblog.jp/22985257/
# > kukululiveにkukutalkが実装されたので対応しているものは横に◎マークを出すことにしました。
#   海賊まさver4 H-08 ひめる３ J2 R M 風音桜凪(Mの改名版) 雪音ルウ ぴよちゃんぼいす（
# バージョン
#   海賊まさver2→ver4→ver5
#   H-01→02→08→09
#   ひめる→３
#   J→J2
#   M→風音桜凪				# 名前変更されただけだと思われる
#   雪音ルウ→２
#   ぴよちゃんぼいす（		# 末尾の（が誤字なのか正式名称なのか不明
install_ragolun() {
	# 元は以下のようなリンク。これを直リンク用URLに修正する。ドメインを変更し、かつdl=0をdl=1にする。
	# https://www.dropbox.com/s/hguep8b779m6pne/%E6%B5%B7%E8%B3%8A%E3%81%BE%E3%81%95ver2.htsvoice?dl=0
	# 1. 【共通化】直リンク用ドメイン（s/ まで含む）と末尾引数
	local url_prefix="https://dl.dropboxusercontent.com/s/"
	local ext=".htsvoice"
	local url_suffix="?dl=1"

	# 2. 【個別リスト】保存名 と Dropboxの15桁のID
	local voice_list
	voice_list=$(cat << 'EOF'
海賊まさver2        hguep8b779m6pne
海賊まさver4        v7hfml5wx1zs664
海賊まさver5        5foafe2wz3kth6q
H-01                3dkccu2bwhrcjl2
H-02                48fwxm5g9nibd7u
H-08                tc1z6tzvkf30ovy
H-09                oxy698hgpyepfyf
ひめる              mxw6g8vcndepcgw
ひめる３            gwxke16rnq10ild
J                   267skj0apkj15yv
J2                  1oui8u863g2kxy1
R                   zc6zc4reg73dc7s
M                   10j3gkk1cug9zac
風音桜凪            omocop5igusqc23
L                   aphzn65iu1knc8j
雪音ルウ            8mjqth3tsiglrws
雪音ルウ２          z8d9jjvtxcztkgn
ぴよちゃんぼいす（  cn5foldhnamxw58
EOF
)
	echo "$voice_list" | while read -r filename dropbox_id; do
		[[ -z "$filename" || "$filename" =~ ^# ]] && continue
		local encoded_filename
		encoded_filename=$(urlencode "${filename}$ext")
		local full_url="${url_prefix}/${dropbox_id}/${encoded_filename}${url_suffix}"
		echo "Downloading: ${filename}$ext ..."
		# クエリを排除した綺麗な名前で上書き保存
		wget -O "${VOICE_INSTALL_PATH}/${filename}$ext" "${full_url}"
	done
}
install_engine() {
	tar -zxvf hts_engine_API-1.10.tar.gz
	cd hts_engine_API-1.10
	./configure
	make
	sudo make install
	cd ..
}
install_openjtalk() {
	tar -zxvf open_jtalk-1.11.tar.gz
	cd open_jtalk-1.11
	./configure --with-hts-engine-header-path=/usr/local/include --with-hts-engine-library-path=/usr/local/lib --with-charset=UTF-8
	make
	sudo make install
	which open_jtalk
	cd ..
}
# 辞書がなければダウンロードして配置する
install_dic() {
	if [ -f "/usr/local/dic/sys.dic" ]; then
		echo "辞書データはすでに存在します。"
	else
		echo "辞書データをダウンロード・インストールします..."
		# 辞書のダウンロード (URLは適宜最新のものを指定)
#		wget -O "open_jtalk_dic_utf_8-1.11.tar.gz" "https://twds.dl.sourceforge.net/project/open-jtalk/Dictionary/open_jtalk_dic-1.11/open_jtalk_dic_utf_8-1.11.tar.gz?viasf=1&fid=39ad4302bb70441e&e=1790045321&st=_c2bwt_mH8UhSRJkwXbWzA"
		tar -zxvf open_jtalk_dic_utf_8-1.11.tar.gz
		sudo mkdir -p /usr/local/dic
		sudo cp -r open_jtalk_dic_utf_8-1.11/* /usr/local/dic/
	fi
}

# Zipファイル展開（中には文字コード指定して展開しないと文字化けするものがある）
process_unar() {
	local encoding="$1"
	shift
	local names=("$@")
	local opts=()
	[ -n "$encoding" ] && opts=(-e "$encoding")
	for name in "${names[@]}"; do
		local file="${name}_1.0.zip"
		[ -e "$file" ] || continue
		unar "${opts[@]}" "$file"
	done
}
# Voice圧縮ファイルを展開する
extract_voices() {
	mkdir -p "${VOICE_INSTALL_PATH}"
	tar -zxvf hts_voice_nitech_jp_atr503_m001-1.05.tar.gz
	find hts_voice_nitech_jp_atr503_m001-1.05/ -name *.htsvoice
	unzip MMDAgent_Example-1.8.zip
	find MMDAgent_Example-1.8/ -name *.htsvoice
#	sudo apt -y install unar
	# エンコード（cp932）が必要な名前のリスト
	names_cp932=(
		月音ラミ "闇夜 桜" グリマルキン 和音シバ カマ声ギル子 唱地ヨエ 句音コノ。
		天月りよん なないろニジ 20代男性01 沙音ほむ 薪宮風季
	)
	# エンコード不要な名前のリスト
	names_default=(
		獣音ロウ 桃音モモ 瑞歌ミズキ_Talk 松尾P 誠音コト 白狐舞 戯歌ラカン
		空唄カナタ 飴音わめあ 能民音ソウ ワタシ 緋惺 スランキ 蒼歌ネロ
		遊音一莉 遠藤愛 京歌カオル 想音いくと 想音いくる
	)
	process_unar "cp932" "${names_cp932[@]}"
	process_unar "" "${names_default[@]}"
}
install_voices() {
	extract_voices;
	find . -type f -name "*.htsvoice" -print0 | xargs -0 -I {} cp {} "${VOICE_INSTALL_PATH}"
}
test() {
	echo 'OpenJTalkのインストールに成功しました！' | open_jtalk \
		-x /usr/local/dic \
		-m "${VOICE_INSTALL_PATH}/mei_normal.htsvoice" \
		-ow /dev/stdout \
		| aplay > /dev/null 2>&1
}
install;
test;
