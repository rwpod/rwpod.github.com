Dir.glob("content/posts/**/*.html.md") { |f| File.rename(f,f.gsub(/\Acontent\/posts\/(\d{4})\/\d{2}-\d{2}-(.*)/i,'content/posts/\1/\2')) }
Dir.glob("content/posts/**/*.html.md") { |f| File.rename(f,f.gsub(/(.*).html.md\z/i,'\1.md')) }
