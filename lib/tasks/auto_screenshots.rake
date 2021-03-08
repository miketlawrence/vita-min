require 'cgi'
require 'webrick'

# To generate screenshots based on rspec feature specs, run:
#
# $ rake auto_screenshots:generate_screenshots auto_screenshots:generate_assets auto_screenshots:generate_website
#
# If you want to preview the output, run this & visit http://localhost:8000/
#
# $ rake auto_screenshots:serve
#
# If you want to edit the way the website is generated, consider:
#
# $ rake auto_screenshots:generate_website auto_screenshots:serve

namespace :auto_screenshots do
  desc "Takes screenshots of the app via rspec feature specs"
  task :generate_screenshots do |_task|
    # Write to a directory in /tmp to avoid having screenshots get indexed by RubyMine
    OUT = "public/walkthroughs"
    if File.exists?(OUT)
      raise StandardError, "ERROR: public/walkthroughs already exists.\n\nPlease run: rm -rf public/walkthroughs"
    end

    # Make sure all feature spec files are safe to join with `system()`
    specs = Dir.glob("spec/features/**/*_spec.rb").sort
    specs.each do |spec_path|
      if spec_path != Shellwords.escape(spec_path)
        raise StandardError, "Exiting due to strange unsafe spec name: #{spec_path}"
      end
    end
    puts("Running #{specs.join(" ")}")
    system("CAPYBARA_WALKTHROUGH_SCREENSHOTS=1 bundle exec rspec #{specs.join(' ')} --format failures", exception: true)
  end

  task :generate_assets do |_task|
    INITIAL_WORKING_DIR = Dir.pwd
    OUT = "public/walkthroughs"
    # Copy assets & JS packs in
    FileUtils.mkdir_p("#{OUT}/")
    system("RAILS_ENV=test rails assets:precompile", exception: true)
    FileUtils.cp_r("public/assets/.", "#{OUT}/assets")

    system("RAILS_ENV=test ./bin/webpack", exception: true)
    FileUtils.cp_r("public/packs-test/.", "#{OUT}/packs-test")
  end

  task :generate_website do |_task|
    INITIAL_WORKING_DIR = Dir.pwd
    OUT = "public/walkthroughs"
    # Generate start of overall index.html
    File.open("#{OUT}/index.html", "w") do |f|
      today = DateTime.now.strftime("%Y-%m-%d")
      f << "<p style='text-align: center; line-height: 2.5rem; font-size: 1.9rem; background-color: #D70A40; font-weight: bold; color: white; font-family: \"Helvetica Neue\", -apple-system, sans-serif;'>"
      f << "This site is for example purposes only. If you want help with your taxes, go to <a href='https://www.getyourrefund.org/'>GetYourRefund.org.</a>"
      f << "</p>"
      f << "<h2>Screenshot collections</h2>"
      f << "<p>"
      f << "These screenshots are generated by automated test suites maintained by engineering. "
      f << "You can scroll up/down within the screenshots or Cmd-F to search them when you see them. Last updated on #{today}."
      f << "</p>"
    end

    # Generate index.html for each example
    Dir.glob("public/walkthroughs/**/00000.html").sort.each do |first_screenshot_path|
      spec = File.read(first_screenshot_path.sub(".html", ".spec")).sub(%r{^./}, "")
      dirname = File.dirname(first_screenshot_path)
      Dir.chdir(dirname) do
        title = CGI.unescape(dirname.gsub("public/walkthroughs/", "").gsub("/", " - "))
        File.open("index.html", "w") do |example_index|
          example_index << "<p><a href='/'>Home</a></p>"
          example_index << "<h1>#{title}</h1>"
          example_index << "<p><a href='https://github.com/codeforamerica/vita-min/tree/main/#{spec}'>#{spec}</a></p>"

          Dir.glob("0*.html").sort.each do |html_file|
            path = File.read(html_file.sub(".html", ".path"))
            example_index << "<p style='text-align: center;'>"
            example_index << "https://demo.getyourrefund.org#{path}"
            example_index << "</p>"
            example_index << "<iframe style='margin: 0 auto; display: block;' height=800 width=800 src='#{html_file}'></iframe><hr>"
          end
        end
      end
    end

    # Add each example to overall index.html
    Dir.chdir(INITIAL_WORKING_DIR) do
      open("#{OUT}/index.html", "a") do |f|
        Dir.glob("public/walkthroughs/**/00000.html").sort.each do |first_screenshot_path|
          dirname = File.dirname(first_screenshot_path).gsub("public/walkthroughs/", "")
          title = CGI.unescape(dirname)
          f << "<li>"
          f << "<a href='#{dirname}/'>#{title}</a></li>"
          f << "</li>"
        end
        f << "</ul>"
      end
    end
  end
end
