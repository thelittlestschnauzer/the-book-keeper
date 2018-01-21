class BooksController <ApplicationController

  get "/booklists" do
    if logged_in?
      @books = Book.all
      erb :'books/index'
    else
      redirect to '/login'
    end
  end

  get "booklists/new" do
    if logged_in?
      erb :"books/new"
    else
      redirect to "/login"
    end
  end

  post "booklists" do
    if params[:title] == "" || params[:description] == ""
      redirect to "booklists/new"
    else
      @book = current_user.books.create(params)
      redirect to "booklists/#{@book.id}"
    end
  end

  get "/booklists/:id" do
    if logged_in?
      @book = Book.findy_by_id(params[:id])
      erb :"/booklists/show"
    else
      redirect to "/login"
    end
  end

  get "/booklists/:id/edit" do
    if logged_in?
      @book = Book.findy_by_id(params[:id])
      if @book.user_id == current_user.id
        erb "/booklists/edit"
      else
        redirect to "/booklists"
      end
    else
      redirect to "/login"
    end
  end

  patch "/booklists/:id" do
    if params[:title] == ""
      redirect "/booklists/#{:id}/edit"
    else
      @book = Book.findy_by_id(params[:id])
      @book.title = params[:title]
      @book.description = params[:description]
      @book.save
      redirect to "/booklists/#{@book.id}"
    end
  end

  delete "/booklists/:id/delete" do
    if logged_in?
      @book = Book.find_by_id(params[:id])
      if @book.user_id == current_user.id
        @book.delete
        redirect "/booklists"
      else
        redirect to "/booklists"
      end
    else
      redirect to "/login"
    end
  end         

end
