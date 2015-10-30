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

  moment = Moment.new(
    date: DateTime.parse(row[:date]),
    body: row[:body],
    user_id: row[:user_id],
    media_url: row[:media_url]
  )

  unless row[:created_at] == "nil"
    moment[:created_at] = row[:created_at]
  end

  moment.save
end

CSV.foreach("db/tags.csv", headers: true, header_converters: :symbol, converters: :all) do |row|
  Tag.create(
    body: row[:body]
  )
end
