# be rake db:drop && be rake db:create && be rake db:migrate && be rake db:seed
module Seed
  def self.run
    User.create!(name: "Sean", email: "nase00@gmail.com", twitter: "@NaseZero", password: "test", is_admin: true)
    User.create!(name: "testUser1", email: "testUser1@whatever.com", twitter: "@testUser1", password: "test1", is_admin: false)
    User.create!(name: "testUser2", email: "testUser2@whatever.com", twitter: "@testUser2", password: "test2", is_admin: false)

    10.times do
      title = Faker::Lorem.word
      description = Faker::Lorem.sentence(5)
      author_id = rand(1..3)
      Blog.create(title: title, description: description, author_id: author_id)
    end

    20.times do
      title = Faker::Lorem.word
      content = Faker::Lorem.sentence(10)
      blog_id = rand(1..5)
      poster_id = rand(1..3)
      Post.create(title: title, content: content, blog_id: blog_id, poster_id: poster_id)
    end

    10.times do
      title = Faker::Lorem.word
      description = Faker::Lorem.sentence(5)
      creator_id = rand(1..3)
      Gallery.create(title: title, description: description, creator_id: creator_id)
    end

    20.times do
      title = Faker::Lorem.word
      content = Faker::Lorem.sentence(10)
      gallery_id = rand(1..5)
      Project.create(title: title, content: content, gallery_id: gallery_id)
    end
  end
end
