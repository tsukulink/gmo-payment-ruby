# coding: utf-8

# A client for the GMO Payment API.
#
# example
# gmo = Gmo::Payment::ShopAPI.new({
#   shop_id:     "foo",
#   shop_pass:   "bar",
#   host:        "mul-pay.com",
#   locale:      "ja"

# })
# result = gmo.post_request("EntryTran.idPass", options)
module Gmo
  module Payment

    module ShopAPIMethods

      def initialize(options = {})
        @shop_id   = options[:shop_id]
        @shop_pass = options[:shop_pass]
        @host      = options[:host]
        @locale    = options.fetch(:locale, :en)
        unless @shop_id && @shop_pass && @host
          raise ArgumentError, "Initialize must receive a hash with :shop_id, :shop_pass and either :host! (received #{options.inspect})"
        end
      end
      attr_reader :shop_id, :shop_pass, :host, :locale

      ## 2.1.2.1.取引登録
      # これ以降の決済取引で必要となる取引 ID と取引パスワードの発行を行い、取引を開始します。
      # ItemCode
      # Tax
      # TdFlag
      # TdTenantName
      ### @return ###
      # AccessID
      # AccessPass
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.entry_tran({
      #   order_id: 100,
      #   job_cd: "AUTH",
      #   amount: 100
      # })
      # {"AccessID"=>"a41d83f1f4c908baeda04e6dc03e300c", "AccessPass"=>"d72eca02e28c88f98b9341a33ba46d5d"}
      def entry_tran(options = {})
        name = "EntryTran.idPass"
        required = [:order_id, :job_cd]
        required << :amount if options[:job_cd] && options[:job_cd] != "CHECK"
        assert_required_options(required, options)
        post_request name, options
      end

      # 【コンビニ払い】
      #  2.1.2.1. 取引登録
      #  これ以降の決済取引で必要となる取引IDと取引パスワードの発行を行い、取引を開始します。
      def entry_tran_cvs(options = {})
        name = "EntryTranCvs.idPass"
        required = [:order_id, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      # 【Pay-easy決済】
      #  5.1.2.1. 取引登録
      #  これ以降の決済取引で必要となる取引IDと取引パスワードの発行を行い、取引を開始します。
      def entry_tran_pay_easy(options = {})
        name = "EntryTranPayEasy.idPass"
        required = [:order_id, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      # 【LINE Pay決済】
      #  20.1.2.1. 取引登録
      #  これ以降の決済取引で必要となる取引IDと取引パスワードの発行を行い、取引を開始します。
      def entry_tran_linepay(options = {})
        name = "EntryTranLinepay.idPass"
        required = [:order_id, :job_cd, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      # 【au かんたん決済】
      #  9.1.2.1. 取引登録
      #  これ以降の決済取引で必要となる取引IDと取引パスワードの発行を行い、取引を開始します。
      def entry_tran_au(options = {})
        name = "EntryTranAu.idPass"
        required = [:order_id, :job_cd, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      # 【ドコモケータイ払い決済】
      #  11.1.2.1. 取引登録
      #  これ以降の決済取引で必要となる取引IDと取引パスワードの発行を行い、取引を開始します。
      def entry_tran_docomo(options = {})
        name = "EntryTranDocomo.idPass"
        required = [:order_id, :job_cd, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      # 【ソフトバンクまとめて支払い決済】
      #  13.1.2.1. 取引登録
      #  これ以降の決済取引で必要となる取引IDと取引パスワードの発行を行い、取引を開始します。
      def entry_tran_sb(options = {})
        name = "EntryTranSb.idPass"
        required = [:order_id, :job_cd, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      # 【Famipay決済】
      #  4.3.1.1. 取引登録
      #  これ以降の決済取引で必要となる取引IDと取引パスワードの発行を行い、取引を開始します。
      def entry_tran_famipay(options = {})
        name = "EntryTranFamipay.idPass"
        required = [:order_id, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      ### @params ###
      # OrderID
      # JobCd
      # Amount
      # ItemCode
      # Tax
      ### @return ###
      # AccessID
      # AccessPass
      ### example ###
      # gmo.entry_tran_brandtoken({
      #   order_id: "ord12345",
      #   job_cd: "AUTH",
      #   item_code: "1000001",
      #   tax: "0001001",
      #   amount: 100
      # })
      # => {"AccessID"=>"139f8ec33a07c55f406937c52ce4473d", "AccessPass"=>"2689b204d2c17192fa35f9269fa7e744"}
      def entry_tran_brandtoken(options = {})
        name = "EntryTranBrandtoken.idPass"
        required = [:order_id, :job_cd, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      ## 2.2.2.2.決済実行
      # 指定されたサイトに会員を登録します。
      # return
      # ACS
      # OrderID
      # Forward
      # Method
      # PayTimes
      # Approve
      # TranID
      # TranDate
      # CheckString
      # ClientField1
      # ClientField2
      # ClientField3
      ### @return ###
      # ACS
      # OrderID
      # Forward
      # Method
      # PayTimes
      # Approve
      # TranID
      # CheckString
      # ClientField1
      # ClientField2
      # ClientField3
      ### example ###
      # gmo.exec_tran({
      #   order_id:      100,
      #   access_id:    "a41d83f1f4c908baeda04e6dc03e300c",
      #   access_pass:  "d72eca02e28c88f98b9341a33ba46d5d",
      #   method:        1,
      #   pay_times:     1,
      #   card_no:       "4111111111111111",
      #   expire:        "1405", #format YYMM
      #   client_field_1: "client_field1"
      # })
      # {"ACS"=>"0", "OrderID"=>"100", "Forward"=>"2a99662", "Method"=>"1", "PayTimes"=>"", "Approve"=>"6294780", "TranID"=>"1302160543111111111111192829", "TranDate"=>"20130216054346", "CheckString"=>"3e455a2168fefc90dbb7db7ef7b0fe82", "ClientField1"=>"client_field1", "ClientField2"=>"", "ClientField3"=>""}
      def exec_tran(options = {})
        name = "ExecTran.idPass"
        if options[:client_field_1] || options[:client_field_2] || options[:client_field_3]
          options[:client_field_flg] = "1"
        else
          options[:client_field_flg] = "0"
        end
        options[:device_category] = "0"

        # args = {
        #   "AccessID"        => options[:access_id],
        #   "AccessPass"      => options[:access_pass],
        #   "OrderID"         => options[:order_id],
        #   "Method"          => options[:method],
        #   "PayTimes"        => options[:pay_times],
        #   "CardNo"          => options[:card_no],
        #   "Expire"          => options[:expire],
        #   "HttpAccept"      => options[:http_accept],
        #   "HttpUserAgent"   => options[:http_ua],
        #   "DeviceCategory"  => "0",
        #   "ClientField1"    => options[:client_field_1],
        #   "ClientField2"    => options[:client_field_2],
        #   "ClientField3"    => options[:client_field_3],
        #   "ClientFieldFlag" => client_field_flg
        # }
        if options[:token].nil?
          required = [:access_id, :access_pass, :order_id, :card_no, :expire]
        else
          required = [:access_id, :access_pass, :token]
        end
        assert_required_options(required, options)
        post_request name, options
      end

      # 【コンビニ払い】
      # 2.1.2.2. 決済実行
      # お客様が入力した情報で後続の決済センターと通信を行い決済を実施し、結果を返します。
      def exec_tran_cvs(options = {})
        name = "ExecTranCvs.idPass"
        required = [:access_id, :access_pass, :order_id, :convenience, :customer_name, :customer_kana, :tel_no, :receipts_disp_11, :receipts_disp_12, :receipts_disp_13]
        assert_required_options(required, options)
        post_request name, options
      end

      # 【Pay-easy決済】
      # 5.1.2.2. 決済実行
      # お客様が入力した情報で後続の決済センターと通信を行い決済を実施し、結果を返します。
      def exec_tran_pay_easy(options = {})
        name = "ExecTranPayEasy.idPass"
        required = [:access_id, :access_pass, :order_id, :customer_name, :customer_kana, :tel_no, :receipts_disp_11, :receipts_disp_12, :receipts_disp_13]
        assert_required_options(required, options)
        post_request name, options
      end

      # 【LINE Pay決済】
      # 20.1.2.2. 決済実行
      def exec_tran_linepay(options = {})
        name = "ExecTranLinepay.idPass"
        required = [:access_id, :access_pass, :order_id, :ret_url, :error_rcv_url, :product_name]
        assert_required_options(required, options)
        post_request name, options
      end

      #【au かんたん決済】
      # 9.1.2.2. 決済実行
      # お客様が入力した情報で後続の決済センターと通信を行い決済を実施し、結果を返します。
      def exec_tran_au(options = {})
        name = "ExecTranAu.idPass"
        required = [:access_id, :access_pass, :order_id, :commodity, :ret_url, :service_name, :service_tel]
        assert_required_options(required, options)
        post_request name, options
      end

      #【ドコモケータイ払い決済】
      #  11.1.2.2. 決済実行
      # お客様が入力した情報で後続の決済センターと通信を行い決済を実施し、結果を返します。
      def exec_tran_docomo(options = {})
        name = "ExecTranDocomo.idPass"
        required = [:access_id, :access_pass, :order_id, :ret_url]
        assert_required_options(required, options)
        post_request name, options
      end

      # 【ソフトバンクまとめて支払い決済】
      #  13.1.2.2. 決済実行
      # お客様が入力した情報で後続の決済センターと通信を行い決済を実施し、結果を返します。
      def exec_tran_sb(options = {})
        name = "ExecTranSb.idPass"
        required = [:access_id, :access_pass, :order_id, :ret_url]
        assert_required_options(required, options)
        post_request name, options
      end

      # 【Famipay決済】
      #  4.3.1.2. 決済実行
      # これ以降の決済取引で必要となるトークンを返却します。
      def exec_tran_famipay(options = {})
        name = "ExecTranFamipay.idPass"
        required = [:access_id, :access_pass, :order_id, :ret_url]
        assert_required_options(required, options)
        post_request name, options
      end

      ### @params ###
      # AccessID
      # AccessPass
      # OrderID
      # TokenType
      # Token
      # MemberID
      # SeqMode
      # TokenSeq
      # ClientField1
      # ClientField2
      # ClientField3
      ### @return ###
      # Status
      # OrderID
      # Forward
      # Approve
      # TranID
      # TranDate
      # ClientField1
      # ClientField2
      # ClientField3
      ### example ###
      # gmo.exec_tran_brandtoken({
      #   order_id: "597ae8c36120b23a3c00014e",
      #   access_id: "139f8ec33a07c55f406937c52ce4473d",
      #   access_pass: "2689b204d2c17192fa35f9269fa7e744",
      #   token_type: :apple_pay,
      #   token: <Base64 encoded payment data>,
      #   seq_mode: "1",
      #   token_seq: 1001,
      #   client_field_1: "Custom field value 1",
      #   client_field_2: "Custom field value 2",
      #   client_field_3: "Custom field value 3"
      # })
      # => {"Status"=>"CAPTURE", "OrderID"=>"597ae8c36120b23a3c00014e", "Forward"=>"2a99663", "Approve"=>"5487394", "TranID"=>"1707281634111111111111771216", "TranDate"=>"20170728163453", "ClientField1"=>"Custom field value 1", "ClientField2"=>"Custom field value 2", "ClientField3"=>"Custom field value 3"}
      def exec_tran_brandtoken(options = {})
        name = "ExecTranBrandtoken.idPass"
        options[:token_type] = Gmo::Const::TOKEN_TYPES_MAP[options[:token_type]]
        required = [:access_id, :access_pass, :order_id]
        assert_required_options(required, options)
        post_request name, options
      end

      ## 2.14.2.1.決済変更
      # 仮売上の決済に対して実売上を行います。尚、実行時に仮売上時との金額チェックを行います。
      # /payment/AlterTran.idPass
      # ShopID
      # ShopPass
      # AccessID 取引ID
      # AccessPass 取引パスワード
      # JobCd 処理区分 "SALES"
      # Amount 利用金額
      ### @return ###
      # AccessID
      # AccessPass
      # Forward
      # Approve
      # TranID
      # TranDate
      ### example ###
      # gmo.alter_tran({
      #   access_id:    "a41d83f1f4c908baeda04e6dc03e300c",
      #   access_pass:  "d72eca02e28c88f98b9341a33ba46d5d",
      #   job_cd: "SALES",
      #   amount: 100
      # })
      # {"AccessID"=>"381d84ae4e6fc37597482573a9569f10", "AccessPass"=>"cc0093ca8758c6616fa0ab9bf6a43e8d", "Forward"=>"2a99662", "Approve"=>"6284199", "TranID"=>"1302140555111111111111193536", "TranDate"=>"20130215110651"}
      def alter_tran(options = {})
        name = "AlterTran.idPass"
        required = [:access_id, :access_pass, :job_cd]
        assert_required_options(required, options)
        post_request name, options
      end

      #【au かんたん決済】
      # 9.1.2.2. 決済実行
      # 仮売上の決済に対して実売上を行います。尚、実行時に仮売上時との金額チェックを行います。
      # /payment/AuSales.idPass
      # ShopID
      # ShopPass
      # AccessID
      # AccessPass
      # OrderID
      # Amount
      # Tax
      ### @return ###
      # OrderID
      # Status
      # Amount
      # Tax
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.sales_au({
      #   access_id:   "a41d83f1f4c908baeda04e6dc03e300c",
      #   access_pass: "d72eca02e28c88f98b9341a33ba46d5d",
      #   order_id:    "597ae8c36120b23a3c00014e",
      #   amount:      100,
      #   tax:         0
      # })
      # {"OrderID"=>"597ae8c36120b23a3c00014e", "Status"=>"SALES", "Amount"=>"100", "Tax"=>"0", "ErrCode" => "E01|E02", "ErrInfo" => "E01|E02"}
      def sales_au(options = {})
        name = "AuSales.idPass"
        required = [:access_id, :access_pass, :order_id, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      #【ソフトバンクまとめて支払い決済】
      ## 13.3.2.1.決済変更
      # 仮売上の決済に対して実売上を行います。尚、実行時に仮売上時との金額チェックを行います。
      # /payment/SbSales.idPass
      # ShopID
      # ShopPass
      # AccessID
      # AccessPass
      # OrderID
      # Amount
      # Tax
      ### @return ###
      # OrderID
      # Status
      # Amount
      # Tax
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.sales_sb({
      #   access_id:   "a41d83f1f4c908baeda04e6dc03e300c",
      #   access_pass: "d72eca02e28c88f98b9341a33ba46d5d",
      #   order_id:    "597ae8c36120b23a3c00014e",
      #   amount:      100,
      #   tax:         0
      # })
      # {"OrderID"=>"597ae8c36120b23a3c00014e", "Status"=>"SALES", "Amount"=>"100", "Tax"=>"0", "ErrCode" => "E01|E02", "ErrInfo" => "E01|E02"}
      def sales_sb(options = {})
        name = "SbSales.idPass"
        required = [:access_id, :access_pass, :order_id, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      #【ドコモケータイ払い決済】
      ## 11.3.2.1.決済変更
      # 仮売上の決済に対して実売上を行います。尚、実行時に仮売上時との金額チェックを行います。
      # /payment/DocomoSales.idPass
      # ShopID
      # ShopPass
      # AccessID
      # AccessPass
      # OrderID
      # Amount
      # Tax
      ### @return ###
      # OrderID
      # Status
      # Amount
      # Tax
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.sales_docomo({
      #   access_id:   "a41d83f1f4c908baeda04e6dc03e300c",
      #   access_pass: "d72eca02e28c88f98b9341a33ba46d5d",
      #   order_id:    "597ae8c36120b23a3c00014e",
      #   amount:      100,
      #   tax:         0
      # })
      # {"OrderID"=>"597ae8c36120b23a3c00014e", "Status"=>"SALES", "Amount"=>"100", "Tax"=>"0", "ErrCode" => "E01|E02", "ErrInfo" => "E01|E02"}
      def sales_docomo(options = {})
        name = "DocomoSales.idPass"
        required = [:access_id, :access_pass, :order_id, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      ## 2.15.2.1.金額変更
      # 決済が完了した取引に対して金額の変更を行います。
      ### @return ###
      # AccessID
      # AccessPass
      # Forward
      # Approve
      # TranID
      # TranDate
      ### example ###
      # gmo.change_tran({
      #   access_id:    "a41d83f1f4c908baeda04e6dc03e300c",
      #   access_pass:  "d72eca02e28c88f98b9341a33ba46d5d",
      #   job_cd: "CAPTURE",
      #   amount: 100
      # })
      def change_tran(options = {})
        name = "ChangeTran.idPass"
        required = [:access_id, :access_pass, :job_cd, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      ### @params ###
      # AccessID
      # AccessPass
      # OrderID
      # JobCd
      # Amount
      # Tax
      ### @return ###
      # AccessID
      # AccessPass
      # Status
      # Forward
      # Approve
      # TranID
      # TranDate
      ### example ###
      # gmo.change_tran_brandtoken({
      #   access_id: "21170701482c86c3b88ff72b83bfd363",
      #   access_pass: "51f36feba120de1e6e29532e5a3a5e3e",
      #   order_id: "ord10001",
      #   job_cd: "CAPTURE",
      #   amount: 2000
      # })
      # => {"AccessID"=>"21170701482c86c3b88ff72b83bfd363", "AccessPass"=>"51f36feba120de1e6e29532e5a3a5e3e", "Status"=>"CAPTURE", "Forward"=>"2a99663", "Approve"=>"5538477", "TranID"=>"1707311633111111111111771224", "TranDate"=>"20170731163343"}
      def change_tran_brandtoken(options = {})
        name = "ChangeTranBrandtoken.idPass"
        required = [:access_id, :access_pass, :order_id, :job_cd, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      ### @params ###
      # AccessID
      # AccessPass
      # OrderID
      ### @return ###
      # AccessID
      # AccessPass
      # Status
      # Forward
      # Approve
      # TranID
      # TranDate
      ### example ###
      # gmo.void_tran_brandtoken({
      #   access_id: "139f8ec33a07c55f406937c52ce4473d",
      #   access_pass: "2689b204d2c17192fa35f9269fa7e744",
      #   order_id: "597ae8c36120b23a3c00014e"
      # })
      # => {"AccessID"=>"139f8ec33a07c55f406937c52ce4473d", "AccessPass"=>"2689b204d2c17192fa35f9269fa7e744", "Status"=>"VOID", "Forward"=>"2a99663", "Approve"=>"5537590", "TranID"=>"1707311610111111111111771219", "TranDate"=>"20170731161007"}
      def void_tran_brandtoken(options = {})
        name = "VoidTranBrandtoken.idPass"
        required = [:access_id, :access_pass, :order_id]
        assert_required_options(required, options)
        post_request name, options
      end

      ### @params ###
      # AccessID
      # AccessPass
      # OrderID
      # Amount
      # Tax
      ### @return ###
      # AccessID
      # AccessPass
      # Status
      # Forward
      # Approve
      # TranID
      # TranDate
      ### example ###
      # gmo.sales_tran_brandtoken({
      #   access_id: "139f8ec33a07c55f406937c52ce4473d",
      #   access_pass: "2689b204d2c17192fa35f9269fa7e744",
      #   order_id: "597ae8c36120b23a3c00014e",
      #   amount: 1000,
      #   tax: "0001001"
      # })
      # => {"AccessID"=>"139f8ec33a07c55f406937c52ce4473d", "AccessPass"=>"2689b204d2c17192fa35f9269fa7e744", "Status"=>"SALES", "Forward"=>"2a99663", "Approve"=>"5537883", "TranID"=>"1707311620111111111111771220", "TranDate"=>"20170731162256"}
      def sales_tran_brandtoken(options = {})
        name = "SalesTranBrandtoken.idPass"
        required = [:access_id, :access_pass, :order_id, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      ### @params ###
      # AccessID
      # AccessPass
      # OrderID
      # Amount
      # Tax
      ### @return ###
      # AccessID
      # AccessPass
      # Status
      # Forward
      # Approve
      # TranID
      # TranDate
      ### example ###
      # gmo.refund_tran_brandtoken({
      #   access_id: "139f8ec33a07c55f406937c52ce4473d",
      #   access_pass: "2689b204d2c17192fa35f9269fa7e744",
      #   order_id: "597ae8c36120b23a3c00014e",
      #   amount: 1000,
      #   tax: "0001001"
      # })
      # => {"AccessID"=>"139f8ec33a07c55f406937c52ce4473d", "AccessPass"=>"2689b204d2c17192fa35f9269fa7e744", "Status"=>"RETURN", "Forward"=>"2a99663", "Approve"=>"5537883", "TranID"=>"1707311620111111111111771220", "TranDate"=>"20170731162256"}
      def refund_tran_brandtoken(options = {})
        name = "RefundTranBrandtoken.idPass"
        required = [:access_id, :access_pass, :order_id, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      ## 2.16.2.1.取引状態参照
      # 指定したオーダーID の取引情報を取得します。
      def search_trade(options = {})
        name = "SearchTrade.idPass"
        required = [:order_id]
        assert_required_options(required, options)
        post_request name, options
      end

      # 13.1.2.1.取引状態参照
      # 指定したオーダーIDの取引情報を取得します。
      ### @params ###
      # OrderID
      # PayType
      ### @return ###
      # OrderID
      # Status
      # ProcessDate
      # JobCd
      # AccessID
      # AccessPass
      # ItemCode
      # Amount
      # Tax
      # SiteID
      # MemberID
      # CardNoToken
      # Expire
      # Method
      # PayTimes
      # Forward
      # TranID
      # Approve
      # ClientField1
      # ClientField2
      # ClientField3
      # PayType
      ### example ###
      # gmo.search_trade_multi({
      #   order_id: '598066176120b2235300020b',
      #   pay_type: 27
      # })
      # => {"OrderID"=>"598066176120b2235300020b", "Status"=>"CAPTURE", "ProcessDate"=>"20170801202929", "JobCd"=>"CAPTURE", "AccessID"=>"228fc5bc02da46943300c12706d325a2", "AccessPass"=>"090a50ec2f77d92184a18018f07906e5", "ItemCode"=>"0000990", "Amount"=>"557", "Tax"=>"0", "SiteID"=>"", "MemberID"=>"", "CardNoToken"=>"************1111", "Expire"=>"2212", "Method"=>"1", "PayTimes"=>"", "Forward"=>"2a99663", "TranID"=>"1708012029111111111111771228", "Approve"=>"5689128", "ClientField1"=>"", "ClientField2"=>"", "ClientField3"=>"", "PayType"=>"27"}
      def search_trade_multi(options = {})
        name = "SearchTradeMulti.idPass"
        required = [:order_id, :pay_type]
        assert_required_options(required, options)
        post_request name, options
      end

      ### @params ###
      # RecurringID
      # Amount
      # Tax
      # ChargeDay
      # ChargeMonth
      # ChargeStartDate
      # ChargeStopDate
      # CardNo
      # Expire
      # SrcOrderID
      # ClientField1
      # ClientField2
      # ClientField3
      ### @return ###
      # ShopID
      # RecurringID
      # Amount
      # Tax
      # ChargeDay
      # ChargeMonth
      # ChargeStartDate
      # ChargeStopDate
      # NextChargeDate
      # Method
      # CardNo
      # Expire
      def register_recurring_credit(options)
        name = "RegisterRecurringCredit.idPass"
        required = [:recurring_id, :amount, :charge_day]
        if options[:src_order_id]
          options[:regist_type] = 3
        else
          required += [:card_no, :expire]
          options[:regist_type] = 2
        end
        assert_required_options(required, options)
        post_request name, options
      end

      ### @param ###
      # RecurringID
      # Amount
      # Tax
      # ChargeMonth
      # ChargeStartDate
      # ChargeStopDate
      # PrintStr
      # ClientField1
      # ClientField2
      # ClientField3
      ### @return ###
      # ShopID
      # RecurringID
      # Amount
      # Tax
      # ChargeDay
      # ChargeMonth
      # ChargeStartDate
      # ChargeStopDate
      # NextChargeDate
      # Method
      # PrintStr
      def register_recurring_accounttrans(options)
        name = "RegisterRecurringAccounttrans.idPass"
        required = [:recurring_id, :amount, :print_str]
        assert_required_options(required, options)
        post_request name, options
      end

      ### @param ###
      # RecurringID
      ### @return ###
      # ShopID
      # RecurringID
      # Amount
      # Tax
      # ChargeDay
      # ChargeMonth
      # ChargeStartDate
      # ChargeStopDate
      # NextChargeDate
      # Method
      # SiteID
      # MemberID
      # CardNo
      # Expire
      # PrintStr
      def unregister_recurring(options)
        name = "UnregisterRecurring.idPass"
        required = [:recurring_id]
        assert_required_options(required, options)
        post_request name, options
      end

      ### @param ###
      # RecurringID
      # Amount
      # Tax
      ### @return ###
      # ShopID
      # RecurringID
      # Amount
      # Tax
      # ChargeDay
      # ChargeMonth
      # ChargeStartDate
      # ChargeStopDate
      # NextChargeDate
      # Method
      # SiteID
      # MemberID
      # CardNo
      # Expire
      # PrintStr
      def change_recurring(options)
        name = "ChangeRecurring.idPass"
        required = [:recurring_id, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      ### @param ###
      # RecurringID
      ### @return ###
      # ShopID
      # RecurringID
      # Amount
      # Tax
      # ChargeDay
      # ChargeMonth
      # ChargeStartDate
      # ChargeStopDate
      # NextChargeDate
      # Method
      # SiteID
      # MemberID
      # CardNo
      # Expire
      # PrintStr
      def search_recurring(options)
        name = "SearchRecurring.idPass"
        required = [:recurring_id]
        assert_required_options(required, options)
        post_request name, options
      end

      # AccessID
      # AccessPass
      # OrderID
      ### @return ###
      # OrderID
      # Status
      def cancel_cvs(options = {})
        name = "CvsCancel.idPass"
        required = [:access_id, :access_pass, :order_id]
        assert_required_options(required, options)
        post_request name, options
      end

      ### @param ###
      # RecurringID
      ### @return ###
      # Method (RECURRING_CREDIT)
      # ShopID
      # RecurringID
      # OrderID
      # ChargeDate
      # Status
      # Amount
      # Tax
      # NextChargeDate
      # AccessID
      # AccessPass
      # Forward
      # ApprovalNo
      # ChargeErrCode
      # ChargeErrInfo
      # ProcessDate
      #
      # Method (RECURRING_ACCOUNTTRANS)
      # SiteID
      # MemberID
      # ShopID
      # Amount
      # Tax
      # PrintStr
      # RecurringID
      # Status
      # Result
      # ChargeErrCode
      # ChargeErrInfo
      def search_recurring_result(options)
        name = "SearchRecurringResult.idPass"
        required = [:recurring_id]
        assert_required_options(required, options)
        post_request name, options
      end

      ### @param ###
      # Method
      # ChargeDate
      ### @return ###
      # String (csv format)
      def search_recurring_result_file(options)
        name = "SearchRecurringResultFile.idPass"
        required = [:method, :charge_date]
        assert_required_options(required, options)
        post_request name, options
      end

      ### @params ###
      # AccessID
      # AccessPass
      # OrderID
      ### @return ###
      # OrderID
      # Status
      def cancel_pay_easy(options = {})
        name = "PayEasyCancel.idPass"
        required = [:access_id, :access_pass, :order_id]
        assert_required_options(required, options)
        post_request name, options
      end

      #【au かんたん決済】
      ## 9.2.2.1. 決済キャンセル・返品 接続先URL
      # 決済が完了した取引に対して決済内容のキャンセル・返品を行います。
      # /payment/AuCancelReturn.idPass
      # ShopID
      # ShopPass
      # AccessID
      # AccessPass
      # OrderID
      # CancelAmount
      # CancelTax
      ### @return ###
      # OrderID
      # Status
      # Amount
      # Tax
      # CancelAmount
      # CancelTax
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.cancel_return_au({
      #   access_id:     "a41d83f1f4c908baeda04e6dc03e300c",
      #   access_pass:   "d72eca02e28c88f98b9341a33ba46d5d",
      #   order_id:      "597ae8c36120b23a3c00014e",
      #   cancel_amount: 100,
      #   cancel_tax:    0
      # })
      # {"OrderID"=>"597ae8c36120b23a3c00014e", "Status"=>"CANCEL or RETURN", "Amount" => "0", "Tax" => "0", "CancelAmount"=>"100", "CancelTax"=>"0", "ErrCode" => "E01|E02", "ErrInfo" => "E01|E02"}
      def cancel_return_au(options = {})
        name = "AuCancelReturn.idPass"
        required = [:access_id, :access_pass, :order_id, :cancel_amount]
        assert_required_options(required, options)
        post_request name, options
      end

      #【ソフトバンクまとめて支払い決済】
      ## 13.2.2.1. 決済キャンセル
      # 決済が完了した取引に対して決済内容のキャンセルを行います。
      # /payment/SbCancel.idPass
      # ShopID
      # ShopPass
      # AccessID
      # AccessPass
      # OrderID
      # CancelAmount
      # CancelTax
      ### @return ###
      # OrderID
      # Status
      # CancelAmount
      # CancelTax
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.cancel_sb({
      #   access_id:     "a41d83f1f4c908baeda04e6dc03e300c",
      #   access_pass:   "d72eca02e28c88f98b9341a33ba46d5d",
      #   order_id:      "597ae8c36120b23a3c00014e",
      #   cancel_amount: 100,
      #   cancel_tax:    0
      # })
      # {"OrderID"=>"597ae8c36120b23a3c00014e", "Status"=>"CANCEL", "CancelAmount"=>"100", "CancelTax"=>"0", "ErrCode" => "E01|E02", "ErrInfo" => "E01|E02"}
      def cancel_sb(options = {})
        name = "SbCancel.idPass"
        required = [:access_id, :access_pass, :order_id, :cancel_amount]
        assert_required_options(required, options)
        post_request name, options
      end

      #【ドコモケータイ払い決済】
      ## 11.2.2.1. 決済キャンセル・返品 接続先URL
      # 決済が完了した取引に対して決済内容のキャンセル・返品を行います。
      # /payment/DocomoCancelReturn.idPass
      # ShopID
      # ShopPass
      # AccessID
      # AccessPass
      # OrderID
      # CancelAmount
      # CancelTax
      ### @return ###
      # OrderID
      # Status
      # Amount
      # Tax
      # CancelAmount
      # CancelTax
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.cancel_return_docomo({
      #   access_id:     "a41d83f1f4c908baeda04e6dc03e300c",
      #   access_pass:   "d72eca02e28c88f98b9341a33ba46d5d",
      #   order_id:      "597ae8c36120b23a3c00014e",
      #   cancel_amount: 100,
      #   cancel_tax:    0
      # })
      # {"OrderID"=>"597ae8c36120b23a3c00014e", "Status"=>"CANCEL or RETURN", "Amount" => "0", "Tax" => "0", "CancelAmount"=>"100", "CancelTax"=>"0", "ErrCode" => "E01|E02", "ErrInfo" => "E01|E02"}
      def cancel_return_docomo(options = {})
        name = "DocomoCancelReturn.idPass"
        required = [:access_id, :access_pass, :order_id, :cancel_amount]
        assert_required_options(required, options)
        post_request name, options
      end

      #【auかんたん決済継続課金決済】
      ## 10.1.2.1. 取引登録
      # これ以降の決済取引で必要となる取引IDと取引パスワードの発行を行い、取引を開始します
      # /payment/EntryTranAuContinuance.idPass
      # ShopID
      # ShopPass
      # OrderID
      # Amount
      # Tax
      # FirstAmount
      # FirstTax
      ### @return ###
      # AccessID
      # AccessPass
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.entry_tran_continuance_au({
      #   shop_id:     "a41d83f1f4c908baeda04e6dc03e300c",
      #   shop_pass:   "d72eca02e28c88f98b9341a33ba46d5d",
      #   order_id:      "597ae8c36120b23a3c00014e",
      #   amount: 100,
      #   tax:    0
      #   first_amount: 100,
      #   first_tax:    0
      # })
      # {"AccessID"=>"", "AccessPass"=>"", "ErrCode" => "", "ErrInfo" => ""}
      def entry_tran_continuance_au(options = {})
        name = "EntryTranAuContinuance.idPass"
        required = [:order_id, :amount, :first_amount]
        assert_required_options(required, options)
        post_request name, options
      end

      #【ソフトバンクまとめて支払い継続課金決済】
      ## 22.1.2.1. 取引登録
      # これ以降の決済取引で必要となる取引IDと取引パスワードの発行を行い、取引を開始します
      #/payment/EntryTranSbContinuance.idPass
      # ShopID
      # ShopPass
      # OrderID
      # Amount
      # Tax
      ### @return ###
      # AccessID
      # AccessPass
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.entry_tran_continuance_sb({
      #   shop_id:     "a41d83f1f4c908baeda04e6dc03e300c",
      #   shop_pass:   "d72eca02e28c88f98b9341a33ba46d5d",
      #   order_id:      "597ae8c36120b23a3c00014e",
      #   amount: 100,
      #   tax:    0
      # })
      # {"AccessID"=>"", "AccessPass"=>"", "ErrCode" => "", "ErrInfo" => ""}
      def entry_tran_continuance_sb(options = {})
        name = "EntryTranSbContinuance.idPass"
        required = [:order_id, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      #【ドコモ継続課金サービス決済】
      ## 12.1.2.1. 取引登録
      # これ以降の決済取引で必要となる取引IDと取引パスワードの発行を行い、取引を開始します
      # /payment/EntryTranDocomoContinuance.idPass
      # ShopID
      # ShopPass
      # OrderID
      # Amount
      # Tax
      ### @return ###
      # AccessID
      # AccessPass
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.entry_tran_continuance_docomo({
      #   shop_id:     "a41d83f1f4c908baeda04e6dc03e300c",
      #   shop_pass:   "d72eca02e28c88f98b9341a33ba46d5d",
      #   order_id:      "597ae8c36120b23a3c00014e",
      #   amount: 100,
      #   tax:    0
      # })
      # {"AccessID"=>"", "AccessPass"=>"", "ErrCode" => "", "ErrInfo" => ""}
      def entry_tran_continuance_docomo(options = {})
        name = "EntryTranDocomoContinuance.idPass"
        required = [:order_id, :amount]
        assert_required_options(required, options)
        post_request name, options
      end

      #【auかんたん決済継続課金決済】
      ## 10.1.2.2. 決済実行
      # これ以降の決済取引で必要となるトークンを返却します。
      # /payment/ExecTranAuContinuance.idPass
      # ShopID
      # ShopPass
      # AccessID
      # AccessPass
      # OrderID
      # SiteID
      # SitePass
      # MemberID
      # MemberName
      # CreateMember
      # ClientField1
      # ClientField2
      # ClientField3
      # Commodity
      # AccountTimingKbn
      # AccountTiming
      # FirstAccountDate
      # RetURL
      # PaymentTermSec
      # ServiceName
      # ServiceTel
      ### @return ###
      # AccessID
      # Token
      # StartURL
      # StartLimitDate
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.exec_tran_continuance_au({
      #   shop_id:     "a41d83f1f4c908baeda04e6dc03e300c",
      #   shop_pass:   "d72eca02e28c88f98b9341a33ba46d5d",
      #   access_id: "139f8ec33a07c55f406937c52ce4473d",
      #   access_pass: "2689b204d2c17192fa35f9269fa7e744"",
      #   order_id: "597ae8c36120b23a3c00014e",
      #   site_id: "",
      #   site_pass: "",
      #   member_id: "",
      #   member_name: "",
      #   create_member: "",
      #   client_field_1: "",
      #   client_field_2: "",
      #   client_field_3: "",
      #   commodity: "",
      #   account_timing_kbn: "",
      #   account_timing: "",
      #   first_account_data: "",
      #   ret_url: "",
      #   payment_term_sec:  30
      #   service_name: "campfire",
      #   service_tel:  "012-3456-7890"
      # })
      # {"AccessID"=>"", "AccessPass"=>"", "StartURL" => "", "StartLimitDate"=> "", "ErrCode" => "", "ErrInfo" => ""}
      def exec_tran_continuance_au(options = {})
        name = "ExecTranAuContinuance.idPass"
        required = [:access_id, :access_pass, :order_id, :commodity, :ret_url, :service_name, :service_tel]
        if options[:site_id].present?
          required |= [:site_id, :site_pass, :member_id, :create_member]
        end
        assert_required_options(required, options)
        post_request name, options
      end

      #【ソフトバンクまとめて支払い継続課金決済】
      ## 22.1.2.2. 決済実行
      # これ以降の決済取引で必要となるトークンを返却します。
      # /payment/ExecTranSbContinuance.idPass
      # ShopID
      # ShopPass
      # AccessID
      # AccessPass
      # OrderID
      # ClientField1
      # ClientField2
      # ClientField3
      # RetURL
      # PaymentTermSec
      # ChargeDay
      # FirstMonthFreeFlag
      ### @return ###
      # AccessID
      # Token
      # StartURL
      # StartLimitDate
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.exec_tran_continuance_sb({
      #   shop_id:     "a41d83f1f4c908baeda04e6dc03e300c",
      #   shop_pass:   "d72eca02e28c88f98b9341a33ba46d5d",
      #   access_id: "139f8ec33a07c55f406937c52ce4473d",
      #   access_pass: "2689b204d2c17192fa35f9269fa7e744"",
      #   order_id: "597ae8c36120b23a3c00014e",
      #   client_field_1: "",
      #   client_field_2: "",
      #   client_field_3: "",
      #   ret_url: "",
      #   payment_term_sec: "",
      #   charge_day: "",
      #   first_month_free_flg: "",
      # })
      # {"AccessID"=>"", "Token"=>"", "StartURL" => "", "StartLimitDate"=> "", "ErrCode" => "", "ErrInfo" => ""}
      def exec_tran_continuance_sb(options = {})
        name = "ExecTranSbContinuance.idPass"
        required = [:access_id, :access_pass, :order_id, :ret_url, :charge_day, :first_month_free_flag]
        assert_required_options(required, options)
        post_request name, options
      end

      #【ドコモ継続課金サービス決済】
      ## 12.1.2.2. 決済実行
      # これ以降の決済取引で必要となるトークンを返却します。
      # /payment/ExecTranDocomoContinuance.idPass
      # ShopID
      # ShopPass
      # AccessID
      # AccessPass
      # OrderID
      # ClientField1
      # ClientField2
      # ClientField3
      # DocomoDisp1
      # DocomoDisp2
      # RetURL
      # PaymentTermSec
      # FirstMonthFreeFlag
      # ConfirmBaseDate
      # DispShopName
      # DispPhoneNumber
      # DispMailAddress
      # DispShopUrl
      ### @return ###
      # AccessID
      # Token
      # StartURL
      # StartLimitDate
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.exec_tran_continuance_docomo({
      #   shop_id:     "a41d83f1f4c908baeda04e6dc03e300c",
      #   shop_pass:   "d72eca02e28c88f98b9341a33ba46d5d",
      #   access_id: "139f8ec33a07c55f406937c52ce4473d",
      #   access_pass: "2689b204d2c17192fa35f9269fa7e744"",
      #   order_id: "597ae8c36120b23a3c00014e",
      #   client_field_1: "",
      #   client_field_2: "",
      #   client_field_3: "",
      #   docomo_disp_1: "",
      #   docomo_disp_2: "",
      #   ret_url: "",
      #   payment_term_sec: "",
      #   first_month_free_flag: "",
      #   confirm_base_date: "",
      #   disp_shop_name: "",
      #   disp_shop_number: "",
      #   disp_mail_address: "",
      #   disp_shop_url: "",
      # })
      # {"AccessID"=>"", "Token"=>"", "StartURL" => "", "StartLimitDate"=> "", "ErrCode" => "", "ErrInfo" => ""}
      def exec_tran_continuance_docomo(options = {})
        name = "ExecTranDocomoContinuance.idPass"
        required = [:access_id, :access_pass, :order_id, :ret_url, :first_month_free_flag, :confirm_base_date]
        assert_required_options(required, options)
        post_request name, options
      end

      #【auかんたん決済継続課金決済】
      ## 10.1.2.3. 支払手続き開始IFの呼出し
      # お客様をau ID認証画面に誘導します。
      # /payment/AuContinuanceStart.idPass
      # AccessID
      # Token
      ### @return ###
      # ShopID
      # OrderID
      # Status
      # TranDate
      # AuContinuAccountID
      # AuPayMethod
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.start_continuance_au({
      #   access_id: "139f8ec33a07c55f406937c52ce4473d",
      #   token: "",
      # })
      # {"ShopID"=>"", "OrderID"=>"", "Status" => "", "TranDate"=> "", "AuContinuAccountID" => "", "AuPayMethod" => "", "ErrCode" => "", "ErrInfo" => ""}
      def start_continuance_au(options = {})
        name = "AuContinuanceStart.idPass"
        required = [:access_id, :token]
        assert_required_options(required, options)
        post_request name, options
      end

      #【ドコモ継続課金サービス決済】
      ## 12.1.2.3. 支払手続き開始IFの呼出し
      # お客様をISPごとに適切な画面に誘導します。
      # /payment/DocomoContinuanceStart.idPass
      # AccessID
      # Token
      ### @return ###
      # ShopID
      # OrderID
      # Status
      # TranDate
      # DocomoSettlementCode
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.start_continuance_docomo({
      #   access_id: "139f8ec33a07c55f406937c52ce4473d",
      #   token: "",
      # })
      # {"ShopID"=>"", "OrderID"=>"", "Status" => "", "TranDate"=> "", "DocomoSettlementCode" => "", "ErrCode" => "", "ErrInfo" => ""}
      def start_continuance_docomo(options = {})
        name = "DocomoContinuanceStart.idPass"
        required = [:access_id, :token]
        assert_required_options(required, options)
        post_request name, options
      end

      #【ソフトバンクまとめて支払い継続課金決済】
      ## 22.1.2.3. 支払手続き開始IFの呼出し
      # お客様をソフトバンクセンターへ誘導します。
      # /payment/SbContinuanceStart.idPass
      # AccessID
      # Token
      ### @return ###
      # ShopID
      # OrderID
      # Status
      # TranDate
      # SbTrackingId
      # StartChargeMonth
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.start_continuance_sb({
      #   access_id: "139f8ec33a07c55f406937c52ce4473d",
      #   token: "",
      # })
      # {"ShopID"=>"", "OrderID"=>"", "Status" => "", "TranDate"=> "", "SbTrackingId" => "", "StartChargeMonth" => "", "ErrCode" => "", "ErrInfo" => ""}
      def start_continuance_sb(options = {})
        name = "SbContinuanceStart.idPass"
        required = [:access_id, :token]
        assert_required_options(required, options)
        post_request name, options
      end

      #【auかんたん決済継続課金決済】
      ## 10.2.2.1. 継続課金解約
      # 継続課金登録した取引に対して解約を行います。
      # /payment/AuContinuanceCancel.idPass
      # ShopID
      # ShopPass
      # AccessID
      # AccessPass
      # OrderID
      ### @return ###
      # OrderID
      # Status
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.start_continuance_au({
      #   access_id: "139f8ec33a07c55f406937c52ce4473d",
      #   token: "",
      # })
      # {"ShopID"=>"", "Status" => "", "ErrCode" => "", "ErrInfo" => ""}
      def cancel_continuance_au(options = {})
        name = "AuContinuanceCancel.idPass"
        required = [:access_id, :access_pass, :order_id]
        assert_required_options(required, options)
        post_request name, options
      end

      #【ソフトバンクまとめて支払い継続課金決済】
      ## 22.3.2.1. 継続課金解約
      # 継続課金登録した取引に対して解約を行います。
      # /payment/SbContinuanceCancel.idPass
      # ShopID
      # ShopPass
      # AccessID
      # AccessPass
      # OrderID
      ### @return ###
      # OrderID
      # Status
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.start_continuance_au({
      #   access_id: "139f8ec33a07c55f406937c52ce4473d",
      #   access_pass: "",
      #   order_id: "",
      # })
      # {"ShopID"=>"", "Status" => "", "ErrCode" => "", "ErrInfo" => ""}
      def cancel_continuance_sb(options = {})
        name = "SbContinuanceCancel.idPass"
        required = [:access_id, :access_pass, :order_id]
        assert_required_options(required, options)
        post_request name, options
      end

      #【ドコモ継続課金サービス決済】
      ## 12.3.2.1. 継続課金終了(利用者)
      # 携帯端末から終了を行います。
      # /payment/DocomoContinuanceUserEnd.idPass
      # ShopID
      # ShopPass
      # AccessID
      # AccessPass
      # OrderID
      # Amount
      # Tax
      # DocomoDisp1
      # DocomoDisp2
      # RetURL
      # PaymentTermSec
      # LastMonthFreeFlag
      ### @return ###
      # AccessID
      # Token
      # StartURL
      # StartLimitDate
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.user_end_continuance_docomo({
      #   access_id: "139f8ec33a07c55f406937c52ce4473d",
      #   access_pass: "",
      #   order_id: "",
      #   amount: "",
      #   tax: "",
      #   docomo_disp_1: "",
      #   docomo_disp_2: "",
      #   ret_url: "",
      #   payment_term_sec: "",
      #   last_month_free_flag: "",
      # })
      # {"AccessID"=>"", "Token" => "", "StartURL" => "", "StartLimitDate" => "", "ErrCode" => "", "ErrInfo" => ""}
      def user_end_continuance_docomo(options = {})
        name = "DocomoContinuanceUserEnd.idPass"
        required = [:access_id, :access_pass, :order_id, :amount, :ret_url, :last_month_free_flag]
        assert_required_options(required, options)
        post_request name, options
      end

      #【ドコモ継続課金サービス決済】
      ## 12.3.4.1. 継続課金終了(加盟店様)
      # 継続課金の終了を行います。
      # /payment/DocomoContinuanceShopEnd.idPass
      # ShopID
      # ShopPass
      # AccessID
      # AccessPass
      # OrderID
      # Amount
      # Token
      # LastMonthFreeFlag
      ### @return ###
      # OrderID
      # Status
      # Amount
      # Tax
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.stop_end_continuance_docomo({
      #   access_id: "139f8ec33a07c55f406937c52ce4473d",
      #   access_pass: ",
      #   order_id: ",
      #   amount: "",
      #   token: "",
      #   last_month_free_flg: "",
      # })
      # {"ShopID"=>"", "OrderID" => "", "Status" => "", "TranDate" => "", "DocomoSettlementCode" => "", "ErrCode" => "", "ErrInfo" => ""}
      def stop_end_continuance_docomo(options = {})
        name = "DocomoContinuanceShopEnd.idPass"
        required = [:access_id, :access_pass, :order_id, :amount, :last_month_free_flag]
        assert_required_options(required, options)
        post_request name, options
      end

      #【auかんたん決済継続課金決済】
      ## 10.3.2.1. 継続課金終了(加盟店様)
      # 課金日が到来し課金された課金に対して売上取消・返品を行います。
      # /payment/AuContinuanceChargeCancel.idPass
      # ShopID
      # ShopPass
      # AccessID
      # AccessPass
      # OrderID
      # CancelAmount
      # CancelTax
      # ContinuanceMonth
      ### @return ###
      # OrderID
      # ContinuanceMonth
      # Status
      # Amount
      # Tax
      # CancelAmount
      # CancelTax
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.charge_cancel_continuance_au({
      #   access_id: "139f8ec33a07c55f406937c52ce4473d",
      #   access_pass: ",
      #   order_id: ",
      #   cancel_amount: "",
      #   cancel_tax: "",
      #   continuance_month: "",
      # })
      # {"ShopID"=>"", "OrderID" => "", "Status" => "", "Amount" => "", "Tax" => "", "CancelAmount" => "", "CancelTax" => "", "ErrCode" => "", "ErrInfo" => ""}
      def charge_cancel_continuance_au(options = {})
        name = "AuContinuanceChargeCancel.idPass"
        required = [:access_id, :access_pass, :order_id, :cancel_amount, :cancel_tax, :continuance_month]
        assert_required_options(required, options)
        post_request name, options
      end

      #【ドコモ継続課金サービス決済】
      ## 12.5.2.1. 継続課金終了(加盟店様)
      # 課金データのキャンセル・返品を行います。
      # /payment/DocomoContinuanceCancelReturn.idPass
      # ShopID
      # ShopPass
      # AccessID
      # AccessPass
      # OrderID
      # CancelAmount
      # CancelTax
      # ContinuanceMonth
      ### @return ###
      # OrderID
      # Status
      # Amount
      # Tax
      # CancelAmount
      # CancelTax
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.cancel_return_continuance_docomo({
      #   access_id: "139f8ec33a07c55f406937c52ce4473d",
      #   access_pass: ",
      #   order_id: ",
      #   cancel_amount: "",
      #   cancel_tax: "",
      #   continuance_month: "",
      # })
      # {"ShopID"=>"", "OrderID" => "", "Status" => "", "Amount" => "", "Tax" => "", "CancelAmount" => "", "CancelTax" => "", "ErrCode" => "", "ErrInfo" => ""}
      def cancel_return_continuance_docomo(options = {})
        name = "DocomoContinuanceCancelReturn.idPass"
        required = [:access_id, :access_pass, :order_id, :cancel_amount, :continuance_month]
        assert_required_options(required, options)
        post_request name, options
      end

      #【ソフトバンクまとめて支払い継続課金決済】
      ## 22.2.2.1 課金データ取消
      # 課金データの取消を行います。
      # /payment/SbContinuanceChargeCancel.idPass
      # ShopID
      # ShopPass
      # AccessID
      # OrderID
      # ContinuanceMonth
      ### @return ###
      # OrderID
      # Status
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.charge_cancel_continuance_sb({
      #   access_id: "139f8ec33a07c55f406937c52ce4473d",
      #   OrderID: "",
      #   continuance_month: "",
      # })
      # {"OrderID"=>"", "Status" => "", "ErrCode" => "", "ErrInfo" => ""}
      def charge_cancel_continuance_sb(options = {})
        name = "SbContinuanceChargeCancel.idPass"
        required = [:access_id, :access_pass, :order_id, :continuance_month]
        assert_required_options(required, options)
        post_request name, options
      end
        
      #【Famipay決済】
      ## 4.3.2.1. 決済キャンセル・返品 接続先URL
      # 決済が完了した取引に対して決済内容のキャンセル・返品を行います。
      # /payment/FamipayCancelReturn.idPass
      # ShopID
      # ShopPass
      # AccessID
      # AccessPass
      # OrderID
      ### @return ###
      # OrderID
      # Status
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.cancel_return_docomo({
      #   access_id:     "a41d83f1f4c908baeda04e6dc03e300c",
      #   access_pass:   "d72eca02e28c88f98b9341a33ba46d5d",
      #   order_id:      "597ae8c36120b23a3c00014e"
      # })
      # {"OrderID"=>"597ae8c36120b23a3c00014e", "Status"=>"CANCEL or RETURN", "ErrCode" => "E01|E02", "ErrInfo" => "E01|E02"}
      def cancel_return_famipay(options = {})
        name = "FamipayCancel.idPass"
        required = [:access_id, :access_pass, :order_id]
        assert_required_options(required, options)
        post_request name, options
      end

      #【不正防止サービス(Red)】
      ## 2.1.2.3. 不正審査
      # カード決済情報(取引情報、顧客情報)を受け取り不正審査を行い結果を返却します。
      # /payment/ExecFraudScreening.idPass
      # ShopId
      # ShopPass
      # AccessID
      # AccessPass
      # OrderID
      ## @return ##
      # ErrCode
      # ErrInfo
      # RED_REQ_ID
      # RED_ORD_ID
      # RED_STAT_CD
      # RED_FRAUD_STAT_CD
      # RED_FRAUD_RSP_CD
      # RED_FRAUD_RSP_MSG
      # RED_FRAUD_REC_ID
      ### example ###
      # gmo.exec_fraud_screening({
      #   access_id:     "a41d83f1f4c908baeda04e6dc03e300c",
      #   access_pass:   "d72eca02e28c88f98b9341a33ba46d5d",
      #   order_id:      "597ae8c36120b23a3c00014e"
      # })
      # {"red_req_id":"350543690355","red_ord_id":"4824C272A349616D","red_stat_cd":"PENDING","red_fraud_stat_cd":"ACCEPT","red_fraud_rsp_cd":"0150","red_fraud_rsp_msg":"","red_fraud_rec_id":"000475071001RBL20190410073318546"}
      def exec_fraud_screening(options = {})
        name = "ExecFraudScreening.idPass"
        required = [:access_id, :access_pass, :order_id]
        assert_required_options(required, options)
        post_request name, options
      end

      private

        def api_call(name, args = {}, verb = "post", options = {})
          args.merge!({ "ShopID" => @shop_id, "ShopPass" => @shop_pass })
          api(name, args, verb, options) do |response|
            if response.is_a?(Hash) && !response["ErrInfo"].nil?
              raise APIError.new(response, locale)
            end
          end
        end

    end

  end
end
