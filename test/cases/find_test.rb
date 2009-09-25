require 'cases/helper'
require 'models/artist'

class FindTest < ActiveRecord::TestCase
  fixtures :artists

  def test_find_with_one_binary_uuid
    artist = Artist.find identify(:michael_jackson)
    assert artist.instance_of?(Artist)
  end

  def test_find_with_one_hex_uuid
    artist = Artist.find identify_hex(:michael_jackson)
    assert artist.instance_of?(Artist)
  end

  def test_find_with_multiple_binary_uuids
    artists = Artist.find([
      identify(:beatles),
      identify(:ll_cool_j),
      identify(:method_man),
    ])
    assert_equal 3, artists.size
    artists.each do |artist|
      assert artist.instance_of?(Artist)
    end
  end

  def test_find_with_multiple_hex_uuids
    artists = Artist.find([
      identify_hex(:method_man),
      identify_hex(:beatles),
      identify_hex(:warren_g),
    ])
    assert_equal 3, artists.size
    artists.each do |artist|
      assert artist.instance_of?(Artist)
    end
  end

  def test_find_with_multiple_mixed_uuids
    artists = Artist.find([
      identify_hex(:beatles),
      identify(:michael_jackson),
      identify_hex(:warren_g),
    ])
    assert_equal 3, artists.size
    artists.each do |artist|
      assert artist.instance_of?(Artist)
    end
  end

  def test_find_with_duplicate_mixed_uuids
    artists = Artist.find([
      identify(:beatles),
      identify(:method_man),
      identify(:warren_g),
      identify_hex(:beatles),
      identify_hex(:method_man),
      identify_hex(:warren_g),
    ])
    assert_equal 3, artists.size
    artists.each do |artist|
      assert artist.instance_of?(Artist)
    end
  end
end
