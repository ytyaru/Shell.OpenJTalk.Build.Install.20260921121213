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
	wget https://twds.dl.sourceforge.net/project/hts-engine/hts_engine%20API/hts_engine_API-1.10/hts_engine_API-1.10.tar.gz?viasf=1&fid=22480efa5eb3a4b1&e=1790033218&st=Rl1nAQiGBxWoe48QnjCxGQ
	wget https://twds.dl.sourceforge.net/project/open-jtalk/Open%20JTalk/open_jtalk-1.11/open_jtalk-1.11.tar.gz?viasf=1&fid=83ba95fe1ff9cba8&e=1790033414&st=t9c7J0aS_i-H7W_5APiB9w
	# dic
	wget https://twds.dl.sourceforge.net/project/open-jtalk/Dictionary/open_jtalk_dic-1.11/open_jtalk_dic_utf_8-1.11.tar.gz?viasf=1&fid=39ad4302bb70441e&e=1790045321&st=_c2bwt_mH8UhSRJkwXbWzA
	# voice
#	wget https://sourceforge.net/projects/open-jtalk/files/HTS%20voice/hts_voice_nitech_jp_atr503_m001-1.05/hts_voice_nitech_jp_atr503_m001-1.05.tar.gz/download
	wget https://twds.dl.sourceforge.net/project/open-jtalk/HTS%20voice/hts_voice_nitech_jp_atr503_m001-1.05/hts_voice_nitech_jp_atr503_m001-1.05.tar.gz?viasf=1&fid=ab2d5cdf4bec34c8&e=1790033858&st=Cg97KzfEk9w2--MgsAIsmg
#	wget https://sourceforge.net/projects/mmdagent/files/latest/download
	wget https://twds.dl.sourceforge.net/project/mmdagent/MMDAgent_Example/MMDAgent_Example-1.8/MMDAgent_Example-1.8.zip?viasf=1&fid=16a21c78e4405f30&e=1790034088&st=1b5pU25nQWA0rN8GRpdD2g
	git clone https://github.com/icn-lab/htsvoice-tohoku-f01
	cp -r htsvoice-tohoku-f01 $HOME/root/sys/env/tool/openjtalk/voice/
	for type in A B G T alpha beta; do
		wget -O "type-${type}.htsvoice" "https://github.com/anoyetta/ACT.Hojoring/blob/master/source/ACT.TTSYukkuri/ACT.TTSYukkuri.Core/OpenJTalk/voice/type-${type}.htsvoice?raw=true"
	done
	wget https://www.dropbox.com/s/lhjwmh6tosmv7tm/%E6%83%B3%E9%9F%B3%E3%81%84%E3%81%8F%E3%82%8B_1.0.zip?dl=1
	wget https://www.dropbox.com/s/5yrh8j4gaqmbn89/%E6%83%B3%E9%9F%B3%E3%81%84%E3%81%8F%E3%81%A8_1.0.zip?dl=1
	wget https://www.dropbox.com/s/x1f7bldwjrmzton/%E4%BA%AC%E6%AD%8C%E3%82%AB%E3%82%AA%E3%83%AB_1.0.zip?dl=1
	wget https://www.dropbox.com/s/qy24nlfwqhbtzvd/%E6%B2%99%E9%9F%B3%E3%81%BB%E3%82%80_1.0.zip?dl=1
	wget https://www.dropbox.com/s/vsrsxx0h368ru2m/20%E4%BB%A3%E7%94%B7%E6%80%A701_1.0.zip?dl=1
	wget https://www.dropbox.com/s/rb4t4x1p8x7182r/%E3%81%AA%E3%81%AA%E3%81%84%E3%82%8D%E3%83%8B%E3%82%B8_1.0.zip?dl=1
	wget https://www.dropbox.com/s/aibhqzakxv6a7iw/%E9%81%A0%E8%97%A4%E6%84%9B_1.0.zip?dl=1
	wget https://www.dropbox.com/s/0afvd64suh51e9g/%E9%81%8A%E9%9F%B3%E4%B8%80%E8%8E%89_1.0.zip?dl=1
	wget https://www.dropbox.com/s/letu9qbtspuqa68/%E3%82%B9%E3%83%A9%E3%83%B3%E3%82%AD_1.0.zip?dl=1
	wget https://www.dropbox.com/s/1q7ayg05bv8c95x/%E8%92%BC%E6%AD%8C%E3%83%8D%E3%83%AD_1.0.zip?dl=1
	wget https://www.dropbox.com/s/fbr6wcaoaj6gfs5/%E7%B7%8B%E6%83%BA_1.0.zip?dl=1
	wget https://www.dropbox.com/s/cqfuwsns0kveo75/%E5%A4%A9%E6%9C%88%E3%82%8A%E3%82%88%E3%82%93_1.0.zip?dl=1
	wget https://www.dropbox.com/s/o6vd5d43spnqiqw/%E5%8F%A5%E9%9F%B3%E3%82%B3%E3%83%8E%E3%80%82_1.0.zip?dl=1
	wget https://www.dropbox.com/s/1oqbtc4mqo76r7d/%E5%94%B1%E5%9C%B0%E3%83%A8%E3%82%A8_1.0.zip?dl=1
	wget https://www.dropbox.com/s/ueivoklj4w5alec/%E3%82%AB%E3%83%9E%E5%A3%B0%E3%82%AE%E3%83%AB%E5%AD%90_1.0.zip?dl=1
	wget https://www.dropbox.com/s/dhhxe5ax8gq9wf7/%E3%83%AF%E3%82%BF%E3%82%B7_1.0.zip?dl=1
	wget https://www.dropbox.com/s/0a9sdvdc97y8cjy/%E9%A3%B4%E9%9F%B3%E3%82%8F%E3%82%81%E3%81%82_1.0.zip?dl=1
	wget https://www.dropbox.com/s/wzg3elfzpj3r1nn/%E8%83%BD%E6%B0%91%E9%9F%B3%E3%82%BD%E3%82%A6_1.0.zip?dl=1
	wget https://www.dropbox.com/s/565p1ezszoukfy7/%E7%A9%BA%E5%94%84%E3%82%AB%E3%83%8A%E3%82%BF_1.0.zip?dl=1
	wget https://www.dropbox.com/s/divfct7u7deilpa/%E6%88%AF%E6%AD%8C%E3%83%A9%E3%82%AB%E3%83%B3_1.0.zip?dl=1
	wget https://www.dropbox.com/s/biaaofnmd9idit1/%E8%AA%A0%E9%9F%B3%E3%82%B3%E3%83%88_1.0.zip?dl=1
	wget https://www.dropbox.com/s/9ecqymm6jccgldk/%E7%99%BD%E7%8B%90%E8%88%9E_1.0.zip?dl=1
	wget https://www.dropbox.com/s/ji63elmcjk60esf/%E6%9D%BE%E5%B0%BEP_1.0.zip?dl=1
	wget https://www.dropbox.com/s/r9upv0z7wa8psb6/%E7%91%9E%E6%AD%8C%E3%83%9F%E3%82%BA%E3%82%AD_Talk_1.0.zip?dl=1
	wget https://www.dropbox.com/s/9ocd1o0a8adabuy/%E8%96%AA%E5%AE%AE%E9%A2%A8%E5%AD%A3_1.0.zip?dl=1
	wget https://www.dropbox.com/s/4bawa2afl4hqzu4/%E5%92%8C%E9%9F%B3%E3%82%B7%E3%83%90_1.0.zip?dl=1
	wget https://www.dropbox.com/s/sny6b16eeeayee3/%E3%82%B0%E3%83%AA%E3%83%9E%E3%83%AB%E3%82%AD%E3%83%B3_1.0.zip?dl=1
	wget https://www.dropbox.com/s/7ut7pfmjoaqdaj3/%E9%97%87%E5%A4%9C%20%E6%A1%9C_1.0.zip?dl=1
	wget https://www.dropbox.com/s/vf4je8a4y2v1znz/%E6%9C%88%E9%9F%B3%E3%83%A9%E3%83%9F_1.0.zip?dl=1
	wget https://www.dropbox.com/s/t96gik07qrn2oes/%E6%A1%83%E9%9F%B3%E3%83%A2%E3%83%A2_1.0.zip?dl=1
	wget https://www.dropbox.com/s/elt5kbgbzeaksls/%E7%8D%A3%E9%9F%B3%E3%83%AD%E3%82%A6_1.0.zip?dl=1
	for file in *\?dl=1; do
		[ -e "$file" ] || continue
		new_name="${file%\?dl=1}"
		mv "$file" "$new_name"
	done
	install_ragolun
}
# https://ragolun.exblog.jp/
# https://ragolun.exblog.jp/22985257/
# kukululiveにkukutalkが実装されたので対応しているものは横に◎マークを出すことにしました。
install_ragolun() {
	#海賊まさver2
	# https://www.dropbox.com/s/hguep8b779m6pne/%E6%B5%B7%E8%B3%8A%E3%81%BE%E3%81%95ver2.htsvoice?dl=0
	wget https://uc56e45bc311f0fa650d3b873762.dl.dropboxusercontent.com/cd/0/get/DInjHOiAa1INSbVcyC7AXXcAPjcUZ-ISFxojKutEZUw6MKvP6d2z6-5a7mYC0swA2Vv59SpfzMx05sm7sd-r7A3dTsVX1y8DMyl3nSP7RTRQFE0W4iHlKaT_8eJALuH_1ceQnLD_9q0unTAiIXA_y5r4/file?_download_id=910063099080499646843715867714430201450683478122678083837074415823&_log_download_success=1&_notify_domain=www.dropbox.com&dl=1
	#海賊まさver4　◎
	# https://www.dropbox.com/s/v7hfml5wx1zs664/%E6%B5%B7%E8%B3%8A%E3%81%BE%E3%81%95ver4.htsvoice?dl=0
	wget https://uc5466a83b297af313e87d3a3496.dl.dropboxusercontent.com/cd/0/get/DIkwTcF6lopZt4NisybHLDtRNA1zHfP2EQc-mKQ9SXMjPWUpq89FR12CSRwoaHpXjxs-uZnXmrD0VBDtf_UsYKb67iZIEdKKPinS4dsovFUjC8fyfafb_1WoEDVUMexaT4xxj-3LdMc3ops7zC0gE-wE/file?_download_id=75565940093810642737389571407163023768462881026639430657788092712&_log_download_success=1&_notify_domain=www.dropbox.com&dl=1
	#海賊まさver5
	# https://www.dropbox.com/s/5foafe2wz3kth6q/%E6%B5%B7%E8%B3%8A%E3%81%BE%E3%81%95ver5.htsvoice?dl=0
	wget https://ucd29e07e201cdc5c2ca92e53d44.dl.dropboxusercontent.com/cd/0/get/DIlJ8i2ARhKPazOfAecQpl27pZbQW2fNN-70DocxWcRu_LDyx3fMT3HnGUmtEPkozpKwx_gxEE8H5aBlHh89E2fNrU1yrVAKbX9V0Xnezyvdj-JWIrcYMbcT2fjrVMHZnlWd_1pkeSYESaAAdz_GY25v/file?_download_id=57396374812800784609221716976845726798061941264458970518245919916&_log_download_success=1&_notify_domain=www.dropbox.com&dl=1
	# H01
	# https://www.dropbox.com/s/3dkccu2bwhrcjl2/H-01.htsvoice?dl=0
	wget https://ucc25e182d658767b5b42ad54a3b.dl.dropboxusercontent.com/cd/0/get/DIkpTBB79TyhVWj3uNju46-FsJk7Lbmp1AmMavdCY1lKqzHejd7v5ALxIF17uUBaHQ4GUitZo_Z2GWDYq4lxTRfiCni6pPwjigW0mKj00B2JpU3XxZmhNuKePp1VeWYVFezaEIwYrZA-Jrb9e7d6Jw9P/file?_download_id=7172143291825434072006259336259482177339096471779828738607500881275&_log_download_success=1&_notify_domain=www.dropbox.com&dl=1
	# H02
	# https://www.dropbox.com/s/48fwxm5g9nibd7u/H-02.htsvoice?dl=0
	wget https://ucbf78d94b510e069ef47aed6673.dl.dropboxusercontent.com/cd/0/get/DInKcy7V_2ibutv7Ch3NXkNL5fo13fTKPyoJMxeyGocZKJLyLvnGkNcGn4hcBtK0lbkC-4Cjatr7p9ztzCBUCzUGpjTXS71uU1aULiBkYDlFkeihmHmIO8_tRtb4rVRNPIvG1tsefvknfxCLGHRgES9P/file?_download_id=4624942324806174078344416184156426359750037605737444781371176529&_log_download_success=1&_notify_domain=www.dropbox.com&dl=1
	# H08　◎
	# https://www.dropbox.com/s/tc1z6tzvkf30ovy/H-08.htsvoice?dl=0
	wget https://ucd7a04bf87416177962c6d98002.dl.dropboxusercontent.com/cd/0/get/DImQ1G6yOaklbMmKnfGLqPBssa1ynxSjtyL2PEDOyykzkjvbrBWQmBMNK0U7mpCJ91aILUWt1C8YBIY5a1m2AX-40bF3EqgqBoX7fnWudgKU0vf58tE-pzHit9v-zwtaQ5ZS7JQkQrH7GvnPeTArqkNI/file?_download_id=04307159349678835476550669835116857726972952169465999042926898968&_log_download_success=1&_notify_domain=www.dropbox.com&dl=1
	# H09
	# https://www.dropbox.com/s/oxy698hgpyepfyf/H-09.htsvoice?dl=0
	wget https://ucf764f20791efa2c6ecb3b9df14.dl.dropboxusercontent.com/cd/0/get/DInnGtd41Ju27tYIX9HLgg13YLE6wmLSDcolMFkkKNXkiLlWQw9QlAi-Fd8nOKH4SL2Bzq4x-4Glcr5HXv47m3YoCvi0du3Ao25gYKoKRAECqeq_7z9uBHP9N7UsaEIHM8aC0gXhepE6VvkQzAqPotuu/file?_download_id=2305096262588599645087553493129123597773829031622030724029328672464&_log_download_success=1&_notify_domain=www.dropbox.com&dl=1
	# ひめる
	# https://www.dropbox.com/s/mxw6g8vcndepcgw/%E3%81%B2%E3%82%81%E3%82%8B.htsvoice?dl=0
	wget https://uc25c9ecc1e64d33c861b666841c.dl.dropboxusercontent.com/cd/0/get/DIk4NZMsRmgg4nPr7dPw1DZ4O6SeWvnedkOUA2_NMV3OGx45jHXL8eo5-V6DoYL64imxBMU4CghqU6hNNskyTRO0s6M8XNdaxJkHLfazyveR28680tSOtVdKPNUdK1DAhOXeiYQy1LyIJ5wk-RHIYkns/file?_download_id=352928641665296361820614007902237806314364565175203550120347805119&_log_download_success=1&_notify_domain=www.dropbox.com&dl=1
	# ひめる３　◎
	# https://www.dropbox.com/s/gwxke16rnq10ild/%E3%81%B2%E3%82%81%E3%82%8B%EF%BC%93.htsvoice?dl=0
	wget https://uc945f407da97d7cb268987eda29.dl.dropboxusercontent.com/cd/0/get/DImnjHLErsvOwNuLkVUHcpJfKKVp8zW05xczmoavbnyr3ykmbIICLYV7mXS5gcAqUbRSogxV712ZRyPLLUCZRGY6c7HBfycrsMeYVsjSY82JJG1dz-vUEv-b9hX7U_zc3NFJqn-UkxChjb6nvgNWbYE6/file?_download_id=18359448198638784328287598121137553685766771326442533559491315328&_log_download_success=1&_notify_domain=www.dropbox.com&dl=1
	# J
	# https://www.dropbox.com/s/267skj0apkj15yv/J.htsvoice?dl=0
	wget https://uc57b579947a8db25fd840d3f7e4.dl.dropboxusercontent.com/cd/0/get/DIlOL-TMBPL0FhcB_Hsh_grD9tubSEds-Wm6VpLf1V-cIYd5ohZ9PaU0G38Hw6wMgaMWrxVmUWLsrmzv0i4MjLwW-PZm5koToK0qEfpJdaTukTgnU5bU3i7RP5CbhyS3iiuWUUYNuBwSf48YED8bZ5na/file?_download_id=5602468476357245561362298325274193180584537873621077431778482526&_log_download_success=1&_notify_domain=www.dropbox.com&dl=1
	# J2　◎
	# https://www.dropbox.com/s/1oui8u863g2kxy1/j2.htsvoice?dl=0
	wget https://uc34f681bc7c8a1c62981ad10982.dl.dropboxusercontent.com/cd/0/get/DIkvGm50E1NRYYEXD6NvjP3gi5-w8rxGFblS_y8ZwvDLdi_1Kqw5XfU6xK1T_iOo6mgFPXlWjoEHqMOQ9S4am6JHAVbbhZGLL8YB51a06foUvU0XPpZh0Rk7v_-zBZZmZeHgw5h58fdQec6VfjhUtU-E/file?_download_id=60681907797910329528087608284243949746649797155268739892827272&_log_download_success=1&_notify_domain=www.dropbox.com&dl=1
	# R
	# https://www.dropbox.com/s/zc6zc4reg73dc7s/R.htsvoice?dl=0
	wget https://uc8e6cd05cf807e43bcf9849424a.dl.dropboxusercontent.com/cd/0/get/DImKte0X6z5JBr60biUauuT_d9-7T4_wcpBm0_wV4pkXcQrSi5vLmECpjN8DLuv8JpHnBnZmd4YHJSDrYhUDwdkwOCm69V6Wf-rBlG1p369YYwvwBzLT_YpTbO2e4xq0XfXb7QHkUQEvQRtqykkHAStI/file?_download_id=6839916356500156165534176173744118073885113409055667557612411868&_log_download_success=1&_notify_domain=www.dropbox.com&dl=1
	# M　◎→名前変更→風音桜凪　◎
	# https://www.dropbox.com/s/10j3gkk1cug9zac/M.htsvoice?dl=0
	wget https://uc7b5a74450ebcea04946acf3786.dl.dropboxusercontent.com/cd/0/get/DIllxEgmS9I1R9MLbZJAeXUuwrohRWk1ZkEcOjPohrOnCkLO1Iz2L1OneJahIUpdfOIBml9Q3tKSp_5RrxnVwbM1M5jWMcFadpGRepWR0CeQi7HKxAHLRncPcJID5DgDEpwYoue--Uk4oi5OPfH-Ky8f/file?_download_id=39760446666326862955196154074892435493307798720698014963778009&_log_download_success=1&_notify_domain=www.dropbox.com&dl=1
	# https://www.dropbox.com/s/omocop5igusqc23/%E9%A2%A8%E9%9F%B3%E6%A1%9C%E5%87%AA.htsvoice?dl=0
	wget https://ucf8a736d61a8eef8834935b7ea9.dl.dropboxusercontent.com/cd/0/get/DIkxkIACYSQ1XYJk8st_BOX6KABW6rhEGEzWLMqYKy0xP6VKXithTg3xsLS9vqPrX34YUQGdxc04DUhDLOIsTb5XJ0dUKWljFIK2RmI11-0rdlAnf7fL5geXJBRMDu2WiDuRBgdOIRkhpLztqXu7HHBJ/file?_download_id=146022471841801514319611142082755219934190875723303364426319063929&_log_download_success=1&_notify_domain=www.dropbox.com&dl=1
	# L 　◎
	# https://www.dropbox.com/s/aphzn65iu1knc8j/L.htsvoice?dl=0
	wget https://uc792f6fb4fa4d3eec1817b0cae3.dl.dropboxusercontent.com/cd/0/get/DIllR79Fr0Wur0oixHR7hLvqPfKgEUDI2Qmhsdeq0Ehokc8jlM2qDIO_r-0ue6xKZq1-Dv_SV6dVM-0meqobNPQo8OAqaL7SBptJcQl3bEeMfOtd7vDR4R2l5utWBVsVTYiWvIm3dqKxu97Wo3Ocq4-k/file?_download_id=883109752222005619215148952671317648576629681395276088661979963&_log_download_success=1&_notify_domain=www.dropbox.com&dl=1
	# 雪音ルウ　◎
	# https://www.dropbox.com/s/8mjqth3tsiglrws/%E9%9B%AA%E9%9F%B3%E3%83%AB%E3%82%A6.htsvoice?dl=0
	wget https://ucae52319d8cf6ed645c9a1e3823.dl.dropboxusercontent.com/cd/0/get/DInFwSd1mjZ5W3p5mvy66YwLij14lFWtbassEtV9K9G2i7WND60i9IA4LJXmFN1UYC5crTIGFPqqHAGo8irvFTtxke-rBZUZlVNkT4mlt3StW4071THlx4INTxv6n77X6-fElA_ogcEMSuy-oUJCh1bk/file?_download_id=139599352976906950673038769719936968056067150178624379592647736579&_log_download_success=1&_notify_domain=www.dropbox.com&dl=1
	# 雪音ルウ２
	# https://www.dropbox.com/s/z8d9jjvtxcztkgn/%E9%9B%AA%E9%9F%B3%E3%83%AB%E3%82%A6%EF%BC%92.htsvoice?dl=0
	wget https://uc5aebc16a56284aa70f6d548de6.dl.dropboxusercontent.com/cd/0/get/DIlKa8vxv3CV-0p9qMjadEDHQBxSvPAkf814M9jjhEzWdReMX6d28fn6YpqZP1qNZ2VOPnBNqi_DRSj-7Zw1c1xAfOUZQEHpmc5K1a4X7IQfEhD5cY7zgBNv0EKjJyRYQpnBZxtEjmm7X2qL0gK5_9xs/file?_download_id=4462872717467545366292428012003512008275089169137082470293992432&_log_download_success=1&_notify_domain=www.dropbox.com&dl=1
	# ぴよちゃんぼいす（　◎
	# https://www.dropbox.com/s/cn5foldhnamxw58/%E3%81%B4%E3%82%88%E3%81%A1%E3%82%83%E3%82%93%E3%81%BC%E3%81%84%E3%81%99%EF%BC%88.htsvoice?dl=0
	wget https://ucbc8649926fbc7e82601706811f.dl.dropboxusercontent.com/cd/0/get/DIloDufnV1F7-ZhWQkOw24yLgjfxYRomEvFLLzy5V_KkMsGBecgUNHR-PQF_vzS8gati8-Pm5hta_HUL-m3xEakfK3rDPbpdUjc37g8WvPADyd2N9HosuBGYixWuyENgdH-kX3D-XTQ-RudU_jYauLjh/file?_download_id=3746446283500375349794481673836377198915092565637333322475238395156&_log_download_success=1&_notify_domain=www.dropbox.com&dl=1
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
