User.create_or_find_by(email: "admin@domain.com", password: "test123")

100.times do |index|
  Post.create title: "Draft Post #{index + 1}", content: "Sample draft blog post.", type: "DraftPost"
end

100.times do |index|
  Post.create title: "Published Post #{index + 1}", content: "Sample published blog post.", type: "PublishedPost", published_at: Time.current
end

100.times do |index|
  Post.create title: "Scheduled Post #{index + 1}", content: "Sample scheduled blog post.", type: "ScheduledPost", published_at: Date.tomorrow
end