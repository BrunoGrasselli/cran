desc 'Updates R Packages'
task 'update_packages' => :environment do
  puts "Starting packages updater"

  updater = PackagesUpdater.new
  updater.update

  puts "Done!"
end
