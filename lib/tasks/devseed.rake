namespace 'db' do
  namespace 'seed' do
    desc "Dump development data into seeds.rb"
    # in order for this task to have access to active records, load 'environment'
    # https://stackoverflow.com/questions/876396/do-rails-rake-tasks-provide-access-to-activerecord-models
    task :dev => :environment do

      # Setup the default header image
      h = HeaderImage.new(title: "headerImage")
      h.picture.attach(io: File.open(Rails.root.join('storage/test.png')), filename: 'test.png', content_type: 'image/png')
      h.save!

      # basic user for development, all first-time users should be basic
      u = User.create!(
            email: "test@test.com",
            password: "test",
            firstname: "test",
            lastname: "testo"
          )
      u.basic!

      # Operator user for development
      u = User.create!(
            email: "beep@beep.com",
            password: "beep",
            firstname: "beep",
            lastname: "beepo"
          )
      u.operator!

      #admin user for development
      u = User.create!(
            email: "admin@admin.com",
            password: "admin",
            firstname: "admin",
            lastname: "admin"
          )
      u.admin!

      editor = User.find_by(email: "beep@beep.com")
      12.times do
        p = editor.posts.new(
            title: Faker::Fallout.quote,
            body: Faker::Lorem.paragraph(49)
        )
        p.main_picture.attach(io: File.open(Rails.root.join('storage/test.png')), filename: 'test.png', content_type: 'image/png')
        randomTime = "#{rand(1990..2018)}-#{rand(1..12)}-#{rand(1..29)} #{rand(0..24)}:#{rand(0..59)}:#{rand(0..50)}"
        p.created_at = randomTime
        p.pinned = false
        p.save!
      end
      puts "=-=-=-=-=-=-=-=-=-="
      puts "Seeded development"
      puts "=-=-=-=-=-=-=-=-=-="
    end
  end
end
