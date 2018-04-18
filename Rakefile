# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

# ------ Assignment 4 solution ------

require 'rubygems/package'

desc "Test shell command"
task :testls do
  return_fluf = %x[date +"%d%m%y%H%M%S"].chomp()
  puts "A#{return_fluf}A"
end

desc "Archive specified path to tar.gz"
task :archive  do |t,args|

  NEW_ARCHIVE_PATH = "build/"
  NEW_ARCHIVE_SUFF = ".tar.gz"

  path = ENV["ARCPATH"] ? "#{File.expand_path(ENV["ARCPATH"])}/" : Dir.pwd
  raise "path #{path} does not exist" unless Dir.exist?(path)

  exclude_suff = ENV["EXCLUDE"].split(",") if ENV["EXCLUDE"]

  files_to_arc = Rake::FileList.new("#{path}*")

  # Not supporting taring directories at this version
  files_to_arc.exclude() { |file_name| exclude_suff.include?(File.extname(file_name)) || Dir.exist?(file_name) } if exclude_suff

  begin
    Dir.mkdir("#{path}#{NEW_ARCHIVE_PATH}") unless File.exist?("#{path}#{NEW_ARCHIVE_PATH}")
  rescue Exception=>e
    puts "Error creating sub directory build: #{e}"
  else
    arc_timestamp = %x[date +"%d%m%y%H%M%S"].chomp()
    arc_file_name = path + NEW_ARCHIVE_PATH + File.basename(path).gsub(/[^a-zA-Z0-9]/, '_') + arc_timestamp + NEW_ARCHIVE_SUFF
    begin
      arc_file = File.open(arc_file_name,"w")
    rescue Exception=>e
      puts "Error opening archive file: #{e}"
    else
      begin
        puts "Writing archive #{arc_file_name}:"
        Zlib::GzipWriter.wrap(arc_file) do |gz_file|
          Gem::Package::TarWriter.new(gz_file) do |tar|
            files_to_arc.each do |file_name|
              begin
                in_file = File.open(file_name,"r")
              rescue Exception=>e
                puts "Error opening input file #{file_name} : #{e}"
              else
                begin
                  print "   Adding #{file_name} to archive... "
                  tar.add_file_simple(file_name,File.stat(file_name).mode,File.stat(file_name).size) {|io| io.write(File.read(file_name))}
                  puts "Complete!"
                rescue Exception=>e
                  puts "Error writing #{file_name} to #{arc_file_name} : #{e}"
                ensure
                  in_file.close()
                end
              end
            end
          end
        end
        puts "Finished writing archive #{arc_file_name}."
      rescue Exception=>e
        puts "Error writing archive: #{e}"
      ensure
        arc_file.close()
      end
    end
  end
end
