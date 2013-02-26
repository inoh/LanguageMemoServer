# -*- coding: utf-8 -*-

# アカウントの管理を行います。
# ユーザの管理はParseで行います。
class Account < Base
  attr_accessor :username, :password, :session_token

  validates :username, :presence => true, :unless => :input_token
  validates :password, :presence => true, :unless => :input_token

  # before_validation :checktoken

  # バリデーションがすべて成功した場合、ユーザの認証を行います。
  # _return_ :: 認証結果。sessionToken、成功。nil、失敗。
  # TODO リファクタリング必要
  def authenticate
    if valid?
      account_session_token || new_session_token
    end
  end

  private
    # username,passwordでParseの認証を行いユーザオブジェクトを返します。
    # _return_ :: ユーザオブジェクト。認証が失敗した場合は nil を返します。
    def parse_user
      @parse_user ||= Parse::User.authenticate(username, password)
    rescue Parse::ParseProtocolError => e
      nil
    end

    # session_tokenが入力済みか否か。
    def input_token
      session_token.present?
    end

    # ログイン済みのセッショントークン
    def account_session_token
      account_session = AccountSession.where(session_token: session_token).first
      if account_session
        account_session.session_token
      elsif parse_user
        parse_user[Parse::Protocol::KEY_USER_SESSION_TOKEN]
      end
    end

    # 新規セッショントークン
    def new_session_token
      if parse_user
        account_session = AccountSession.new do |account_session|
          account_session.parse_object_id = parse_user[Parse::Protocol::KEY_OBJECT_ID]
          account_session.session_token = parse_user[Parse::Protocol::KEY_USER_SESSION_TOKEN]
        end
        if account_session.save
          account_session.session_token
        end
      end
    end
end
