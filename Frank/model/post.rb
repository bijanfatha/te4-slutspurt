
class Post < DBhandler
  table_name("Franks")
  column(id: "serial")
  column(title: "text")
  column(content: "text")

  create_table(false)

  def initialize(hash)
    @title = hash[:title]
    @content = hash[:content]
  end
  
end
