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
  def authenticate
    if valid?
      account_session = AccountSession.where(session_token: session_token).first
      if account_session
        account_session.session_token
      end
    end
  end

  # ログイン認証
  # _return_ :: 認証結果。sessionToken、成功。nil、失敗。
  def login
    if valid? && parse_user
      account_session = AccountSession.find_by_session_token(parse_user[Parse::Protocol::KEY_USER_SESSION_TOKEN])
      unless account_session
        account_session = AccountSession.new do |account_session|
          account_session.parse_object_id = parse_user[Parse::Protocol::KEY_OBJECT_ID]
          account_session.session_token = parse_user[Parse::Protocol::KEY_USER_SESSION_TOKEN]
        end
        account_session.save!
      end
      account_session.session_token
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
end
