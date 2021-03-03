# == Schema Information
#
# Table name: email_access_tokens
#
#  id            :bigint           not null, primary key
#  email_address :citext           not null
#  token         :string           not null
#
# Indexes
#
#  index_email_access_tokens_on_token  (token)
#
class EmailAccessToken < ApplicationRecord
  validates_presence_of :token
  validates_presence_of :email_address
  validate :one_or_more_valid_email_addresses

  scope :by_raw_token, ->(raw_token) do
    where(token: Devise.token_generator.digest(EmailAccessToken, :token, raw_token))
  end

  private

  def one_or_more_valid_email_addresses
    unless email_address.present? && email_address.split(",").map { |email| ValidEmail2::Address.new(email).valid? }.all?
      errors.add(:email_address, :invalid)
    end
  end
end