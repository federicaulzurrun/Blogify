# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create Users
puts "Creating users..."
first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')
puts "Users created!"

# Create 4 posts written by one of the users
puts "Creating posts..."
first_post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post')
Post.create(author: first_user, title: 'Post 2', text: 'This is my second post')
Post.create(author: first_user, title: 'Post 3', text: 'This is my third post')
Post.create(author: first_user, title: 'Post 4', text: 'This is my fourth post')
puts "Posts created!"

# Create at least 6 comments for one of the posts
puts "Creating comments..."
Comment.create(post: first_post, author: second_user, text: 'Hi Tom!')
Comment.create(post: first_post, author: second_user, text: 'Nice post!')
Comment.create(post: first_post, author: first_user, text: 'Thank you for sharing!')
Comment.create(post: first_post, author: second_user, text: 'Keep up the good work!')
Comment.create(post: first_post, author: first_user, text: 'Glad you liked it!')
Comment.create(post: first_post, author: second_user, text: 'Looking forward to more posts!')
puts "Comments created!"

# Update counters
puts "Updating counters..."
first_user.update_posts_counter
first_post.update_comments_counter
first_post.update_likes_count
puts "Counters updated!"

# User Model: Returns 3 most recent posts for a user
last_posts = first_user.recent_posts
puts "Recent Posts for User: #{first_user.name}"
last_posts.each do |post|
  puts "Post ID: #{post.id} | Title: #{post.title} | Text: #{post.text}"
end

# Method that updates the posts counter for a user
puts "Updating Posts Counter for User: #{first_user.name}"
first_user.update_posts_counter
puts "Posts Counter for User: #{first_user.name}: #{first_user.posts_counter}"

# Method which returns the 5 most recent comments for a given post
post_with_comments = Post.find_by(title: 'Hello')
post_author_name = post_with_comments.author.name
last_comments = post_with_comments.recent_comments
puts "Recent Comments for Post '#{post_with_comments.title}' by '#{post_author_name}': "
last_comments.each do |comment|
  puts "Comment ID: #{comment.id} | Text: #{comment.text}"
end

# Method that updates the comments counter for a post
puts "Updating Comments Counter for Post '#{post_with_comments.title}'"
post_with_comments.update_comments_counter
puts "There are #{post_with_comments.comments_counter} comments for post '#{post_with_comments.title}'"

# Method that updates the likes counter for a post
puts "Updating Likes Counter for Post '#{post_with_comments.title}'"
post_with_comments.update_likes_count
puts "There are #{post_with_comments.likes_counter} likes for post '#{post_with_comments.title}'"
