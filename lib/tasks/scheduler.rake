desc "This task is called by the Heroku scheduler add-on"
task :close_pending_renting_overdue => :environment do
  puts "Updating rentings..."
  @rentings = Renting.where("status = 'Pending' and date < ? ", Date.today)
  @rentings.each do |renting|
    renting.status = "Declined"
    renting.save
    p renting
  end
  puts "done."
end
