require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "John", email: "john@example.com", password: "password", admin: true)
  end

  test "get new articles form and create article" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post articles_path, params:{article: {name: "New article", description: "Another great text!"}}
      follow_redirect!
    end
    assert_template 'articles/index'
    assert_match "New article", response.body
  end

  test "invalid article submission results in failure" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_no_difference 'Article.count' do
      post articles_path, params:{article: {name: "", description: ""}}
    end
    assert_template 'articles/new'
    assert_select 'h2.card-title'
    assert_select 'div.card-body'
  end

end
