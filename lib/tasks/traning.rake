desc 'run training tests'
task :training do
  Rake::Task["spec:vulnerabilities"].invoke
end

desc 'make keys for users'
task :make_iv => :environment do
  User.all.each do |user|
    k = user.work_info.build_key_management(:user_id => user.id, :iv => SecureRandom.hex(32)) if !user.work_info.nil? && user.work_info.key_management.nil?
    k.save
  end
end