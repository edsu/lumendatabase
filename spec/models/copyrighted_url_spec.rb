require 'rails_helper'

RSpec.describe CopyrightedUrl, type: :model do
  it { is_expected.not_to have_db_index(:url).unique(true) }
  it { is_expected.to have_db_index(:url_original).unique(true) }

  context 'automatic validations' do
    it { is_expected.to validate_presence_of(:url_original) }
    it { is_expected.to validate_length_of(:url).is_at_most(ValidatesUrls::MAX_LENGTH) }
    it { is_expected.to validate_length_of(:url_original).is_at_most(ValidatesUrls::MAX_LENGTH) }

    it 'validates format of URLs' do
      url = 'https://tilde.club:443/path/to/myfile.html?utf8=✓#AnchorGoesHere'
      assert !!(url =~ URI::regexp)
      assert CopyrightedUrl.new(url: url).valid?
    end

    it 'allows URLs without a protocol' do
      url = '//tilde.club:443/path/to/myfile.html?utf8=✓#AnchorGoesHere'
      assert !!("http:#{url}" =~ URI::regexp)
      assert CopyrightedUrl.new(url: url).valid?
    end

    it 'allows concatenated URLs' do
      url = 'https://amazon.com/book/here/http://amazon.com/another/book/'
      assert CopyrightedUrl.new(url: url).valid?
    end
  end

  context "#url" do
    it_behaves_like 'an object with a url'
  end

  context "#url_original" do
    it_behaves_like 'an object with a url'
  end
end
