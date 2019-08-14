require 'authentication'

class BooksController < ApplicationController
  # GET /books
  def index
#    authenticate!
    @books = Book.all
    json_response(@books)
  end
end
