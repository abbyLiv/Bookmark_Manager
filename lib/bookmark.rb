require 'pg'

class Bookmark
  def self.all()
    res = []
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    
    result_tuples = connection.exec('SELECT * FROM bookmarks')
    for record in result_tuples do
      res << record["url"]
    end
    return res
  end
end
