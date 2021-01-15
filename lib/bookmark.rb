require 'pg'

class Bookmark
  attr_reader :id, :url, :title
  def initialize(id:, url:, title:)
    @id = id.to_i
    @url = url
    @title = title
  end

  def self.all()
    res = []
    connection = self.connect_to_db()

    result_tuples = connection.exec('SELECT * FROM bookmarks')
    for record in result_tuples do
      res << Bookmark.new(id: record['id'], url: record['url'], title: record['title'])
    end

    return res
  end

  def self.create(url:, title:)
    connection = self.connect_to_db()

    result = connection.exec("INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') RETURNING id, title, url;")
    return Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.delete(id:, url:, title:)

  end

  private

  def self.connect_to_db()
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    return connection
  end
end
