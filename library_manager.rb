require 'active_support/all'
require 'pry'

require './library_manager.rb'
require './author.rb'
require './book.rb'
require './published_book.rb'
require './reader.rb'
require './reader_with_book.rb'

class LibraryManager

  attr_accessor :reader_with_book, :issue_datetime

  def initialize reader_with_book, issue_datetime
    @reader_with_book = reader_with_book
    @issue_datetime = issue_datetime
  end
  def penalty_per_hour
    penalty_first_part = 0.00007 * (DateTime.now.new_offset(0).year - reader_with_book.book.published_at) * reader_with_book.book.price
    penalty_second_part = 0.000003 * reader_with_book.book.pages_quantity * reader_with_book.book.price
    penalty_third_part = 0.0005 * reader_with_book.book.price
    penalty_per_hour = penalty_first_part + penalty_second_part + penalty_third_part 
  end
  def penalty
    #war_and_peace_book = PublishedBook.new(leo_tolstoy, 'War and Peace', 1400, 3280, 1996)
    #binding.pry
    
    penalty = ((DateTime.now.new_offset(0) - issue_datetime) * penalty_per_hour * 24).round 3
  end

  def could_meet_each_other? first_author, second_author
      second_author.year_of_birth >= first_author.year_of_death || first_author.year_of_birth >= second_author.year_of_death ? false : true
  end

  def days_to_buy
    days_to_buy = (reader_with_book.book.price / (penalty_per_hour * 24)).round

  end

  def transliterate author

 replace = {
 
'а' => 'a', 'б' => 'b', 'в' => 'v',
'г' => 'h', 'д' => 'd', 'е' => 'e', 'є' => 'ie',
'ж' => 'zh', 'з' => 'z', 'і' => 'i',
'и' => 'y', 'й' => 'i', 'к' => 'k', 'ї' => 'i',
'л' => 'l', 'м' => 'm', 'н' => 'n', 'ґ' => 'g',
'о' => 'o', 'п' => 'p', 'р' => 'r',
'с' => 's', 'т' => 't', 'у' => 'u',
'ф' => 'f', 'х' => 'kh', 'ц' => 'ts',
'ч' => 'ch', 'ш' => 'sh', 'щ' => 'shch',
'ю' => 'iu', 'я' => 'ia',
 
'А' => 'A', 'Б' => 'B', 'В' => 'V',
'Г' => 'H', 'Д' => 'D', 'Е' => 'E', 'Є' => 'Ye',
'Ж' => 'Zh', 'З' => 'Z', 'І' => 'I',
'И' => 'Y', 'Й' => 'Y', 'К' => 'K', 'Ї' => 'Yi',
'Л' => 'L', 'М' => 'M', 'Н' => 'N', 'Ґ' => 'G',
'О' => 'O', 'П' => 'P', 'Р' => 'R',
'С' => 'S', 'Т' => 'T', 'У' => 'U',
'Ф' => 'F', 'Х' => 'Kh', 'Ц' => 'Ts',
'Ч' => 'Ch', 'Ш' => 'Sh', 'Щ' => 'Shch',
'Ю' => 'Yu', 'Я' => 'Ya', ' ' => ' '
}
 
 author.name.gsub(/#{replace.keys}/, replace) 

  end

  def penalty_to_finish
    
    finish_time = DateTime.now.new_offset(0) + reader_with_book.time_to_finish
    overtime = (finish_time - issue_datetime) * 24
    if overtime > 0
      penalty_to_finish = (overtime * penalty_per_hour) * 24
    else
    penalty_to_finish = 0
    end  
  end
  # this is a placeholder. Just ignore it for the moment.
  def email_notification_params

  end

end
