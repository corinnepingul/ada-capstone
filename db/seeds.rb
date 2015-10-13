require 'csv'

CSV.foreach("db/users.csv", headers: true, header_converters: :symbol, converters: :all) do |row|
  User.create(
    username: row[:username],
    email: row[:email],
    password_digest: row[:password_digest],
    phone_number: row[:phone_number],
    locale: row[:locale]
  )
end

CSV.foreach("db/moments.csv", headers: true, header_converters: :symbol, converters: :all) do |row|
  Moment.create(
    date: row[:date],
    body: row[:body],
    user_id: row[:user_id]
  )
end

CSV.foreach("db/tags.csv", headers: true, header_converters: :symbol, converters: :all) do |row|
  Tag.create(
    body: row[:body]
  )
end
