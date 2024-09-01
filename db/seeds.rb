# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(email: 'hai@admin.com', password: 'password', password_confirmation: 'password', name: 'Hai', role: User.roles[:admin])
User.create(email: 'user@gmail.com', password: 'password', password_confirmation: 'password', name: "Phuc")

elapsed = Benchmark.measure do
  posts = []
  1000.times do |x|
    puts "Creating post #{x}"
    post1 = Post.new(title: "Title post of hai #{x}", body: "Body #{x} Words go here idk", user: User.first)
    post2 = Post.new(title: "Title post of user #{x}", body: "Body #{x} Words go here itx", user: User.last)

    posts.push(post1)
    posts.push(post2)

    10.times do |y|
      puts "Creating comment #{y} for post #{x}"
      post1.comments.build(body: "Comment Post 1 #{y}", user: User.last)
      post2.comments.build(body: "Comment Post 2 #{y}", user: User.first)
    end
  end
  Post.import(posts, recursive: true)
end

puts "Elapsed time is #{elapsed.real} seconds"
