namespace :db do
  desc "Remake database data"
  task remake_db: :environment do
    %w(db:drop db:create db:migrate db:seed).each do |task|
      Rake::Task[task].invoke
    end
    puts "The data was created successfully."
  end
end
