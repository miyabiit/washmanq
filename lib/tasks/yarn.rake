namespace :yarn do
  desc "Install all JavaScript dependencies as specified via Yarn"
  task :install do
    # notghing to do ...
    exit(true)
  end
end

task(:default).clear.enhance(['yarn:install'])

# Run Yarn prior to Sprockets assets precompilation, so dependencies are available for use.
if Rake::Task.task_defined?("assets:precompile")
  Rake::Task["assets:precompile"].enhance [ "yarn:install" ]
end
