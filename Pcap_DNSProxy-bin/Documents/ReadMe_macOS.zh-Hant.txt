﻿Pcap_DNSProxy 專案的 GitHub 頁面：
https://github.com/chengr28/Pcap_DNSProxy

Pcap_DNSProxy 專案的 Sourceforge 頁面：
https://sourceforge.net/projects/pcap-dnsproxy


* 更多程式以及配置的詳細情況，參見 ReadMe(...).txt

  
-------------------------------------------------------------------------------


安裝方法（使用已編譯好的二進位可執行檔）：

1.訪問 https://github.com/chengr28/Pcap_DNSProxy/releases 將二進位可執行檔包下載到本地
2.打開下載回來的二進位可執行檔包，將 macOS 目錄解壓到磁片的任意位置
  * 建議將本專案放置在一個獨立的目錄內，不要和其它檔混合
  * 注意：TLS/SSL 協定相關功能的問題，請流覽下文有關 OpenSSL 庫的特別說明
3.編輯 pcap_dnsproxy.service.plist 檔案
  * 清空 <string>/usr/local/opt/pcap_dnsproxy/bin/Pcap_DNSProxy</string> 標籤內的內容，改為 "<string>程式所在的完整路徑/程式名稱</string>"（不含引號）
  * 清空 <string>/usr/local/etc/pcap_dnsproxy</string> 標籤內的內容，改為 "<string>程式所在的完整路徑</string>"（不含引號）
4.打開終端，使用 sudo -i 獲得 root 許可權並進入 macOS 目錄內：
  * 使用 cd 切換回程序所在目錄
  * 使用 chmod 755 macOS_Install.sh 使服務安裝腳本獲得可執行許可權
  * 使用 ./macOS_Install.sh 執行服務安裝腳本
  * 腳本所進行的操作：
    * 设置程序、脚本以及 plist 配置文件的基本读写执行权限
    * 装载并启动守护进程服务
    * 以後每次開機在登錄前守護進程服務都將自動啟動
5.打開 "系統偏好設置" 視窗
  * 進入 "網路" 部分
  * 選中使用的網路介面卡，點擊 "高級" 按鈕
  * 切換到 "DNS" 選項卡，並點擊 "DNS伺服器" 下的 "+" 號
  * 輸入 127.0.0.1(IPv4)/::1(IPv6)
    * 請務必確保只填入這兩個地址，填入其它地址可能會導致系統選擇其它 DNS 服務器繞過程序的代理
  * 按 "好" 再按 "應用" 即可


-------------------------------------------------------------------------------


安裝方法（編譯二進位可執行檔）：

1.準備程式編譯環境
  * Homebrew 可訪問 http://brew.sh 獲取
  * CMake 可訪問 https://cmake.org 或通過 Homebrew 獲取
  * LibPcap 可訪問 http://www.tcpdump.org/#latest-release 獲取
    * 編譯時如果剝離 LibPcap 的依賴則可跳過編譯和安裝下表的依賴庫和工具，具體參見下文的介紹，不建議使用
    * 獲得 root 許可權後使用 ./configure -> make -> make install 即可
  * Libsodium 可訪問 https://github.com/jedisct1/libsodium 獲取
    * 編譯時如果剝離 Libsodium 的依賴則可跳過編譯和安裝下表的依賴庫和工具，具體參見下文的介紹，不建議使用
    * 獲得 root 許可權後進入目錄，運行 ./autogen.sh -> ./configure -> make -> make install 即可
  * OpenSSL 可訪問 https://www.openssl.org 獲取
    * 編譯時如果剝離 OpenSSL 的依賴則可跳過編譯和安裝下表的依賴庫和工具，具體參見下文的介紹，不建議使用
    * 獲得 root 許可權後使用 ./configure darwin64-x86_64-cc -> make -> make install 即可

2.編譯 Pcap_DNSProxy 程式並配置程式屬性
  * 切勿更改腳本的換行格式 (UNIX/LF)
  * 注意：TLS/SSL 協定相關功能的問題，請流覽下文有關 OpenSSL 庫的特別說明
  * 使用終端進入 Source/Auxiliary/Scripts 目錄，使用 chmod 755 CMake_Build.sh 使腳本獲得執行許可權
  * 使用 ./CMake_Build.sh 執行編譯器
    * 腳本所進行的操作：
      * CMake 將編譯並在 Release 目錄生成 Pcap_DNSProxy 程式
      * 從 ExampleConfig 目錄和 Scripts 目錄複寫所需的腳本和預設設定檔到 Release 目錄，並設置基本讀寫可執行許可權
  * 使用 ./CMake_Build.sh 腳本時可提供的參數：
    * 執行時使用 ./CMake_Build.sh --disable-libpcap 可剝離對 LibPcap 的依賴，不建議使用
      * 剝離後編譯時將不需要 LibPcap 庫的支援
      * 剝離後程式將完全失去支援 LibPcap 的功能，且運行時將不會產生任何錯誤提示，慎用！
    * 執行時使用 ./CMake_Build.sh --disable-libsodium 可剝離對 Libsodium 的依賴，不建議使用
      * 剝離後編譯時將不需要 Libsodium 庫的支援
      * 剝離後程式將完全失去支援 DNSCurve(DNSCrypt) 協定的功能，且運行時將不會產生任何錯誤提示，慎用！
    * 執行時使用 ./CMake_Build.sh --disable-tls 可剝離對 OpenSSL 的依賴，不建議使用
      * 剝離後編譯時將不需要 OpenSSL 庫的支援
      * 剝離後程式將完全失去支援 TLS/SSL 協定的功能，且運行時將不會產生任何錯誤提示，慎用！
    * 執行時使用 ./CMake_Build.sh --disable-tls 可剝離對 OpenSSL 的依賴，不建議使用
      * 剝離後編譯時將不需要 OpenSSL 庫的支援
      * 剝離後程式將完全失去支援 TLS/SSL 協定的功能，且運行時將不會產生任何錯誤提示，慎用！
  * 有關 OpenSSL 庫的特別說明：
  

3.按照安裝方法（使用已編譯好的二進位可執行檔）中第3步的操作繼續進行即可


-------------------------------------------------------------------------------


有關 OpenSSL 庫的特別說明：

* 為系統安裝新版本 OpenSSL 庫後，在開啟 TLS/SSL 功能進行編譯時如果出現 undef: OPENSSL... 錯誤：
  * 原因是 macOS 自帶的 OpenSSL 系列版本非常老舊(0.9.8)不支援新版本特性，連結器在連結時使用了系統自帶庫導致錯誤
  * 此時先查看編譯過程的記錄，將 Found OpenSSL 指示的 CMake 找到的 OpenSSL 庫檔目錄記下，並確認所使用的版本
  * 此時可編輯 Pcap_DNSProxy 目錄下的 CMakeLists.txt 檔：
    * 編輯時請務必注意引號的問題，必須使用 ASCII 的標準引號
    * 尋找 find_package(OpenSSL REQUIRED) 語句，並另開一行
    * 在新開的一行填入 set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -L剛才記下的目錄") 優先指定連結器所查找的庫檔
    * 例如 set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -L/usr/local/lib")
    * 保存檔並重新運行 ./CMake_Build.sh 即可
* 預設情況下 OpenSSL 庫沒有附帶任何的可根信任證書庫，首次使用時需要使用者自行添加：
  * 打開公用程式 - 鑰匙串訪問 - 系統根憑證，選中清單中所有的證書以 cert.pem 的 PEM 格式匯出到任何位置
  * 打開終端，使用 sudo -i 獲得 root 許可權並進入剛才匯出位置的目錄內
  * 使用 mv cert.pem 證書目標目錄/cert.pem 移動該系統根憑證儲存檔到 OpenSSL 的證書目錄中
  * 此處的證書目標目錄，位於上文提到的 Found OpenSSL 指示的 CMake 找到的 OpenSSL 庫部署目錄附近，該目錄內應該存在名為 certs 的子目錄
  * 例如 mv cert.pem /usr/local/ssl


-------------------------------------------------------------------------------


重啟服務方法：
1.打開終端，使用 sudo -i 獲得 root 許可權並進入 /Library/LaunchDaemons 目錄內
2.使用 launchctl unload pcap_dnsproxy.service.plist 停止服務，稍等一段時間
3.使用 launchctl load pcap_dnsproxy.service.plist 啟動服務即可


更新程式方法（切勿直接覆蓋，否則可能會造成不可預料的錯誤）：
1.打開終端，使用 sudo -i 獲得 root 許可權並進入 macOS 目錄內
2.使用 ./macOS_Uninstall.sh 執行服務卸載腳本
3.備份所有設定檔，刪除所有 Pcap_DNSProxy 相關檔
4.按照安裝方法重新部署 Pcap_DNSProxy
  * 進行第4步前先將備份的配置檔案還原到 macOS 目錄內
  * Config.conf 檔建議按照備份的設定檔重新設置，如直接覆蓋可能會導致沒有新功能的選項


卸載方法：
1.還原系統網路設定
2.打開終端，使用 sudo -i 獲得 root 許可權並進入 macOS 目錄內
3.使用 ./macOS_Uninstall.sh 執行服務卸載腳本
  * 腳本所進行的操作：停止並卸載守護進程服務，刪除 plist 設定檔
4.刪除所有 Pcap_DNSProxy 相關檔


-------------------------------------------------------------------------------


正常工作查看方法：

1.打開終端
2.輸入 dig www.google.com 並回車
3.運行結果應類似：

   >dig www.google.com
   ; (1 server found)
   ;; global options: +cmd
   ;; Got answer:
   ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: ...
   ;; flags: ...; QUERY: ..., ANSWER: ..., AUTHORITY: ..., ADDITIONAL: ...

   ;; QUESTION SECTION:
   ;www.google.com.            IN    A

   ;; ANSWER SECTION:
   ...

   ;; Query time: ... msec
   ;; SERVER: ::1#53(::1)（IPv6，IPv4 下为 127.0.0.1）
   ;; WHEN: ...
   ;; MSG SIZE  rcvd: ...

4.如非以上結果，請移步 macOS 版 FAQ 文檔中 運行結果分析 一節
