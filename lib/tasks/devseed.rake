namespace 'db' do
  namespace 'seed' do
    desc "Dump development data into seeds.rb"
    # in order for this task to have access to active records, load 'environment'
    # https://stackoverflow.com/questions/876396/do-rails-rake-tasks-provide-access-to-activerecord-models
    task :dev => :environment do

      15.times do
        p = Post.create(
            title: Faker::Fallout.quote,
            body: Faker::Lorem.paragraph(49)
        )
        p.main_picture.attach(io: File.open(Rails.root.join('storage/test.png')), filename: 'test.png', content_type: 'image/png')
        p.save
      end

      # basic user for development, all first-time users should be basic
      u = User.create!(
            email: "test@test.com",
            password: "test"
          )
      u.basic!

      # Operator user for development
      u = User.create!(
            email: "beep@beep.com",
            password: "beep"
          )
      u.operator!

      #admin user for development
      u = User.create!(
            email: "admin@admin.com",
            password: "admin"
          )
      u.admin!
      puts "=-=-=-=-=-=-=-=-=-="
      puts "Seeded development"
      puts "=-=-=-=-=-=-=-=-=-="
    end
  end
end
