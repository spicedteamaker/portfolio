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
        randomTime = "#{rand(1990..2018)}-#{rand(1..12)}-#{rand(1..29)} #{rand(0..24)}:#{rand(0..59)}:#{rand(0..50)}"
        p.created_at = randomTime
        p.save!
      end

      rand(7..15).times do
        p = PortfolioPost.create
        rand(1..7).times do
          p.pictures.attach(io: File.open(Rails.root.join('storage/test.png')), filename: 'test.png', content_type: 'image/png')
        end
        p.save!
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
