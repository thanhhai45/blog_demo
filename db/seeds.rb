# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(email: 'hai@admin.com', password: 'password', password_confirmation: 'password', name: 'Hai', role: User.roles[:admin])
User.create(email: 'user@gmail.com', password: 'password', password_confirmation: 'password', name: "Phuc")

posts = []
comments = []

elapsed = Benchmark.measure do
  1000.times do |x|
    puts "Creating post #{x}"
    post = Post.new(title: "Title #{x}", body: "Body #{x} Words go here idk", user_id: User.first.id)

    posts.push(post)

    10.times do |y|
      puts "Creating comment #{y} for post #{x}"
      comment = post.comments.new(body: "Comment #{y}", user_id: User.last.id)

      comments.push(comment)
    end
  end
end

Post.import(posts)
Comment.import(comments)

puts "Elapsed time is #{elapsed.real} seconds"