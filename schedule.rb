set :job_template, ":job"
job_type :backup, 'backup perform -t :task'

eval File.read('/Backup/schedule.rb')
