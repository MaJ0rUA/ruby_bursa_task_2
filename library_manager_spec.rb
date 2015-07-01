require './library_manager.rb'

describe LibraryManager do

  let(:leo_tolstoy) { Author.new(1828, 1910, 'Leo Tolstoy' ) }
  let(:oscar_wilde) { Author.new(1854, 1900, 'Oscar Wilde') }
  let(:war_and_peace) { PublishedBook.new(leo_tolstoy, 'War and Peace', 1400, 3280, 1996) }
  let(:ivan_testenko) { ReaderWithBook.new('Ivan Testenko', 16, war_and_peace, 328) }
  let(:manager) { LibraryManager.new(ivan_testenko, (DateTime.now.new_offset(0) - 2.days)) }

  it 'should count penalty' do
    manager.penalty
    expect(manager.penalty).to eq 784.224
  end

  it 'should know if author can meet another author' do
      res = manager.could_meet_each_other? leo_tolstoy, oscar_wilde
    expect(res).to eq true
  end  

  it 'should count days to buy' do
    expect(manager.days_to_buy).to eq 4
  end

  it 'should transliterate ukrainian names' do
    ukrainian_author = Author.new(1856, 1916, 'Іван Франко')
    #manager.transliterate ukrainian_author
    expect(manager.transliterate ukrainian_author).to eq "Ivan Franko"
  end

  it 'should count penalty to finish' do
    expect (manager.penalty_to_finish).to eq 2236.962
  end

  
end
