﻿Pcap_DNSProxy 專案的 GitHub 頁面：
https://github.com/chengr28/Pcap_DNSProxy

Pcap_DNSProxy 專案的 Sourceforge 頁面：
https://sourceforge.net/projects/pcap-dnsproxy


-------------------------------------------------------------------------------


安裝方法（需要以管理員身份進行）：

1.訪問 https://www.winpcap.org/install/default.htm 下載並以管理員許可權安裝 WinPcap
  * WinPcap 只需要安裝一次，以前安裝過最新版本或以後更新本工具時請從第2步開始操作
  * 如果 WinPcap 提示已安裝舊版本無法繼續時，參見 FAQ 中 運行結果分析 一節
  * 安裝時自啟動選項對工具的運行沒有影響，本工具直接調用 WinPcap API 不需要經過伺服器程式

2.訪問 https://github.com/chengr28/Pcap_DNSProxy/releases 將二進位可執行檔包下載到本地
  * Windows 版本的 Pcap_DNSProxy 在二進位可執行檔包的 Windows 目錄內，可將整個目錄單獨抽出運行

3.打開下載回來的二進位可執行檔包，將 Windows 目錄解壓到磁片的任意位置
  * 目錄所在位置和程式檔案名可以隨意更改，建議將本專案放置在一個獨立的目錄內
  * 設定檔需要使用固定的檔案名（更多詳細情況參見下文 功能和技術 一節）

4.確定工具目錄的名稱和路徑後進入目錄內，右鍵以管理員身份(Vista 以及更新版本)或直接以管理員登錄按兩下(XP/2003)運行 ServiceControl.bat
  * 輸入 1 並回車，即選擇 "1: Install service" 安裝服務
  * 批次處理會將程式註冊系統服務，並進行 Windows 防火牆測試，每次開機服務都將自動啟動
  * 此時 Windows 系統會詢問是否同意程式訪問網路，請將 "私人網路絡" 以及 "公用網路" 都勾上並確認

5.打開 "網路和共用中心" - "更改配接器設置" 選擇 "本地連接" 或 "無線連接" 或 "寬頻連線"
  * 右擊 "屬性" - "Internet協定(TCP/IP)"(XP/2003) 或 "Internet協定版本4(IPv4)"(Vista 以及更新版本) - "屬性" - 勾選 "使用下面的 DNS 伺服器位址"
  * 在 "首選DNS伺服器" 內填入 "127.0.0.1"（不含引號） 確定保存並退出即可
  * 如果需要使用 IPv6 協定的本機伺服器
    * 右擊 "屬性" - "Internet協定版本6(IPv6)" - "屬性" - 勾選 "使用下面的 DNS 伺服器位址"
    * 在 "首選DNS伺服器" 內填入 "::1"（不含引號） 確定保存並退出即可
  * 請務必確保只填入這兩個地址，填入其它地址可能會導致系統選擇其它 DNS 服務器繞過程序的代理
  * 注意：建議將 "本地連接" 和 "無線連接" 以及 "寬頻連線" 全部修改！

6.特別注意：
  * 如需讓程式的流量通過系統路由級別的代理（例如 VPN 等）進行變數名稱解析，請選擇其中一種方案，配置完成後重啟服務：
    * Direct Request = IPv4
    * Direct Request = IPv6
    * Direct Request = IPv4 + IPv6
  * 設定檔 Hosts 檔 IPFilter 檔和錯誤報表所在的目錄以上文 安裝方法 一節中第4步註冊的服務資訊為准
    * 填寫時一行不要超過 4096位元組/4KB
    * 檔讀取只支援整個文本單一的編碼和換行格式組合，切勿在文字檔中混合所支援的編碼或換行格式！
  * 服務啟動前請先確認沒有其它本地 DNS 伺服器運行或本工具多個拷貝運行中，否則可能會導致監聽衝突無法正常工作
    * 監聽衝突會建置錯誤報告，可留意 Windows Socket 相關的錯誤（參見 FAQ 文檔中 Error.log 詳細錯誤報表 一節）
  * 殺毒軟體/協力廠商防火牆可能會阻止本程式的操作，請將行為全部允許或將本程式加入到白名單中
  * 如果啟動服務時提示 "服務沒有及時回應啟動或者控制請求" 請留意是否有錯誤報表生成，詳細的錯誤資訊參見 FAQ 文檔中 Error.log 詳細錯誤報表 一節
  * 目錄和程式的名稱可以隨意更改，但請務必在進行安裝方法第4步前完成。如果服務註冊後需移動工具目錄的路徑，參見上文 卸載方法 第2步的注意事項
  * Windows XP 如出現 10022 錯誤，需要先啟用系統的 IPv6 支援（以管理員身份運行 cmd 輸入 ipv6 install 並回車，一次性操作），再重新開機服務
  * 本專案僅對最新版本提供技術支援，在新版本發佈後舊版本的支援會即時停止，回饋前請先務必升級到最新版本


-------------------------------------------------------------------------------


重啟服務方法（需要以管理員身份進行）：
1.右鍵以管理員身份(Vista 以及更新版本)或直接以管理員登錄按兩下(XP/2003)運行 ServiceControl.bat
2.輸入 5 並回車，即選擇 "5: Restart service" 立刻重啟服務


更新程式方法（需要以管理員身份進行，切勿直接覆蓋，否則可能會造成不可預料的錯誤）：
1.提前下載好新版本的 Pcap_DNSProxy（亦即 安裝方法 中第2步），更新過程可能會造成功能變數名稱解析短暫中斷
2.備份好所有設定檔 Hosts 檔 IPFilter 檔的自訂內容
3.右鍵以管理員身份(Vista 以及更新版本)或直接以管理員登錄按兩下(XP/2003)運行 ServiceControl.bat
4.輸入 2 並回車，即選擇 "2: Uninstall service" 卸載服務
4.將整個 Pcap_DNSProxy 程式的目錄刪除。注意 Windows 防火牆可能會留有允許程式訪問網路的資訊，卸載服務後又變更了程式的目錄則可能需要使用註冊表清理工具清理
5.將新版本的 Pcap_DNSProxy 解壓到任何位置（亦即 安裝方法 中第3步）
6.將設定檔的自訂內容加回新版本設定檔裡相應的區域內
7.按照 安裝方法 中第4步重新部署 Pcap_DNSProxy


安全模式下的使用方法（需要以管理員身份進行）：
* 程式具備在安全模式下運行的能力，在安全模式下右鍵以管理員身份直接運行程式
* 直接運行模式有主控台視窗，關閉程式時直接關閉主控台視窗即可


卸載方法（需要以管理員身份進行）：
1.按照 安裝方法 中第6步還原 DNS 功能變數名稱伺服器位址配置
2.右鍵以管理員身份(Vista 以及更新版本)或直接以管理員登錄按兩下(XP/2003)運行 ServiceControl.bat
  * 輸入 2 並回車，即選擇 "2: Uninstall service" 卸載服務
  * 注意：Windows 防火牆可能會留有允許程式訪問網路的資訊，故卸載後可能需要使用註冊表清理工具清理
  * 轉移工具目錄路徑不需要卸載服務，先停止服務轉移，轉移完成後重新開機服務即可


-------------------------------------------------------------------------------


正常工作查看方法：

1.打開命令提示符
  * 在開始功能表或直接 Win + R 調出 運行 ，輸入 cmd 並回車
  * 開始功能表 - 程式/所有程式 - 附件 - 命令提示符
2.輸入 nslookup www.google.com 並回車
3.運行結果應類似：

   >nslookup www.google.com
    服务器:  pcap-dnsproxy.server（視設定檔設置的值而定，參見下文 設定檔詳細參數說明 一節）
    Address:  127.0.0.1（視所在網路環境而定，原生 IPv6 為 ::1）

    非权威应答:
    名称:    www.google.com
    Addresses: ……（IP位址或地址清單）


4.如非以上結果，請移步 FAQ 文檔中 運行結果分析 一節


-------------------------------------------------------------------------------


特別使用技巧：
這裡列出部分項目組建議的介紹和使用技巧，供大家參考和使用。關於調整配置，參見下文 設定檔詳細參數說明 一節

* DNS 緩存類型
  * Timer/計時型：可以自訂緩存的時間長度，佇列長度不限
  * Queue/佇列型：可通過 Default TTL 值自訂，同時可自訂緩存佇列長度（亦即限制佇列長度的 Timer/計時型）
  * 強烈建議打開 DNS 緩存功能！
* 本工具配置選項豐富，配置不同的組合會有不同的效果，介紹幾個比較常用的組合：
  * 預設配置：UDP 請求 + 抓包模式
  * Outgoing Protocol = ...TCP：先 TCP 請求失敗後再 UDP 請求 + 抓包模式，對網路資源的佔用比較高
    * 由於 TCP 請求大部分時候不會被投毒污染，此組合的過濾效果比較可靠
  * EDNS Label = 1：開啟 EDNS 請求標籤功能
    * 此功能開啟後將有利於對偽造資料包的過濾能力，此組合的過濾效果比較可靠
  * 將目標伺服器的請求埠改為非標準 DNS 埠：例如 OpenDNS 支援 53 標準埠和 5353 非標準埠的請求
    * 非標準 DNS 埠現階段尚未被干擾，此組合的過濾效果比較可靠
  * Multiple Request Times = xx 時：應用到所有除請求境內伺服器外的所有請求，一個請求多次發送功能
    * 此功能用於對抗網路丟包比較嚴重的情況，對系統和網路資源的佔用都比較高，但在網路環境惡劣的情況下能提高獲得解析結果的可靠性
  * DNSCurve = 1 同時 Encryption = 0：使用 DNSCurve(DNSCrypt) 非加密模式請求功能變數名稱解析
    * 此組合等於使用非標準 DNS 埠請求，功能變數名稱解析可靠性比較高，詳細情況參見上文
  * DNSCurve = 1 同時 Encryption = 1：使用 DNSCurve(DNSCrypt) 加密模式請求功能變數名稱解析
    * 此組合加密傳輸所有功能變數名稱請求，功能變數名稱解析可靠性最高
  * DNSCurve = 1 同時 Encryption = 1 同時 Encryption Only = 1：只使用 DNSCurve(DNSCrypt) 加密模式請求功能變數名稱解析
    * 上文的加密組合並不阻止程式在請求 DNSCurve(DNSCrypt) 加密模式失敗是使用其它協定請求功能變數名稱解析，開啟 Encryption Only = 1 後將只允許使用加密傳輸，安全性和可靠性最高，但功能變數名稱解析成功率可能會下降
* 優化大量請求下程式表現：
  * Pcap Reading Timeout 適當調低這個參數能使抓包模組以更高的頻率抓取資料包，降低延遲
  * Cache Parameter/Default TTL 儘量調高這個參數能增加緩存的存留時間或者佇列長度，提高緩存命中率
  * Thread Pool Maximum Number 適當調高這個參數能可以增大緩衝區最大可容納請求的數量
  * Queue Limits Reset Time 不要開啟，限制請求數量的參數
  * Multiple Request Times 非極其惡劣情況慎用，消耗大量系統資源且會些微提高延遲


-------------------------------------------------------------------------------


功能和技術：

* 批次處理的作用：
  * 運行結束會有運行結果，具體是否成功需要留意螢幕上的提示
  * 1: Install service - 將程式註冊為系統服務，並啟動程式進行 Windows 防火牆測試
  * 2: Uninstall service - 停止並卸載工具的服務
  * 3: Start service - 啟動工具的服務
  * 4: Stop service - 停止工具的服務
  * 5: Restart service - 重啟工具的服務
  * 6: Flush DNS cache in Pcap_DNSProxy - 刷新程序的内部和系統的 DNS 緩存
  * 7: Flush DNS cache in system only - 刷新系統的 DNS 緩存
  * 8: Exit - 退出
* 設定檔支援的檔案名（只會讀取優先順序較高者，優先順序較低者將被直接忽略）：
  * Windows: Config.ini > Config.conf > Config.cfg > Config
  * Linux/macOS: Config.conf > Config.ini > Config.cfg > Config
* 請求功能變數名稱解析優先順序
  * 使用系統 API 函數進行功能變數名稱解析（大部分）：系統 Hosts > Pcap_DNSProxy 的 Hosts 條目（Whitelist/白名單條目 > Hosts/主要 Hosts 清單） > DNS 緩存 > Local Hosts/境內 DNS 解析功能變數名稱清單 > 遠端DNS伺服器
  * 直接從網路介面卡設置內讀取 DNS 伺服器位址進行功能變數名稱解析（小部分）：Pcap_DNSProxy 的 Hosts 配置檔案（Whitelist/白名單條目 > Hosts/主要 Hosts 清單） > DNS緩存 > Local Hosts/境內 DNS 解析功能變數名稱清單 > 遠端 DNS 伺服器
  * 請求遠端 DNS 伺服器的優先順序：Direct Request 模式 > TCP 模式的 DNSCurve 加密/非加密模式（如有） > UDP 模式的 DNSCurve 加密/非加密模式（如有） > TCP 模式普通請求（如有） > UDP 模式普通請求
* 本工具的 DNSCurve(DNSCrypt) 協定是內置的實現，不需要安裝 DNSCrypt 官方的工具！
  * DNSCurve 協定為 Streamlined/精簡類型
  * 自動獲取連接資訊時必須保證系統時間的正確，否則證書驗證時會出錯導致連接資訊獲取失敗！
  * DNSCrypt 官方工具會佔用本地 DNS 埠導致 Pcap_DNSProxy 部署失敗！


-------------------------------------------------------------------------------


程序運行參數說明：
由於部分功能無法通過使用配置文件指定使用，故而使用程序外掛參數進行支持
所有外掛參數也可通過-h 和--help 參數查詢

* -c Path 和 --config-file Path
  啟動時指定設定檔所在的工作目錄
* -h 和 --help
  輸出程式説明資訊到螢幕上
* -v 和 --version
  輸出程式版本號資訊到螢幕上
* --flush-dns
  立即清空所有程式內以及系統內的 DNS 緩存
* --flush-dns Domain
  立即清空功能變數名稱為 Domain 以及所有系統內的 DNS 緩存
* --keypair-generator
  生成 DNSCurve(DNSCrypt) 協定所需使用的金鑰組到 KeyPair.txt
* --lib-version
  輸出程式所用庫的版本號資訊到螢幕上
* --disable-daemon
  關閉守護進程模式 (Linux)
* --first-setup
  進行本地防火牆測試 (Windows)


-------------------------------------------------------------------------------


設定檔詳細參數說明：

有效參數格式為 "選項名稱 = 數值/資料"（不含引號，注意空格和等號的位置）
注意：設定檔只會在工具服務開始時讀取，修改本檔的參數後請重啟服務（參見上文 注意事項 一節中的 重啟服務）

* Base - 基本參數區域
  * Version - 設定檔的版本，用於正確識別設定檔：本參數與程式版本號不相關，切勿修改
  * File Refresh Time - 檔刷新間隔時間：單位為秒，最小為 5
    * 本參數同時決定監視器的時間休眠時間片的細微性，其指的是休眠一段長時間時會根據此細微性啟動並檢查是否需要重新運行特定監視專案，而不需要等到長時間完全過去休眠完全結束後才能重新對此進行監視，此功能對程式的網路狀況適應能力會有提高
  * Large Buffer Size - 大型資料緩衝區的固定長度：單位為位元組，最小為 1500
  * Additional Path - 附加的資料檔案讀取路徑，附加在此處的目錄路徑下的 Hosts 檔和 IPFilter 檔會被依次讀取：請填入目錄的絕對路徑
    * 本參數支援同時讀取多個路徑，各路徑之間請使用 | 隔開
  * Hosts File Name - Hosts 檔的檔案名，附加在此處的 Hosts 檔案名將被依次讀取
    * 本參數支援同時讀取多個檔案名，各路徑之間請使用 | 隔開
  * IPFilter File Name - IPFilter 檔的檔案名，附加在此處的 IPFilter 檔案名將被依次讀取
    * 本參數支援同時讀取多個檔案名，各路徑之間請使用 | 隔開

* Log - 日誌參數區域
  * Print Log Level - 指定日誌輸出級別：留空為 3
    * 0 為關閉日誌輸出功能
    * 1 為輸出重大錯誤
    * 2 為輸出一般錯誤
    * 3 為輸出所有錯誤
  * Log Maximum Size - 日誌檔最大容量：直接填數位時單位為位元組，可加上單位，支援的單位有 KB/MB/GB，可接受範圍為 4KB - 1GB，如果留空則為 8MB
    * 注意：日誌檔到達最大容量後將被直接刪除，然後重新生成新的日誌檔，原來的日誌將無法找回！

* Listen - 監聽參數區域
  * Pcap Capture - 抓包功能總開關，開啟後抓包模組才能正常使用：開啟為 1 /關閉為 0
    * 注意：如果抓包模組被關閉，則會自動開啟 Direct Request 功能，啟用 Direct Request 時對 DNS 投毒污染的防禦能力比較弱
  * Pcap Devices Blacklist - 指定不對含有此名稱的網路介面卡進行抓包，名稱或簡介裡含有此字串的網路介面卡將被直接忽略
    * 本參數支援指定多個名稱，大小寫不敏感，格式為 "網路介面卡的名稱(|網路介面卡的名稱)"（不含引號，括弧內為可選項目）
    * 以抓包模組從系統中獲取的名稱或簡介為准，與其它網路設定程式所顯示的不一定相同
  * Pcap Reading Timeout - 抓包模塊讀取超時時間，數據包只會在等待超時時間後才會被讀取，其餘時間抓包模塊處於休眠狀態：單位為毫秒，最小為 10
    * 讀取超時時間需要平衡需求和資源佔用，時間設置太長會導致域名解析請求響應緩慢導致請求解析超時，太快則會佔用過多系統處理的資源
  * Listen Protocol - 監聽協定，本地監聽的協定：可填入 IPv4 和 IPv6 和 TCP 和 UDP
    * 填入的協定可隨意組合，只填 IPv4 或 IPv6 配合 UDP 或 TCP 時，只監聽指定協定的本地埠
    * 注意：此處的協定指的是向本程式請求功能變數名稱解析時可使用的協定，而程式請求遠端 DNS 伺服器時所使用的協定由 Protocol 參數決定
  * Listen Port - 監聽埠，本地監聽請求的埠：格式為 "埠A(|埠B)"（不含引號，括弧內為可選項目）
    * 埠可填入服務名稱，服務名稱清單參見下文
    * 也可填入 1-65535 之間的埠，如果留空則為 53
    * 填入多個埠時，程式將會同時監聽請求
    * 當相應協定的 Listen Address 生效時，相應協定的本參數將會被自動忽略
  * Operation Mode - 程式的監聽工作模式：分 Server/伺服器模式、Private/私有網路模式 和 Proxy/代理模式
    * Server/伺服器模式：打開 DNS 通用埠（TCP/UDP 同時打開），可為所有其它設備提供代理功能變數名稱解析請求服務
    * Private/私有網路模式：打開 DNS 通用埠（TCP/UDP 同時打開），可為僅限於私有網路位址的設備提供代理功能變數名稱解析請求服務
    * Proxy/代理模式：只打開回環位址的 DNS 埠（TCP/UDP 同時打開），只能為本機提供代理功能變數名稱解析請求服務
    * Custom/自訂模式：打開 DNS 通用埠（TCP/UDP 同時打開），可用的位址由 IPFilter 參數決定
    * 當相應協定的 Listen Address 生效時，相應協定的本參數將會被自動忽略
  * IPFilter Type - IPFilter 參數的類型：分為 Deny 禁止和 Permit 允許，對應 IPFilter 參數應用為黑名單或白名單
  * IPFilter Level - IPFilter 參數的過濾級別，級別越高過濾越嚴格，與 IPFilter 條目相對應：0 為不啟用過濾，如果留空則為 0
  * Accept Type - 禁止或只允許所列 DNS 類型的請求，格式為 "Deny:DNS記錄的名稱或ID(|DNS記錄的名稱或ID)" 或 "Permit:DNS記錄的名稱或ID(|DNS記錄的名稱或ID)"（不含引號，括弧內為可選項目），所有可用的 DNS 類型清單：
    * A/1
    * NS/2
    * MD/3
    * MF/4
    * CNAME/5
    * SOA/6
    * MB/7
    * MG/8
    * MR/9
    * NULL/10
    * WKS/11
    * PTR/12
    * HINFO/13
    * MINFO/14
    * MX/15
    * TXT/16
    * RP/17
    * AFSDB/18
    * X25/19
    * ISDN/20
    * RT/21
    * NSAP/22
    * NSAP_PTR/23
    * SIG/24
    * KEY/25
    * PX/26
    * GPOS/27
    * AAAA/28
    * LOC/29
    * NXT/30
    * EID/31
    * NIMLOC/32
    * SRV/33
    * ATMA/34
    * NAPTR/35
    * KX/36
    * CERT/37
    * A6/38
    * DNAME/39
    * SINK/40
    * OPT/41
    * APL/42
    * DS/43
    * SSHFP/44
    * IPSECKEY/45
    * RRSIG/46
    * NSEC/47
    * DNSKEY/48
    * DHCID/49
    * NSEC3/50
    * NSEC3PARAM/51
    * TLSA/52
    * HIP/55
    * NINFO/56
    * RKEY/57
    * TALINK/58
    * CDS/59
    * CDNSKEY/60
    * OPENPGPKEY/61
    * SPF/99
    * UINFO/100
    * UID/101
    * GID/102
    * UNSPEC/103
    * NID/104
    * L32/105
    * L64/106
    * LP/107
    * EUI48/108
    * EUI64/109
    * ADDRS/248
    * TKEY/249
    * TSIG/250
    * IXFR/251
    * AXFR/252
    * MAILB/253
    * MAILA/254
    * ANY/255
    * URI/256
    * CAA/257
    * TA/32768
    * DLV/32769
    * RESERVED/65535

* DNS - 功能變數名稱解析參數區域
  * Outgoing Protocol - 發送請求所使用的協定：可填入 IPv4 和 IPv6 和 TCP 和 UDP
    * 填入的協定可隨意組合，只填 IPv4 或 IPv6 配合 UDP 或 TCP 時，只使用指定協定向遠端 DNS 伺服器發出請求
    * 同時填入 IPv4 和 IPv6 或直接不填任何網路層協定時，程式將根據網路環境自動選擇所使用的協定
    * 同時填入 TCP 和 UDP 等於只填入 TCP 因為 UDP 為 DNS 的標準網路層協定，所以即使填入 TCP 失敗時也會使用 UDP 請求
    * 填入 Force TCP 可阻止 TCP 請求失敗後使用 UDP 重新嘗試請求
  * Direct Request - 直連模式，啟用後將使用系統的 API 直接請求遠端伺服器而啟用只使用本工具的 Hosts 功能：可填入 IPv4 和 IPv6 和 0，關閉為 0
    * 建議當系統使用全域代理功能時啟用，程式將除境內服務器外的所有請求直接交給系統而不作任何過濾等處理，系統會將請求自動發往遠端伺服器進行解析
    * 填入 IPv4 或 IPv6 時將會啟用對應協定的 Direct Request 功能，填入 IPv4 + IPv6 將會啟用所有協定的功能
  * Cache Type - DNS 緩存的類型：分 Timer/計時型、Queue/佇列型以及它們的混合類型，填入 0 為關閉此功能
    * Timer/計時型：超過指定時間的 DNS 緩存將會被丟棄
    * Queue/佇列型：超過佇列長度時，將刪除最舊的 DNS 緩存
    * 混合類型：超過指定時間時和超過佇列長度時，都會刪除最舊的 DNS 緩存
  * Cache Type - DNS 緩存的類型：分 Timer/計時型、Queue/佇列型以及它們的混合類型，填入 0 為關閉此功能
    * Timer/計時型：超過指定時間的 DNS 緩存將會被丟棄
    * Queue/佇列型：超過佇列長度時，將刪除最舊的 DNS 緩存
    * 混合類型：超過指定時間時、超過佇列長度時以及超過功能變數名稱本身 TTL 時，都會刪除最舊的 DNS 緩存
  * Cache Parameter - DNS 緩存的參數：分 Timer/計時型、Queue/佇列型以及它們的混合類型，填入 0 為關閉此功能
    * Timer/計時型
      * 緩存時間，單位為秒
      * 如果解析結果的平均 TTL 值大於此值，則使用 [TTL + 此值] 為最終的緩存時間
      * 如果解析結果的平均 TTL 值小於等於此值，則使用 [此值] 為最終的緩存時間
      * 如果填 0 則最終的緩存時間為 TTL 值
    * Queue/佇列型：佇列長度
    * 混合類型
      * 佇列長度
      * 此模式下最終的緩存時間由 Default TTL 參數決定
  * Cache Single IPv4 Address Prefix - IPv4 協定單獨 DNS 緩存佇列位址所使用的前置長度：單位為位，最大為 32 填入 0 為關閉此功能
    * 位於私有位址的所有請求不受此參數控制，其擁有一個預設的緩存佇列
  * Cache Single IPv6 Address Prefix - IPv6 協定單獨 DNS 緩存佇列位址所使用的前置長度：單位為位，最大為 128 填入 0 為關閉此功能
    * 位於私有位址的所有請求不受此參數控制，其擁有一個預設的緩存佇列
  * Default TTL - 已緩存 DNS 記錄預設存留時間：單位為秒，留空則為 900秒/15分鐘
    * DNS 緩存的類型為混合類型時，本參數將同時決定最終的緩存時間
      * 如果解析結果的平均 TTL 值大於此值，則使用 [TTL + 此值] 為最終的緩存時間
      * 如果解析結果的平均 TTL 值小於等於此值，則使用 [此值] 為最終的緩存時間
      * 如果填 0 則最終的緩存時間為 TTL 值
  
* Local DNS - 境內功能變數名稱解析參數區域
  * Local Protocol - 發送境內請求所使用的協定：可填入 IPv4 和 IPv6 和 TCP 和 UDP
    * 填入的協定可隨意組合，只填 IPv4 或 IPv6 配合 UDP 或 TCP 時，只使用指定協定向境內 DNS 伺服器發出請求
    * 同時填入 IPv4 和 IPv6 或直接不填任何網路層協定時，程式將根據網路環境自動選擇所使用的協定
    * 同時填入 TCP 和 UDP 等於只填入 TCP 因為 UDP 為 DNS 的標準網路層協定，所以即使填入 TCP 失敗時也會使用 UDP 請求
    * 填入 Force TCP 可阻止 TCP 請求失敗後使用 UDP 重新嘗試請求
  * Local Force Request - 強制使用境內伺服器進行解析：開啟為 1 /關閉為 0
    * 本功能只對已經確定使用境內伺服器的功能變數名稱請求有效
  * Local Hosts - 白名單境內伺服器請求功能：開啟為 1 /關閉為 0
    * 開啟後才能使用自帶或自訂的 Local Hosts 白名單，且不能與 Local Main 和 Local Routing 同時啟用
  * Local Main - 主要境內伺服器請求功能：開啟為 1 /關閉為 0
    * 開啟後所有請求先使用 Local 的伺服器進行解析，遇到遭投毒污染的解析結果時自動再向境外伺服器請求
    * 本功能不能與 Local Hosts 同時啟用
  * Local Routing - Local 路由表識別功能：開啟為 1 /關閉為 0
    * 開啟後使用 Local 請求的解析結果都會被檢查，路由表命中會直接返回結果，命中失敗將丟棄解析結果並向境外伺服器再次發起請求
    * 本功能只能在 Local Main 為啟用狀態時才能啟用

* Addresses - 普通模式位址區域
  * IPv4 Listen Address - IPv4 本地監聽位址：需要輸入一個帶埠格式的位址，留空為不啟用
    * 支援多個位址
    * 填入此值後 IPv4 協定的 Operation Mode 和 Listen Port 參數將被自動忽略
  * IPv4 EDNS Client Subnet Address - IPv4 用戶端子網位址，輸入後將為所有請求添加此位址的 EDNS 子網資訊：需要輸入一個帶前置長度的本機公共網路位址，留空為不啟用
    * 本功能要求啟用 EDNS Label 參數
    * EDNS Client Subnet Relay 參數優先順序比此參數高，啟用後將優先添加 EDNS Client Subnet Relay 參數的 EDNS 子網位址
    * RFC 標準建議 IPv4 位址的首碼長度為 24 位，IPv6 位址為 56 位
  * IPv4 Main DNS Address - IPv4 主要 DNS 伺服器位址：需要輸入一個帶埠格式的位址，留空為不啟用
    * 支援多個位址，注意填入後將強制啟用 Alternate Multiple Request 參數
    * 支援使用服務名稱代替埠號
  * IPv4 Alternate DNS Address - IPv4 備用 DNS 伺服器位址：需要輸入一個帶埠格式的位址，留空為不啟用
    * 支援多個位址，注意填入後將強制啟用 Alternate Multiple Request 參數
    * 支援使用服務名稱代替埠號
  * IPv4 Local Main DNS Address - IPv4 主要境內 DNS 伺服器位址，用於境內功能變數名稱解析：需要輸入一個帶埠格式的位址，留空為不啟用
    * 不支援多個位址，只能填入單個位址
    * 支援使用服務名稱代替埠號
  * IPv4 Local Alternate DNS Address - IPv4 備用境內 DNS 伺服器位址，用於境內功能變數名稱解析：需要輸入一個帶埠格式的位址，留空為不啟用
    * 不支援多個位址，只能填入單個位址
    * 支援使用服務名稱代替埠號
  * IPv6 Listen Address - IPv6 本地監聽位址：需要輸入一個帶埠格式的位址，留空為不啟用
    * 支援多個位址
    * 填入此值後 IPv6 協定的 Operation Mode 和 Listen Port 參數將被自動忽略
  * IPv6 EDNS Client Subnet Address - IPv6 用戶端子網位址，輸入後將為所有請求添加此位址的 EDNS 子網資訊：需要輸入一個帶前置長度的本機公共網路位址，留空為不啟用
    * 本功能要求啟用 EDNS Label 參數
    * EDNS Client Subnet Relay 參數優先順序比此參數高，啟用後將優先添加 EDNS Client Subnet Relay 參數的 EDNS 子網位址
  * IPv6 Main DNS Address - IPv6 主要 DNS 伺服器位址：需要輸入一個帶埠格式的位址，留空為不啟用
    * 支援多個位址，注意填入後將強制啟用 Alternate Multiple Request 參數
    * 支援使用服務名稱代替埠號
  * IPv6 Alternate DNS Address - IPv6 備用 DNS 伺服器位址：需要輸入一個帶埠格式的位址，留空為不啟用
    * 支援多個位址，注意填入後將強制啟用 Alternate Multiple Request 參數
    * 支援使用服務名稱代替埠號
  * IPv6 Local Main DNS Address - IPv6 主要境內 DNS 伺服器位址，用於境內功能變數名稱解析：需要輸入一個帶埠格式的位址，留空為不啟用
    * 不支援多個位址，只能填入單個位址
    * 支援使用服務名稱代替埠號
  * IPv6 Local Alternate DNS Address - IPv6 備用境內 DNS 伺服器位址，用於境內功能變數名稱解析：需要輸入一個帶埠格式的位址，留空為不啟用
    * 不支援多個位址，只能填入單個位址
    * 支援使用服務名稱代替埠號
  * 注意：
    * 帶埠位址的格式：
      * 單個 IPv4 為 "IPv4 位址:埠"（不含引號）
      * 單個 IPv6 為 "[IPv6 位址]:埠"（不含引號）
      * 多個 IPv4 為 "位址A:埠|位址B:埠|位址C:埠"（不含引號）
      * 多個 IPv6 為 "[位址A]:埠|[位址B]:埠|[位址C]:埠"（不含引號）
      * 啟用同時請求多伺服器後將同時向清單中的伺服器請求解析功能變數名稱，並採用最快回應的伺服器的結果，同時請求多伺服器啟用後將自動啟用 Alternate Multiple Request 參數（參見下文）
      * 可填入的伺服器數量為：填入主要/待命伺服器的數量
      * Multiple Request Times = 總請求的數值，此數值不能超過 64
    * 帶前置長度位址的格式：
       * IPv4 為 "IPv4 位址/遮罩長度"（不含引號）
       * IPv6 為 "IPv6 位址/前置長度"（不含引號）
    * 指定埠時可使用服務名稱代替：
      * TCPMUX/1
      * ECHO/7
      * DISCARD/9
      * SYSTAT/11
      * DAYTIME/13
      * NETSTAT/15
      * QOTD/17
      * MSP/18
      * CHARGEN/19
      * FTP_DATA/20
      * FTP_DATA/21
      * SSH/22
      * TELNET/23
      * SMTP/25
      * TIMESERVER/37
      * RAP/38
      * RLP/39
      * NAMESERVER/42
      * WHOIS/43
      * TACACS/49
      * DNS/53
      * XNSAUTH/56
      * MTP/57
      * BOOTPS/67
      * BOOTPC/68
      * TFTP/69
      * RJE/77
      * FINGER/79
      * TTYLINK/87
      * SUPDUP/95
      * SUNRPC/111
      * SQL/118
      * NTP/123
      * EPMAP/135
      * NETBIOS_NS/137
      * NETBIOS_DGM/138
      * NETBIOS_SSN/139
      * IMAP/143
      * BFTP/152
      * SGMP/153
      * SQLSRV/156
      * DMSP/158
      * SNMP/161
      * SNMP_TRAP/162
      * ATRTMP/201
      * ATHBP/202
      * QMTP/209
      * IPX/213
      * IMAP3/220
      * BGMP/246
      * TSP/318
      * IMMP/323
      * ODMR/366
      * RPC2PORTMAP/369
      * CLEARCASE/371
      * HPALARMMGR/383
      * ARNS/384
      * AURP/387
      * LDAP/389
      * UPS/401
      * SLP/427
      * HTTPS/443
      * SNPP/444
      * MICROSOFTDS/445
      * KPASSWD/464
      * TCPNETHASPSRV/475
      * RETROSPECT/497
      * ISAKMP/500
      * BIFFUDP/512
      * WHOSERVER/513
      * SYSLOG/514
      * ROUTERSERVER/520
      * NCP/524
      * COURIER/530
      * COMMERCE/542
      * RTSP/554
      * NNTP/563
      * HTTPRPCEPMAP/593
      * IPP/631
      * LDAPS/636
      * MSDP/639
      * AODV/654
      * FTPSDATA/989
      * FTPS/990
      * NAS/991
      * TELNETS/992

* Values - 擴展參數值區域
  * Thread Pool Base Number - 執行緒池基礎最低保持執行緒數量：最小為 8 設置為 0 則關閉執行緒池的功能
  * Thread Pool Maximum Number - 執行緒池最大執行緒數量以及緩衝區佇列數量限制：最小為 8
    * 啟用 Queue Limits Reset Time 參數時，此參數為單位時間內最多可接受請求的數量
    * 不啟用 Queue Limits Reset Time 參數時為用於接收資料的緩衝區的數量
  * Thread Pool Reset Time - 執行緒池中線程數量超出 Thread Pool Base Number 所指定數量後執行緒將會自動結束前所駐留的時間：單位為秒
  * Queue Limits Reset Time - 資料緩衝區佇列數量限制重置時間：單位為秒，最小為 5 設置為 0 時關閉此功能
  * EDNS Payload Size - EDNS 標籤附帶使用的最大載荷長度：最小為 DNS 協定實現要求的 512(bytes)，留空則使用 EDNS 標籤要求最短的 1220(bytes)
  * IPv4 Packet TTL - 發出 IPv4 資料包頭部 TTL 值：0 為由作業系統自動決定，取值為 1-255 之間
    * 本參數支援指定取值範圍，每次發出資料包時實際使用的值會在此範圍內隨機指定，指定的範圍均為閉區間
  * IPv4 Main DNS TTL - IPv4 主要 DNS 伺服器接受請求的遠端 DNS 伺服器資料包的 TTL 值：0 為自動獲取，取值為 1-255 之間
    * 支援多個 TTL 值，與 IPv4 DNS Address 相對應
  * IPv4 Alternate DNS TTL - IPv4 備用 DNS 伺服器接受請求的遠端 DNS 伺服器資料包的 TTL 值：0 為自動獲取，取值為 1-255 之間
    * 支援多個 TTL 值，與 IPv4 Alternate DNS Address 相對應
  * IPv6 Packet Hop Limits - 發出 IPv6 資料包頭部 HopLimits 值：0 為由作業系統自動決定，取值為 1-255 之間
    * 本參數支援指定取值範圍，每次發出資料包時實際使用的值會在此範圍內隨機指定，指定的範圍均為閉區間
  * IPv6 Main DNS Hop Limits - IPv6 主要 DNS 伺服器接受請求的遠端 DNS 伺服器資料包的 Hop Limits 值：0 為自動獲取，取值為 1-255 之間
    * 支援多個 Hop Limits 值，與 IPv6 DNS Address 相對應
  * IPv6 Alternate DNS Hop Limits - IPv6 備用 DNS 伺服器接受請求的遠端 DNS 伺服器資料包的 Hop Limits 值：0 為自動獲取，取值為 1-255 之間
    * 支援多個 Hop Limits 值，與 IPv6 Alternate DNS Address 相對應
  * Hop Limits Fluctuation - IPv4 TTL/IPv6 Hop Limits 可接受範圍，即 IPv4 TTL/IPv6 Hop Limits 的值 ± 數值的範圍內的資料包均可被接受，用於避免網路環境短暫變化造成解析失敗的問題：取值為 1-255 之間
  * Reliable Once Socket Timeout - 一次性可靠協定埠超時時間：單位為毫秒，最小為 500 可留空，留空時為 3000
    * 一次性是指請求在一次 RTT 往返網路傳輸內即可完成，例如標準 DNS 和 DNSCurve(DNSCrypt) 協定
    * 可靠埠是指 TCP 協定
  * Reliable Serial Socket Timeout - 串列可靠協定埠超時時間：單位為毫秒，最小為 500 可留空，留空時為 1500
    * 串列是指此操作需要多次交互網路傳輸才能完成，例如 SOCKS 和 HTTP CONNECT 協定
    * 可靠埠是指 TCP 協定
  * Unreliable Once Socket Timeout - 一次性不可靠協定埠超時時間：單位為毫秒，最小為 500 可留空，留空時為 2000
    * 一次性是指請求在一次 RTT 往返網路傳輸內即可完成，例如標準 DNS 和 DNSCurve(DNSCrypt) 協定
    * 不可靠埠指 UDP/ICMP/ICMPv6 協定
  * Unreliable Serial Socket Timeout - 串列可靠協定埠超時時間：單位為毫秒，最小為 500 可留空，留空時為 1000
    * 串列是指此操作需要多次交互網路傳輸才能完成，例如 SOCKS 和 HTTP CONNECT 協定
    * 不可靠埠指 UDP/ICMP/ICMPv6 協定
  * TCP Fast Open - TCP 快速打開功能：
    * 本功能的支援情況：
      * Windows 平臺
        * 開啟為 1 /關閉為 0
        * 伺服器端支援，用戶端由於不同類型 I/O 的問題暫時無法進行支援
        * 需要 Windows 10 Version 1607 以及更新版本的支援
      * Linux 平臺：
        * 此參數可同時指定支援 TCP Fast Open 監聽佇列長度，直接填入大於 0 的值即為佇列長度，關閉為 0
        * 伺服器端和用戶端完全支援
        * IPv4 協定需要 Linux Kernel 3.7 以及更新版本的支援，IPv6 協定需要 Linux Kernel 3.16 以及更新版本的內核支援
      * macOS 平臺：
        * 開啟為 1 /關閉為 0
        * 伺服器端和用戶端完全支援
        * 需要 macOS 10.11 Sierra 以及更新版本的支援
    * 警告：切勿在不受支援的版本上開啟本功能，否則可能導致程式無法正常收發資料包！
  * Receive Waiting - 資料包接收等待時間，啟用後程式會嘗試等待一段時間以嘗試接收所有資料包並返回最後到達的資料包：單位為毫秒，留空或設置為 0 表示關閉此功能
    * 本參數與 Pcap Reading Timeout 密切相關，由於抓包模組每隔一段讀取超時時間才會返回給程式一次，當資料包接收等待時間小於讀取超時時間時會導致本參數變得沒有意義，在一些情況下甚至會拖慢功能變數名稱解析的回應速度
    * 本參數啟用後雖然本身只決定抓包模組的接收等待時間，但同時會影響到非抓包模組的請求。 非抓包模組會自動切換為等待超時時間後發回最後收到的回復，預設為接受最先到達的正確的回復，而它們的超時時間由 Reliable Once Socket Timeout/Unreliable Once Socket Timeout 參數決定
    * 一般情況下，越靠後所收到的資料包，其可靠性可能會更高
  * ICMP Test - ICMP/Ping 測試間隔時間：單位為秒，最小為 5 設置為 0 表示關閉此功能
  * Domain Test - DNS 伺服器解析功能變數名稱測試間隔時間：單位為秒，最小為 5 設置為 0 表示關閉此功能
  * Alternate Times - 待命伺服器失敗次數閾值，一定週期內如超出閾值會觸發伺服器切換：單位為次
  * Alternate Time Range - 待命伺服器失敗次數閾值計算週期：單位為秒，最小為 5
  * Alternate Reset Time - 待命伺服器重置切換時間，切換產生後經過此事件會切換回主要伺服器：單位為秒，最小為 5
  * Multiple Request Times - 一次向同一個遠端伺服器發送並行功能變數名稱解析請求：0 和 1 時為收到一個請求時請求 1 次，2 時為收到一個請求時請求 2 次，3 時為收到一個請求時請求 3 次...... 以此類推
    * 此值將應用到 Local Hosts 外對所有遠端伺服器所有協定的請求，因此可能會對系統以及遠端伺服器造成壓力，請謹慎考慮開啟的風險！
    * 可填入的最大數值為：填入主要/待命伺服器的數量
  * Multiple Request Times = 總請求的數值，此數值不能超過 64
    * 一般除非丟包非常嚴重干擾正常使用否則不建議開啟，開啟也不建議將值設得太大。 實際使用可以每次+1後重啟服務測試效果，找到最合適的值
  * 注意：
    * IPv4 協定使用多 TTL 值的格式為 "TTL(A)|TTL(B)|TTL(C)"（不含引號），也可直接預設（即只填一個 0 不使用此格式）則所有 TTL 都將由程式自動獲取
    * 使用同時請求多伺服器格式為 "Hop Limits(A)|Hop Limits(B)|Hop Limits(C)"（不含引號），也可直接預設（即只填一個 0 不使用此格式）則所有 Hop Limits 都將由程式自動獲取
    * 使用多 TTL/Hop Limits 值所對應的順序與對應位址參數中的位址順序相同

* Switches - 控制開關區域
  * Domain Case Conversion - 隨機轉換功能變數名稱請求大小寫：開啟為 1 /關閉為 0
  * Compression Pointer Mutation - 隨機添加壓縮指標：可填入 1 (+ 2 + 3)，關閉為 0 
    * 隨機添加壓縮指標有3種不同的類型，對應 1 和 2 和 3
    * 可單獨使用其中一個，即只填一個數位，或填入多個，中間使用 + 號連接
    * 填入多個時，當實際需要使用隨機添加壓縮指標時將隨機使用其中的一種，每個請求都有可能不相同
  * EDNS Label - EDNS 標籤支援，開啟後將為請求添加 EDNS 標籤：全部開啟為 1 /關閉為 0
    * 本參數可只指定部分的請求過程使用 EDNS 標籤，分為指定模式和排除模式：
    * 指定清單模式，列出的過程才啟用此功能：EDNS Label = Local + SOCKS Proxy + HTTP CONNECT Proxy + Direct Request + DNSCurve + TCP + UDP
    * 排除清單模式，列出的過程不啟用此功能：EDNS Label = 1 - Local - SOCKS Proxy - HTTP CONNECT Proxy - Direct Request - DNSCurve - TCP - UDP
  * EDNS Client Subnet Relay - EDNS 用戶端子網轉發功能，開啟後將為來自非私有網路位址的所有請求添加其請求時所使用的位址的 EDNS 子網位址：開啟為 1 /關閉為 0
    * 本功能要求啟用 EDNS Label 參數
    * 本參數優先順序比 IPv4/IPv6 EDNS Client Subnet Address 參數高，故需要添加 EDNS 子網位址時將優先添加本參數的位址
  * DNSSEC Request - DNSSEC 請求，開啟後將嘗試為所有請求添加 DNSSEC 請求：開啟為 1 /關閉為 0
    * 本功能要求啟用 EDNS Label 參數
    * 此功能不具備任何驗證 DNSSEC 記錄的能力，單獨開啟理論上並不能避免 DNS 投毒污染的問題
  * DNSSEC Validation - DNSSEC 記錄驗證功能，將檢查所有帶有 DNSSEC 記錄的功能變數名稱解析，驗證失敗將被丟棄：開啟為 1 /關閉為 0
    * 本功能要求啟用 EDNS Label 和 DNSSEC Request 參數
    * 此功能不具備完整的 DNSSEC 記錄檢驗的能力，單獨開啟理論上不能避免 DNS 投毒污染的問題
    * 本功能不檢查不存在 DNSSEC 記錄的功能變數名稱解析
  * DNSSEC Force Validation - 強制 DNSSEC 記錄驗證功能，將丟棄所有沒有 DNSSEC 記錄的功能變數名稱解析：開啟為 1 /關閉為 0
    * 本功能要求啟用 EDNS Label、DNSSEC Request 和 DNSSEC Validation 參數
    * 此功能不具備完整的 DNSSEC 記錄檢驗的能力，單獨開啟理論上不能避免 DNS 投毒污染的問題
    * 警告：由於現時已經部署 DNSSEC 的功能變數名稱數量極少，未部署 DNSSEC 的功能變數名稱解析沒有 DNSSEC 記錄，這將導致所有未部署 DNSSEC 的功能變數名稱解析失敗，現階段切勿開啟本功能！
  * Alternate Multiple Request - 待命伺服器同時請求參數，開啟後將同時請求主要伺服器和待命伺服器並採用最快回應的伺服器的結果：開啟為 1 /關閉為 0
    * 同時請求多伺服器啟用後本參數將強制啟用，將同時請求所有存在於清單中的伺服器，並採用最快回應的伺服器的結果
  * IPv4 Do Not Fragment - IPv4 資料包頭部 Do Not Fragment 標誌：開啟為 1 /關閉為 0
    * 目前本功能不支援 macOS 平臺，此平臺將直接忽略此參數
  * IPv4 Data Filter - IPv4 資料包頭檢測：開啟為 1 /關閉為 0
  * TCP Data Filter - TCP 資料包頭檢測：開啟為 1 /關閉為 0
  * DNS Data Filter - DNS 資料包頭檢測：開啟為 1 /關閉為 0
  * Blacklist Filter - 解析結果黑名單過濾：開啟為 1 /關閉為 0
  * Strict Resource Record TTL Filter - 嚴格的資源記錄存留時間過濾，標準要求同一名稱和類型的資源記錄必須具有相同的存留時間：開啟為 1/關閉為 0

* Data - 資料區域
  * ICMP ID - ICMP/Ping 資料包頭部 ID 的值：格式為 0x**** 的十六進位字元，如果留空則獲取執行緒的 ID 作為請求用 ID
  * ICMP Sequence - ICMP/Ping 資料包頭部 Sequence/序號 的值：格式為 0x**** 的十六進位字元，如果留空則為 0x0001
  * Domain Test Data - DNS 伺服器解析功能變數名稱測試：請輸入正確、確認不會被投毒污染的功能變數名稱並且不要超過 253 位元組 ASCII 資料，留空則會隨機生成一個功能變數名稱進行測試
  * Domain Test ID - DNS 資料包頭部 ID 的值：格式為 0x**** 的十六進位字元，如果留空則為 0x0001
  * ICMP PaddingData - ICMP 附加資料，Ping 程式發送請求時為補足資料使其達到 Ethernet 類型網路最低的可發送長度時添加的資料：長度介乎于 18位元組 - 1500位元組 ASCII 資料之間，留空則使用 Microsoft Windows Ping 程式的 ICMP 附加資料
  * Local Machine Server Name - 本地 DNS 伺服器名稱：請輸入正確的功能變數名稱並且不要超過 253 位元組 ASCII 資料，留空則使用 pcap-dnsproxy.server 作為本機伺服器名稱

* Proxy - 代理區域
  * SOCKS Proxy - SOCKS 協定總開關，控制所有和 SOCKS 協定有關的選項：開啟為 1 /關閉為 0
  * SOCKS Version - SOCKS 協定所使用的版本：可填入 4 或 4A 或 5
    * SOCKS 版本 4 不支援 IPv6 位址以及功能變數名稱的目標伺服器，以及不支援 UDP 轉發功能
    * SOCKS 版本 4a 不支援 IPv6 位址的目標伺服器，以及不支援 UDP 轉發功能
  * SOCKS Protocol - 發送 SOCKS 協定請求所使用的協定：可填入 IPv4 和 IPv6 和 TCP 和 UDP
    * 填入的協定可隨意組合，只填 IPv4 或 IPv6 配合 UDP 或 TCP 時，只使用指定協定向 SOCKS 伺服器發出請求
    * 同時填入 IPv4 和 IPv6 或直接不填任何網路層協定時，程式將根據網路環境自動選擇所使用的協定
    * 同時填入 TCP 和 UDP 等於只填入 UDP 因為 TCP 為 SOCKS 最先支援以及最普遍支援的標準網路層協定，所以即使填入 UDP 請求失敗時也會使用 TCP 請求
    * 填入 Force UDP 可阻止 UDP 請求失敗後使用 TCP 重新嘗試請求
  * SOCKS UDP No Handshake - SOCKS UDP 不握手模式，開啟後將不進行 TCP 握手直接發送 UDP 轉發請求：開啟為 1 /關閉為 0
    * SOCKS 協定的標準流程使用 UDP 轉發功能前必須使用 TCP 連接交換握手資訊，否則 SOCKS 伺服器將直接丟棄轉發請求
    * 部分 SOCKS 本地代理可以直接進行 UDP 轉發而不需要使用 TCP 連接交換握手資訊，啟用前請務必確認 SOCKS 伺服器的支援情況
  * SOCKS Proxy Only - 只使用 SOCKS 協定代理模式，所有請求將只通過 SOCKS 協定進行：開啟為 1 /關閉為 0
  * SOCKS IPv4 Address - SOCKS 協定 IPv4 主要 SOCKS 伺服器位址：需要輸入一個帶埠格式的位址
    * 不支援多個位址，只能填入單個位址
    * 支援使用服務名稱代替埠號
  * SOCKS IPv6 Address - SOCKS 協定 IPv6 主要 SOCKS 伺服器位址：需要輸入一個帶埠格式的位址
    * 不支援多個位址，只能填入單個位址
    * 支援使用服務名稱代替埠號
  * SOCKS Target Server - SOCKS 最終目標伺服器：需要輸入一個帶埠格式的 IPv4/IPv6 位址或功能變數名稱
    * 不支援多個位址或功能變數名稱，只能填入單個位址或功能變數名稱
    * 支援使用服務名稱代替埠號
  * SOCKS Username - 連接 SOCKS 伺服器時所使用的使用者名：最長可填入 255 個字元，留空為不啟用
  * SOCKS Password - 連接 SOCKS 伺服器時所使用的密碼：最長可填入 255 個字元，留空為不啟用
  * HTTP CONNECT Proxy - HTTP CONNECT 協定總開關，控制所有和 HTTP CONNECT 協定有關的選項：開啟為 1 /關閉為 0
  * HTTP CONNECT Protocol - 發送 HTTP CONNECT 協定請求所使用的協定：可填入 IPv4 和 IPv6
    * 填入的協定可隨意組合，只填 IPv4 或 IPv6 時，只使用指定協定向 HTTP CONNECT 伺服器發出請求
    * 同時填入 IPv4 和 IPv6 或直接不填任何網路層協定時，程式將根據網路環境自動選擇所使用的協定
  * HTTP CONNECT Proxy Only - 只使用 HTTP CONNECT 協定代理模式，所有請求將只通過 HTTP CONNECT 協定進行：開啟為 1 /關閉為 0
  * HTTP CONNECT IPv4 Address - HTTP CONNECT 協定 IPv4 主要 HTTP CONNECT 伺服器位址：需要輸入一個帶埠格式的位址
    * 不支援多個位址，只能填入單個位址
    * 支援使用服務名稱代替埠號
  * HTTP CONNECT IPv6 Address - HTTP CONNECT 協定 IPv6 主要 HTTP CONNECT 伺服器位址：需要輸入一個帶埠格式的位址
    * 不支援多個位址，只能填入單個位址
    * 支援使用服務名稱代替埠號
  * HTTP CONNECT Target Server - HTTP CONNECT 最終目標伺服器：需要輸入一個帶埠格式的 IPv4/IPv6 位址或功能變數名稱
    * 不支援多個位址或功能變數名稱，只能填入單個位址或功能變數名稱
    * 支援使用服務名稱代替埠號
  * HTTP CONNECT TLS Handshake - HTTP CONNECT 協定 TLS 握手和加密傳輸總開關：開啟為 1 /關閉為 0
  * HTTP CONNECT TLS Version - HTTP CONNECT 協定啟用 TLS 握手和加密傳輸時所指定使用的版本：設置為 0 則自動選擇
    * 現階段可填入 1.0 或 1.1 或 1.2
    * Windows XP/2003 和 Windows Vista 不支援高於 1.0 的版本
    * OpenSSL 1.0.0 以及之前的版本不支援高於 1.0 的版本
  * HTTP CONNECT TLS Validation - HTTP CONNECT 協定啟用 TLS 握手時伺服器憑證鏈檢查：開啟為 1 /關閉為 0
    * 警告：關閉此功能將可能導致加密連接被中間人攻擊，強烈建議開啟！
    * 警告：OpenSSL 1.0.2 之前的版本不支援檢查伺服器憑證的功能變數名稱匹配情況，敬請留意！
  * HTTP CONNECT TLS Server Name Indication - HTTP CONNECT 協定用於指定 TLS 握手時所指定使用的功能變數名稱伺服器：請輸入正確的功能變數名稱並且不要超過 253 位元組 ASCII 資料，留空則不啟用此功能
  * HTTP CONNECT TLS ALPN - HTTP CONNECT 協定 TLS 握手時是否啟用 Application-Layer Protocol Negotiation/ALPN 擴展功能：開啟為 1 /關閉為 0
    * Windows 8 以及之前的版本不支援本功能
    * OpenSSL 1.0.1 以及之前的版本不支援本功能
    * 警告：切勿在不受支援的版本上開啟本功能，否則可能導致程式無法正常收發資料包！
  * HTTP CONNECT Version - HTTP CONNECT 協定所使用的版本：設置為 0 則自動選擇
    * 現階段可填入 1.1 或 2
    * 注意：根據標準的要求，使用 HTTP/2 同時開啟 HTTP CONNECT TLS Handshake 時必須填入 HTTP CONNECT TLS Server Name Indication 和啟用 HTTP CONNECT TLS ALPN 參數
    * 注意：根據標準的要求，使用 HTTP/2 同時開啟 HTTP CONNECT TLS Handshake 時必須指定大於等於 1.2 的 HTTP CONNECT TLS Version
    * 警告：本功能不支援從 1.1 升級到 2 的過渡方案，使用 HTTP/2 時如果伺服器不支援會直接導致請求失敗！
  * HTTP CONNECT Header Field - 附帶在 HTTP CONNECT Header 的資訊：所輸入的資訊將被直接添加到 HTTP CONNECT Header
    * 本參數可重複多次出現，所有有內容的 HTTP CONNECT Header 的資訊都將被記錄並在請求時按順序添加到 HTTP CONNECT Header 中
    * 注意：根據標準的要求，本區域不能填入任何以下欄位：
      * Connection
      * Content-Length
      * Proxy-Connection
      * Transfer-Encoding
      * Upgrade
  * HTTP CONNECT Proxy Authorization - 連接 HTTP CONNECT Proxy 伺服器時所使用的認證資訊：需要輸入 "使用者名:密碼"（不含引號），留空為不啟用
    * 只支援 Base 方式的認證

* DNSCurve - DNSCurve 協定基本參數區域
  * DNSCurve - DNSCurve 協定總開關，控制所有和 DNSCurve 協定有關的選項：開啟為 1 /關閉為 0
  * DNSCurve Protocol - DNSCurve 發送請求所使用的協定：可填入 IPv4 和 IPv6 和 TCP 和 UDP
    * 填入的協定可隨意組合，只填 IPv4 或 IPv6 配合 UDP 或 TCP 時，只使用指定協定向遠端 DNS 伺服器發出請求
    * 同時填入 IPv4 和 IPv6 或直接不填任何網路層協定時，程式將根據網路環境自動選擇所使用的協定
    * 同時填入 TCP 和 UDP 等於只填入 TCP 因為 UDP 為 DNS 的標準網路層協定，所以即使填入 TCP 失敗時也會使用 UDP 請求
    * 填入 Force TCP 可阻止 TCP 請求失敗後使用 UDP 重新嘗試請求
  * DNSCurve Payload Size - DNSCurve 標籤附帶使用的最大載荷長度，同時亦為發送請求的總長度，並決定請求的填充長度：單位為位元組
    * 最小為 DNS 協定實現要求的 512，留空則為 512
    * 最大為 1500 減去 DNSCurve 頭長度，建議不要超過 1220
    * DNSCurve 協定要求此值必須為 64 的倍數
  * DNSCurve Reliable Socket Timeout - 可靠 DNSCurve 協定埠超時時間，可靠埠指 TCP 協定：單位為毫秒，最小為 500，可留空，留空時為 3000
  * DNSCurve Unreliable Socket Timeout - 不可靠 DNSCurve 協定埠超時時間，不可靠埠指 UDP 協定：單位為毫秒，最小為 500，可留空，留空時為 2000
  * DNSCurve Encryption - 啟用加密，DNSCurve 協定支援加密和非加密模式：開啟為 1 /關閉為 0
  * DNSCurve Encryption Only - 只使用加密模式，所有請求將只通過 DNCurve 加密模式進行：開啟為 1 /關閉為 0
    * 注意：使用 "只使用加密模式" 時必須提供伺服器的魔數和指紋用於請求和接收
  * DNSCurve Client Ephemeral Key - 一次性用戶端金鑰組模式，每次請求解析均使用隨機生成的一次性用戶端金鑰組，提供前向安全性：開啟為 1 /關閉為 0
  * DNSCurve Key Recheck Time - DNSCurve 協定 DNS 伺服器連接資訊檢查間隔：單位為秒，最小為 10

* DNSCurve Database - DNSCurve 協定資料庫區域
  * DNSCurve Database Name - DNSCurve 協定資料庫的檔案名
    * 不支援多個檔案名
  * DNSCurve Database IPv4 Main DNS - DNSCurve 協定 IPv4 主要 DNS 伺服器位址：需要填入 DNSCurve 協定資料庫中對應伺服器的 Name 欄位
  * DNSCurve Database IPv4 Alternate DNS - DNSCurve 協定 IPv4 備用 DNS 伺服器位址：需要填入 DNSCurve 協定資料庫中對應伺服器的 Name 欄位
  * DNSCurve Database IPv6 Main DNS - DNSCurve 協定 IPv6 主要 DNS 伺服器位址：需要填入 DNSCurve 協定資料庫中對應伺服器的 Name 欄位
  * DNSCurve Database IPv6 Alternate DNS - DNSCurve 協定 IPv6 備用 DNS 伺服器位址：需要填入 DNSCurve 協定資料庫中對應伺服器的 Name 欄位
  * 注意：
    * 啟用此部分功能後會覆蓋設定檔中所設置 DNSCurve 伺服器的相關配置！
    * 當在多個附加路徑存在多個 DNSCurve 協定資料庫中存在同名 Name 欄位時，以最先被讀取的為准

* DNSCurve Addresses - DNSCurve 協定位址區域
  * DNSCurve IPv4 Main DNS Address - DNSCurve 協定 IPv4 主要 DNS 伺服器位址：需要輸入一個帶埠格式的位址
    * 不支援多個位址，只能填入單個位址
    * 支援使用服務名稱代替埠號
  * DNSCurve IPv4 Alternate DNS Address - DNSCurve 協定 IPv4 備用 DNS 伺服器位址：需要輸入一個帶埠格式的位址
    * 不支援多個位址，只能填入單個位址
    * 支援使用服務名稱代替埠號
  * DNSCurve IPv6 Main DNS Address - DNSCurve 協定 IPv6 主要 DNS 伺服器位址：需要輸入一個帶埠格式的位址
    * 不支援多個位址，只能填入單個位址
    * 支援使用服務名稱代替埠號
  * DNSCurve IPv6 Alternate DNS Address - DNSCurve 協定 IPv6 備用 DNS 伺服器位址：需要輸入一個帶埠格式的位址
    * 不支援多個位址，只能填入單個位址
    * 支援使用服務名稱代替埠號
  * DNSCurve IPv4 Main Provider Name - DNSCurve 協定 IPv4 主要 DNS 伺服器提供者，請輸入正確的功能變數名稱並且不要超過 253 位元組 ASCII 資料
  * DNSCurve IPv4 Alternate Provider Name - DNSCurve 協定 IPv4 備用 DNS 伺服器提供者，請輸入正確的功能變數名稱並且不要超過 253 位元組 ASCII 資料
  * DNSCurve IPv6 Main Provider Name - DNSCurve 協定 IPv6 主要 DNS 伺服器提供者，請輸入正確的功能變數名稱並且不要超過 253 位元組 ASCII 資料
  * DNSCurve IPv6 Alternate Provider Name - DNSCurve 協定 IPv6 備用 DNS 伺服器提供者，請輸入正確的功能變數名稱並且不要超過 253 位元組 ASCII 資料
  * 注意：
    * 自動獲取 DNSCurve 伺服器連接資訊時必須輸入提供者的功能變數名稱，不能留空
    * 更多支援 DNSCurve(DNSCrypt) 的伺服器請移步 https://github.com/jedisct1/dnscrypt-proxy/blob/master/dnscrypt-resolvers.csv

* DNSCurve Keys - DNSCurve 協定金鑰區域
  * DNSCurve Client Public Key - 自訂用戶端公開金鑰：可使用 KeyPairGenerator 生成，留空則每次啟動時自動生成
  * DNSCurve Client Secret Key - 自訂用戶端私密金鑰：可使用 KeyPairGenerator 生成，留空則每次啟動時自動生成
  * DNSCurve IPv4 Main DNS Public Key - DNSCurve 協定 IPv4 主要 DNS 伺服器驗證用公開金鑰
  * DNSCurve IPv4 Alternate DNS Public Key - DNSCurve 協定 IPv4 備用 DNS 伺服器驗證用公開金鑰
  * DNSCurve IPv6 Main DNS Public Key - DNSCurve 協定 IPv6 主要 DNS 伺服器驗證用公開金鑰
  * DNSCurve IPv6 Alternate DNS Public Key - DNSCurve 協定 IPv6 備用 DNS 伺服器驗證用公開金鑰
  * DNSCurve IPv4 Main DNS Fingerprint - DNSCurve 協定 IPv4 主要 DNS 伺服器傳輸用指紋，留空則自動通過伺服器提供者和公開金鑰獲取
  * DNSCurve IPv4 Alternate DNS Fingerprint - DNSCurve 協定 IPv4 備用 DNS 伺服器傳輸用指紋，留空則自動通過伺服器提供者和公開金鑰獲取
  * DNSCurve IPv6 Main DNS Fingerprint - DNSCurve 協定 IPv6 備用 DNS 伺服器傳輸用指紋，留空則自動通過伺服器提供者和公開金鑰獲取
  * DNSCurve IPv6 Alternate DNS Fingerprint - DNSCurve 協定 IPv6 備用 DNS 伺服器傳輸用指紋，留空則自動通過伺服器提供者和公開金鑰獲取
  * 注意：
    * 公開網站上的 "公開金鑰" 普遍為驗證用的公開金鑰，用於驗證與伺服器通訊時使用的指紋，兩者為不同性質的公開金鑰不可混用！

* DNSCurve Magic Number - DNSCurve 協定魔數區域
  * DNSCurve IPv4 Main Receive Magic Number - DNSCurve 協定 IPv4 主要 DNS 伺服器接收魔數：長度必須為 8 位元組（ASCII）或 18 位元組（十六進位），留空則使用程式內置的接收魔數
  * DNSCurve IPv4 Alternate Receive Magic Number - DNSCurve 協定 IPv4 備用 DNS 伺服器接收魔數：長度必須為 8 位元組（ASCII）或 18 位元組（十六進位），留空則使用程式內置的接收魔數
  * DNSCurve IPv6 Main Receive Magic Number - DNSCurve 協定 IPv6 主要 DNS 伺服器接收魔數：長度必須為 8 位元組（ASCII）或 18 位元組（十六進位），留空則使用程式內置的接收魔數
  * DNSCurve IPv6 Alternate Receive Magic Number - DNSCurve 協定 IPv6 備用 DNS 伺服器接收魔數：長度必須為 8 位元組（ASCII）或 18 位元組（十六進位），留空則使用程式內置的接收魔數
  * DNSCurve IPv4 Main DNS Magic Number - DNSCurve 協定 IPv4 主要 DNS 伺服器發送魔數：長度必須為 8 位元組（ASCII）或 18 位元組（十六進位），留空則自動獲取
  * DNSCurve IPv4 Alternate DNS Magic Number - DNSCurve 協定 IPv4 備用 DNS 伺服器發送魔數：長度必須為 8 位元組（ASCII）或 18 位元組（十六進位），留空則自動獲取
  * DNSCurve IPv6 Main DNS Magic Number - 協定 IPv6 主要 DNS 伺服器發送魔數：長度必須為 8 位元組（ASCII）或 18 位元組（十六進位），留空則自動獲取
  * DNSCurve IPv6 Alternate DNS Magic Number - DNSCurve 協定 IPv6 備用 DNS 伺服器發送魔數：長度必須為 8 位元組（ASCII）或 18 位元組（十六進位），留空則自動獲取
  * 注意：Magic Number 參數均同時支援使用 ASCII 字元或十六進位字串進行指定
    * 直接填入可列印 ASCII 字串即可
    * 十六進位字串需要在字串前面加上 0x（大小寫敏感）


-------------------------------------------------------------------------------


Hosts 檔案格式說明：

Hosts 設定檔分為多個提供不同功能的區域
* 區域通過標籤識別，修改時切勿將其刪除
* 一條條目的總長度切勿超過 4096位元組/4KB
* 需要注釋請在條目開頭添加 #/井號
* 優先順序別自上而下遞減，條目越前優先順序越高
* 平行 Hosts 條目支援數量由請求功能變數名稱以及 EDNS Payload 長度決定，不要超過75個 A 記錄或43個 AAAA 記錄


* Whitelist - 白名單條目
  * 此類型的條目列出的符合要求的功能變數名稱會直接繞過 Hosts 不會使用 Hosts 功能
  * 有效參數格式為 "NULL 正則運算式"（不含引號）
  * 注意優先順序的問題，例如有一片含白名單條目的區域：

    NULL .*\.test\.test
    127.0.0.1|127.0.0.2|127.0.0.3 .*\.test

  * 雖然 .*\.test 包含了 .*\.test\.test 但由於優先順序別自上而下遞減，故先命中 .*\.test\.test 並返回使用遠端伺服器解析
  * 從而繞過了下面的條目，不使用 Hosts 的功能


* Whitelist Extended - 白名單條目擴展功能
  * 此類型的條目還支援對符合規則的特定類型功能變數名稱請求直接繞過 Hosts 不會使用 Hosts 功能
  * 有效參數格式為 "NULL:DNS類型(|DNS類型) 正則運算式"（不含引號，括弧內為可選項目）
  * 只允許特定類型功能變數名稱請求，有效參數格式為 "NULL(Permit):DNS類型(|DNS類型) 正則運算式"（不含引號）

    NULL:A|AAAA .*\.test\.test
    NULL(Deny):NS|SOA .*\.test

  * 第一條即直接跳過匹配規則的 A 記錄和 AAAA 記錄的功能變數名稱請求，其它類型的請求則被匹配規則
  * 而第二條則只匹配規則的 NS 記錄和 SOA 記錄的功能變數名稱請求，其它類型的請求則被直接跳過


* Banned - 黑名單條目
  * 此類型的條目列出的符合要求的功能變數名稱會直接返回功能變數名稱不存在的功能，避免重定向導致的超時問題
  * 有效參數格式為 "BANNED 正則運算式"（不含引號）
  * 注意優先順序的問題，例如有一片含黑名單條目的區域：

    Banned .*\.test\.test
    127.0.0.1|127.0.0.2|127.0.0.3 .*\.test

  * 雖然 .*\.test 包含了 .*\.test\.test 但由於優先順序別自上而下遞減，故先命中 .*\.test\.test 並直接返回功能變數名稱不存在
  * 從而繞過了下面的條目，達到遮罩功能變數名稱的目的


* Banned Extended - 黑名單條目擴展功能
  * 此類型的條目還支援對符合規則的特定類型功能變數名稱請求進行遮罩或放行
  * 有效參數格式為 "BANNED:DNS類型(|DNS類型) 正則運算式"（不含引號，括弧內為可選項目）
  * 只允許特定類型功能變數名稱請求，有效參數格式為 "BANNED(Permit):DNS類型(|DNS類型) 正則運算式"（不含引號，括弧內為可選項目）

    BANNED:A|AAAA .*\.test\.test
    BANNED(Permit):NS|SOA .*\.test

  * 第一条即屏蔽匹配规则的 A 记录和 AAAA 记录的域名请求，其它类型的请求则被放行
  * 而第二条则只放行匹配规则的 NS 记录和 SOA 记录的域名请求，其它类型的请求则被屏蔽


* Hosts/CNAME Hosts - 主要 Hosts 清單/CNAME Hosts 清單
  * 主要 Hosts 清單和 CNAME Hosts 清單主要區別是作用範圍不相同，前者的作用範圍為接收到的功能變數名稱解析請求，後者的作用範圍為接收到的功能變數名稱解析結果
    * 有效參數格式為 "位址(|位址A|位址B) 功能變數名稱的正則運算式"（不含引號，括弧內為可選項目，注意間隔所在的位置）
  * 根據來源位址 Hosts 清單，根據接收到的功能變數名稱解析請求的來源位址判斷是否需要進行 Hosts
    * 有效參數格式為 "來源位址/前置長度(|來源位址A/前置長度A|來源位址B/前置長度B)->位址(|位址A|位址B) 功能變數名稱的正則運算式"（不含引號，括弧內為可選項目，注意間隔所在的位置）
  * 位址與正則運算式之間的間隔字元可為 Space/半形空格 或者 HT/水準定位符號，間隔長度不限，但切勿輸入全形空格
  * 一條條目只能接受一種網址類別型（IPv4/IPv6），如有同一個功能變數名稱需要同時進行 IPv4/IPv6 的 Hosts，請分為兩個條目輸入
  * 平行位址原理為一次返回多個記錄，而具體使用哪個記錄則由要求者決定，一般為第1個
  * 例如有一個 [Hosts] 下有效資料區域：

    127.0.0.1|127.0.0.2|127.0.0.3 .*\.test\.test
    127.0.0.4|127.0.0.5|127.0.0.6 .*\.test
    ::1|::2|::3 .*\.test\.test
    ::4|::5|::6 .*\.test

  * 雖然 .*\.test 包含了 .*\.test\.test 但由於優先順序別自上而下遞減，故先命中 .*\.test\.test 並直接返回，不會再進行其它檢查
    * 請求解析 xxx.test 的 A 記錄（IPv4）會返回 127.0.0.4、127.0.0.5 和 127.0.0.6
    * 請求解析 xxx.test 的 AAAA 記錄（IPv6）會返回 ::4、::5 和 ::6
    * 請求解析 xxx.test.test 的 A 記錄（IPv4）會返回 127.0.0.1、127.0.0.2 和 127.0.0.3
    * 請求解析 xxx.test.test 的 AAAA 記錄（IPv6）會返回 ::1、::2 和 ::3


* Local Hosts - 境內 DNS 解析功能變數名稱清單
本區域資料用於為功能變數名稱使用境內 DNS 伺服器解析提高存取速度，使用時請確認境內 DNS 伺服器位址不為空（參見上文 設定檔詳細參數說明 一節）
有效參數格式為 "正則運算式"（不含引號）
  * 要使用本功能，必須將設定檔內的 Local Hosts 選項打開！
  * 本功能不會對境內 DNS 伺服器回復進行任何過濾，請確認本區域填入的資料不會受到 DNS 投毒污染的干擾
  * 例如有一個 [Local Hosts] 下有效資料區域：

    .*\.test\.test
    .*\.test

  * 即所有符合以上正則運算式的功能變數名稱請求都將使用境內 DNS 伺服器解析


* Address Hosts - 解析結果位址其他清單
  * 本區域資料用於替換解析結果中的位址，提供更精確的 Hosts 自訂能力
  * 目標位址區域支援使用網路首碼格式，可根據指定的前置長度替換解析結果中位址的首碼資料
    * 使用網路首碼格式時第一個目標位址條目必須指定前置長度，其它目標位址可省略不寫也可全部寫上
    * 網路首碼格式指定後將應用到所有目標位址上，注意整個條目只能指定同一個前置長度
  * 例如有一個 [Address Hosts] 下有效資料區域：

    127.0.0.1|127.0.0.2 127.0.0.0-127.255.255.255
    255.255.255.255/24 255.254.253.252
    ::1 ::-::FFFF
    FFFF:EEEE::/64|FFFF:EEEE:: FFFF::EEEE|FFFF::EEEF-FFFF::FFFF

  * 解析結果的位址範圍為 127.0.0.0 到 127.255.255.255 時將被替換為 127.0.0.1 或 127.0.0.2
  * 解析結果的位址為 255.254.253.252 時將被替換為 255.255.255.252
  * 解析結果的位址範圍為 :: 到 ::FFFF 時將被替換為 ::1
  * 解析結果的位址範圍為 FFFF::EEEE 或 FFFF::EEEF 到 FFFF::FFFF 時將被替換為 FFFF:FFFF::EEEE 或 FFFF:FFFF::xxxx:xxxx:xxxx:xxxx 或 FFFF:EEEE::EEEE 或 FFFF:EEEE::xxxx:xxxx:xxxx:xxxx


* Stop - 臨時停止讀取標籤
  * 在需要停止讀取的資料前添加 "[Stop]" 和資料後添加 "[Stop End]"（均不含引號）標籤即可在中途停止對檔的讀取
  * 臨時停止讀取生效後需要遇到臨時停止讀取終止標籤或其它標籤時才會重新開始讀取
  * 例如有一片資料區域：

    [Hosts]
    [Stop]
    127.0.0.1|127.0.0.2|127.0.0.3 .*\.test\.test
    127.0.0.4|127.0.0.5|127.0.0.6 .*\.test
    [Stop End]
    ::1|::2|::3 .*\.test\.test
    ::4|::5|::6 .*\.test

    [Local Hosts]
    .*\.test\.test
    .*\.test

  * 則從 [Stop] 一行開始，下面到 [Stop End] 之間的資料都將不會被讀取
  * 即實際有效的資料區域是：

    [Hosts]
    ::1|::2|::3 .*\.test\.test
    ::4|::5|::6 .*\.test

    [Local Hosts]
    .*\.test\.test
    .*\.test


* Dnsmasq Address - Dnsmasq 相容地址格式
  * Address 相容格式適用于 Hosts/CNAME Hosts - 主要 Hosts 清單/CNAME Hosts 清單
  * 有效參數格式：
    * 首碼支援 --ADDRESS=/ 或 --Address=/ 或 --address=/ 或 ADDRESS=/ 或 Address=/ 或 address=/
    * 普通功能變數名稱字串匹配模式為 "Address=/功能變數名稱尾碼/(位址)"（不含引號，括弧內為可選項目），功能變數名稱尾碼如果只填入 "#" 則表示匹配所有功能變數名稱
    * 正則運算式模式為 "Address=/:正則運算式:/(位址)"（不含引號，括弧內為可選項目）
    * 位址部分如果留空不填，則相當於 Banned - 黑名單條目
  * 例如以下 [Hosts] 條目是完全等價的：

    Address=/:.*\btest:/127.0.0.1
    Address=/test/127.0.0.1

  * 匹配所有功能變數名稱的解析結果到 ::1

    Address=/#/::1

  * 對符合規則的功能變數名稱返回功能變數名稱不存在資訊

    Address=/test/


* Dnsmasq Server - Dnsmasq 相容伺服器格式
  * 要使用本功能，必須將設定檔內的 Local Hosts 選項打開！
  * Server 相容格式適用于 Local Hosts - 境內 DNS 解析功能變數名稱清單
  * 有效參數格式：
    * 首碼支援 --SERVER=/ 或 --Server=/ 或 --server=/ 或 SERVER=/ 或 Server=/ 或 server=/
    * 普通功能變數名稱字串匹配模式為 "Server=/(功能變數名稱尾碼)/(指定進行解析的 DNS 位址(#埠))"（不含引號，括弧內為可選項目）
    * 正則運算式模式為 "Server=/(:正則運算式:)/(指定進行解析的 DNS 位址(#埠))"（不含引號，括弧內為可選項目）
    * 功能變數名稱尾碼或者 :正則運算式: 部分留空不填，相當於匹配不符合標準的功能變數名稱，例如沒有任何 . 的功能變數名稱
    * 指定進行解析的 DNS 位址部分如果留空不填，則相當於使用程式設定檔指定的預設 DNS 伺服器進行解析
    * 指定進行解析的 DNS 位址部分只填入 "#" 相當於 Whitelist - 白名單條目
  * 例如以下 [Local Hosts] 條目是完全等價的：

    Server=/:.*\btest:/::1#53
    Server=/test/::1

  * 對符合規則的功能變數名稱使用程式設定檔指定的預設 DNS 伺服器進行解析

    Server=/test/

  * 不符合標準的功能變數名稱全部發往 127.0.0.1 進行解析

    Server=//127.0.0.1


-------------------------------------------------------------------------------


IPFilter 檔案格式說明：

IPFilter 設定檔分為 Blacklist/黑名單區域 和 IPFilter/位址過濾區域 以及 Local Routing/境內路由表區域
* 區域通過標籤識別，修改時切勿將其刪除
* 一條條目的總長度切勿超過4096位元組/4KB
* 需要注釋請在條目開頭添加 #/井號


* Blacklist - 黑名單區域
當 Blacklist Filter 為開啟時，將檢查本清單功能變數名稱與解析結果，如果解析結果裡含有與功能變數名稱對應的黑名單位址，則會直接丟棄此解析結果
有效參數格式為 "位址(|位址A|位址B) 正則運算式"（不含引號，括弧內為可選項目，注意間隔所在的位置）
  * 位址與正則運算式之間的間隔字元可為 Space/半形空格 或者 HT/水準定位符號，間隔長度不限，但切勿輸入全形空格
  * 一條條目只能接受一種網址類別型（IPv4/IPv6），如有同一個功能變數名稱需要同時進行 IPv4/IPv6 位址的過濾，請分為兩個條目輸入


* IPFilter - 位址過濾區域
位址過濾黑名單或白名單由設定檔的 IPFilter Type 值決定，Deny 禁止/黑名單和 Permit 允許/白名單
有效參數格式為 "開始位址 - 結束位址, 過濾等級, 條目簡介注釋"（不含引號）
  * 同時支援 IPv4 和 IPv6 位址，但填寫時請分開為2個條目


* Local Routing - 境內路由表區域
當 Local Routing 為開啟時，將檢查本清單的路由表是否命中，檢查與否與功能變數名稱請求是否使用 Local 伺服器有關，路由表命中後會直接返回結果，命中失敗將丟棄解析結果並向境外伺服器再次發起請求
有效參數格式為 "位址塊/網路前置長度"（不含引號）
  * 本路由表支援 IPv4 和 IPv6 協定
  * IPv4 時網路前置長度範圍為 1-32，IPv6 時網路前置長度範圍為 1-128


* Stop - 臨時停止讀取標籤
  * 更詳細的介紹參見上文對本功能的介紹


-------------------------------------------------------------------------------


設定檔自動刷新支援參數清單：

* 以下清單中的參數在寫入設定檔後會自動刷新而無須重新開機程式，其它參數的刷新則必須重新開機程式
* 如非必要建議不要依賴程式的自動刷新功能，強烈建議修改設定檔後重新開機程式！

* Version
* File Refresh Time
* Print Log Level
* Log Maximum Size
* IPFilter Type
* IPFilter Level
* Accept Type
* Direct Request
* Default TTL
* Local Protocol
* Local Force Request
* Thread Pool Reset Time
* IPv4 Packet TTL
* IPv4 Main DNS TTL
* IPv4 Alternate DNS TTL
* IPv6 Packet Hop Limits
* IPv6 Main DNS Hop Limits
* IPv6 Alternate DNS Hop Limits
* HopLimits Fluctuation
* Reliable Once Socket Timeout
* Reliable Serial Socket Timeout
* Unreliable Once Socket Timeout
* Unreliable Serial Socket Timeout
* Receive Waiting
* ICMP Test
* Domain Test
* Multiple Request Times
* Domain Case Conversion
* IPv4 Do Not Fragment
* IPv4 Data Filter
* TCP Data Filter
* DNS Data Filter
* Strict Resource Record TTL Filter
* SOCKS Target Server
* SOCKS Username
* SOCKS Password
* HTTP CONNECT Target Server
* HTTP CONNECT TLS Version
* HTTP CONNECT TLS Validation
* HTTP CONNECT Header Field
* HTTP CONNECT Proxy Authorization
* DNSCurve Reliable Socket Timeout
* DNSCurve Unreliable Socket Timeout
* DNSCurve Key Recheck Time
* DNSCurve Client Public Key
* DNSCurve Client Secret Key
* DNSCurve IPv4 Main DNS Public Key
* DNSCurve IPv4 Alternate DNS Public Key
* DNSCurve IPv6 Main DNS Public Key
* DNSCurve IPv6 Alternate DNS Public Key
* DNSCurve IPv4 Main DNS Fingerprint
* DNSCurve IPv4 Alternate DNS Fingerprint
* DNSCurve IPv6 Main DNS Fingerprint
* DNSCurve IPv6 Alternate DNS Fingerprint
* DNSCurve IPv4 Main Receive Magic Number
* DNSCurve IPv4 Alternate Receive Magic Number
* DNSCurve IPv6 Main Receive Magic Number
* DNSCurve IPv6 Alternate Receive Magic Number
* DNSCurve IPv4 Main DNS Magic Number
* DNSCurve IPv4 Alternate DNS Magic Number
* DNSCurve IPv6 Main DNS Magic Number
* DNSCurve IPv6 Alternate DNS Magic Number
