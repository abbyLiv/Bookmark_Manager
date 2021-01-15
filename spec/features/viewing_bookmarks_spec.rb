feature 'Viewing bookmarks' do
  scenario 'A user can see bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    connection.exec("INSERT INTO bookmarks (url, title) VALUES ('link1', 'titleone')")
    connection.exec("INSERT INTO bookmarks (url, title) VALUES ('link2', 'titletwo')")
    connection.exec("INSERT INTO bookmarks (url, title) VALUES ('link3', 'titlethree')")

    visit('/bookmarks')

    expect(page).to have_content "titleone"
    expect(page).to have_content "titletwo"
    expect(page).to have_content "titlethree"
  end
end
