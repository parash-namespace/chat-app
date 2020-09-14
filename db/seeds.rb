User.create(
	email: "test@gmail.com",
	password: 'test1234',
	password_confirmation: 'test1234'
)

1.upto(5) do |i|
  User.create(
    email: "test#{i}@gmail.com",
    password: 'test1234',
    password_confirmation: 'test1234'
  )
end