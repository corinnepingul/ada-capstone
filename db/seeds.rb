require 'csv'

CSV.foreach("db/users.csv", headers: true, header_converters: :symbol, converters: :all) do |row|
  User.create(
    username: row[:username],
    email: row[:email],
    password: row[:password],
    password_confirmation: row[:password_confirmation],
    phone_number: row[:phone_number],
    country_code: row[:country_code],
    locale: row[:locale],
    verified: true
  )
end

CSV.foreach("db/moments.csv", headers: true, header_converters: :symbol, converters: :all) do |row|
  row[:media_url] = nil if row[:media_url] == "nil"

  Moment.create(
    date: DateTime.parse(row[:date]),
    body: row[:body],
    user_id: row[:user_id],
    media_url: row[:media_url]
  )
end

CSV.foreach("db/tags.csv", headers: true, header_converters: :symbol, converters: :all) do |row|
  Tag.create(
    body: row[:body]
  )
end
