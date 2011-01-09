# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

authors = Author.create([
  {:name => 'Noam Chomsky'},
  {:name => 'Andrew Carnie'},
  {:name => 'Mario Puzo'},
  {:name => 'William Goldman'},
  ]).inject({}) {|h,author| h[author.name] = author.id; h}

books = Book.create([
  {:title => "The Minimalist Program", :price => "40.00", :author_id => authors['Noam Chomsky'], :read => true},
  {:title => "Lectures on Government and Binding", :price => "60.00", :author_id => authors['Noam Chomsky'], :read => false},
  {:title => "Syntax", :price => "40.00", :author_id => authors['Andrew Carnie'], :read => true},
  {:title => "The Godfather", :price => "8.00", :author_id => authors['Mario Puzo'], :read => false},
  {:title => "The Princess Bride", :price => "8.00", :author_id => authors['William Goldman'], :read => true},
  ]).inject({}) {|h,book| h[book.title] = book.id; h}
