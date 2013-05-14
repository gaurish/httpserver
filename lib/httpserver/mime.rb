module Httpserver
	module Mime
		def get_content_type(path)
		  ext = File.extname(path)
		  return "text/html"  if ext == ".html" or ext == ".htm"
		  return "text/plain" if ext == ".txt"
		  return "text/css"   if ext == ".css"
		  return "image/jpeg" if ext == ".jpeg" or ext == ".jpg"
		  return "image/gif"  if ext == ".gif"
		  return "image/png"	if ext == ".png"
		  return "image/bmp"  if ext == ".bmp"
		  return "text/plain" if ext == ".rb"
		  return "text/xml"   if ext == ".xml"
		  return "text/xml"   if ext == ".xsl"
		  return "text/html"
		end
	end
end