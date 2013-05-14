module Httpserver
	module Response
		def response(attrs)
			code = attrs[:code].to_i
			mime = attrs[:mime] || "text/html"
			content = attrs[:content] || ""
			status = ""

			case(code)
				when 200
					status = "OK"
				when 404
					status = "Object Not Found"
					return "HTTP/1.1 #{code}/#{status}\r\nServer HttpServer\r\n\r\n#{content}"
			end

			"HTTP/1.1 #{code}/#{status}\r\nContent-type:#{mime}\r\n\r\n#{content}"
		end
	end
end