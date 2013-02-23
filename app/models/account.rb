# -*- coding: utf-8 -*-

# アカウントの管理を行います。
# ユーザの管理はParseで行います。
class Account < Base
  attr_accessor :username, :password

  validates :username, :presence => true
  validates :password, :presence => true

  # バリデーションがすべて成功した場合、ユーザの認証を行います。
  # _return_ :: 認証結果。true、成功。false、失敗。
  def authenticate
    valid? && parse_user != nil
  end

  private
    # username,passwordでParseの認証を行いユーザオブジェクトを返します。
    # _return_ :: ユーザオブジェクト。認証が失敗した場合は nil を返します。
    def parse_user
      @parse_user ||= Parse::User.authenticate(username, password)
    rescue Parse::ParseProtocolError => e
      nil
    end
end
