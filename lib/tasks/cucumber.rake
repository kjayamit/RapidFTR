# We have edited this file at our own peril. We should consider refactoring these
# tasks so we don't fly in the face of the automatically generated warning below.
#
# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a 
# newer version of cucumber-rails. Consider adding your own code to a new file 
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.




unless ARGV.any? {|a| a =~ /^gems/} # Don't load anything when running the gems:* tasks

if ENV['CUCUMBER_OPTS'] =~ /Teamcity/
  # Don't let TeamCity override our multiple profiles.
  # The ENV var overrides while the cucumber_opts rake task attribute works with profile.
  puts "Removing ENV[CUCUMBER_OPTS] (#{ENV['CUCUMBER_OPTS']}) to use it in combination with task-specific profiles in TeamCity."
  cucumber_opts = ENV['CUCUMBER_OPTS']
  ENV['CUCUMBER_OPTS'] = nil
elsif ENV['CUCUMBER_OPTS']
  puts "Using CUCUMBER_OPTS #{ENV['CUCUMBER_OPTS'].inspect}, which will override our task-specific profiles. (This is probably not what you want.)"
end

vendored_cucumber_bin = Dir["#{::Rails.root}/vendor/{gems,plugins}/cucumber*/bin/cucumber"].first
$LOAD_PATH.unshift(File.dirname(vendored_cucumber_bin) + '/../lib') unless vendored_cucumber_bin.nil?

begin
  require 'cucumber/rake/task'

  namespace :cucumber do
    # cucumber:webrat won't work now that we've upgraded to Rails 3.
    Cucumber::Rake::Task.new({:webrat => 'db:test:prepare'}, 'Run all webrat features') do |t|
      t.binary = vendored_cucumber_bin # If nil, the gem's binary is used.
      t.fork = true # You may get faster startup if you set this to false
      t.profile = 'default'
      t.cucumber_opts = cucumber_opts if cucumber_opts
    end

    Cucumber::Rake::Task.new({:headless => 'db:test:prepare'}, 'Run all features that should pass in headless mode') do |t|
      t.binary = vendored_cucumber_bin # If nil, the gem's binary is used.
      # t.fork = true # You may get faster startup if you set this to false
      t.profile = 'headless'
      t.cucumber_opts = cucumber_opts if cucumber_opts
    end

    Cucumber::Rake::Task.new({:browser => 'db:test:prepare'}, 'Run all features that should pass in a browser') do |t|
      t.binary = vendored_cucumber_bin
      # t.fork = true # You may get faster startup if you set this to false
      t.profile = 'browser'
      t.cucumber_opts = cucumber_opts if cucumber_opts
    end

    Cucumber::Rake::Task.new({:headless_wip => 'db:test:prepare'}, 'Run features that are being worked on in headless mode') do |t|
      t.binary = vendored_cucumber_bin
      t.fork = true # You may get faster startup if you set this to false
      t.profile = 'headless_wip'
    end

    Cucumber::Rake::Task.new({:browser_wip => 'db:test:prepare'}, 'Run features that are being worked on in browser mode') do |t|
      t.binary = vendored_cucumber_bin
      t.fork = true # You may get faster startup if you set this to false
      t.profile = 'browser_wip'
    end

    Cucumber::Rake::Task.new(:features1) do |t|
      t.cucumber_opts = "--format pretty"
      t.rcov = true
    end

    Cucumber::Rake::Task.new({:headless_junit => 'db:test:prepare'}, 'Run all features that should pass in headless mode') do |t|
      t.binary = vendored_cucumber_bin # If nil, the gem's binary is used.
                                       # t.fork = true # You may get faster startup if you set this to false
      t.profile = 'headless'
      t.cucumber_opts = "-f junit --out . --tags @roles"
    end

    task :features => 'db:test:prepare'
    desc 'Run all features in headless and browser modes'
    task :all => [:headless, :browser]
  end

  desc 'Alias for cucumber:headless and cucumber:browser'
  task :cucumber => 'cucumber:all'

  task :features => :cucumber do
    STDERR.puts "*** The 'features' task is deprecated. See rake -T cucumber ***"
  end
rescue LoadError
  desc 'cucumber rake task not available (cucumber not installed)'
  task :cucumber do
    abort 'Cucumber rake task is not available. Be sure to install cucumber as a gem or plugin'
  end
end

end
