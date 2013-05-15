require 'socket'
module Httpserver
	class WebServer
		include Mime
		include Response
		
		def initialize
			port = ARGV.first.to_i
			port = 8080 if port == 0
			webserver = TCPServer.new('0.0.0.0', port)
			puts "Listening on http://0.0.0.0:#{port}"
			puts "Ctrl + c will break"
			base_dir = Dir.new(".")

			while (session = webserver.accept)
				request = session.gets.gsub(/GET\ \//, '').gsub(/\ HTTP.*/, '').chomp
				resource = request
				resource = "." if resource == ""
				
				# Is the user trying to go to a file that doesn't exist?
				if !File.exists?(resource)
					session.print response(code:404, content:"404 - Resource cannot be found.")
					session.close
					next
				end

				# if the resource is a directory, lets print out the contents
				if File.directory?(resource)
					session.print response(code:200)
					base_dir = Dir.new("./#{request}")

					base_dir.entries.each do |file|
						dir_sign = ""
						base_path = resource + "/"
						base_path = "" if resource == ""
						resource_path = base_path + file
						dir_sign = "/" if File.directory?(resource_path)

						# If this entry is the ".." then build the breadcrumb directory
						if file == ".."
						 	breadcrumb = "/" + base_path.split('/')[0..-2].join('/')
							session.print("<a href='#{breadcrumb}'>#{file}</a><br />")
						else
							# Otherwise, link to the file
							session.print("<a href='/#{resource_path}'>#{file}#{dir_sign}</a><br />")
						end
					end
				else
					# We are looking at a piece of content here!
					session.print response(:code => 200, :mime => get_content_type(resource))
					File.open(resource, "rb") do |file|
						while (!file.eof?) do
							buffer = file.read(256)
							session.write(buffer)
						end
			    end
			  end
			  session.close
			end
		end
	end
end
