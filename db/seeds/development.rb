puts 'Seeding development database...'

hai = User.create!(email: 'hai@gmail.com',
                   password: 'password',
                   password_confirmation: 'password',
                   first_name: 'Hai',
                   last_name: 'Le',
                   role: User.roles[:admin])

phuc = User.create!(email: 'phuc@gmail.com',
                    password: 'password',
                    password_confirmation: 'password',
                    first_name: 'Phuc',
                    last_name: 'Huynh',
                    role: User.roles[:user])

Address.first_or_create!(street: '154 Mai Xuan Thuong',
                         city: 'HCM',
                         state: 'District 6',
                         country: 'VN',
                         zip: '123456',
                         user: hai)

Address.first_or_create!(street: '116 Bui Tu Toan',
                         city: 'HCM',
                         state: 'District Binh Tan',
                         country: 'VN',
                         zip: '123456',
                         user: phuc)

elapsed = Benchmark.measure do
  posts = []
  100.times do |x|
    puts "Creating post #{x}"
    post1 = Post.new(title: "Title post of hai #{x}", body: "Body #{x} Words go here idk", user: hai)
    post2 = Post.new(title: "Title post of user #{x}", body: "Body #{x} Words go here itx", user: phuc)

    posts.push(post1)
    posts.push(post2)

    10.times do |y|
      puts "Creating comment #{y} for post #{x}"
      post1.comments.build(body: "Comment Post 1 #{y}", user: phuc)
      post2.comments.build(body: "Comment Post 2 #{y}", user: hai)
    end
  end
  Post.import(posts, recursive: true)
end

puts "Elapsed time is #{elapsed.real} seconds"
