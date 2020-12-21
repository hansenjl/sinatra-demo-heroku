user = User.create(email: "hansen@gmail.com", password: "abc")

Movie.create(title: "Captain America", user_id: user.id )
Movie.create(title: "Titanic", user_id: user.id )