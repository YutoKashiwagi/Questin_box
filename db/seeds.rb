require 'faker'

Faker::Config.locale = :ja

guest = User.create(
  name: 'ゲスト',
  email: 'guest@guest.com',
  password: 'password',
  role: :guest
)

hoge = User.create(
  name: "hogehoge",
  email: "hogehoge@hogehoge.com",
  password: "hogehoge"
)

tanaka = User.create(
  name: '田中太郎',
  email: 'tanaka@tanaka.com',
  password: 'password'
)

question1 = Question.create(
  user_id: tanaka.id,
  title: '数学のオススメ参考書',
  content: '現在高校一年生です。理系の大学に進学したいので、オススメの参考書を教えてください'
)

answer1 = question1.answers.create(
  user_id: hoge.id,
  content: '基礎問題精講シリーズがオススメです'
)

10.times do |n|
  name = Faker::Name.name
  email = "email-#{n + 1}@email.com"
  password = "password"
  User.create!(
    name: name,
    email: email,
    password: password
  )
end

# Question
User.ids.each do |u_id|
  Question.create!(
    user_id: u_id,
    title: "question title",
    content: "question content"
  )
end

Question.ids.each do |q_id|
  Answer.create(
    user_id: User.ids.sample,
    question_id: q_id,
    content: '頑張ってください'
  )
end

users = User.all
user1 = User.first
users.each do |user|
  user.follow(user1)
end

# Category
subjects = %w[現代文 漢文 古文 世界史 日本史 地理 現代社会 倫理 政治 経済 数学I・A 数学II・B 数学III 物理 化学 生物 地学 英語]
subjects.each do |subject|
  Category.create(
    name: subject
  )
end
