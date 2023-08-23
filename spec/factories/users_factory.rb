FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password123' }  # テストのためにデフォルトのパスワードを設定
  end

  factory :admin_user, class: 'User' do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'adminpassword' }  # テストのためにデフォルトのパスワードを設定
    #admin { true }
  end
end
