class Integer
  # Integer#hash already implemented for you
end

class Array
  # def hash
  #   curr_xor = 0
  #   self.each_with_index do |ele, idx|
  #     temp = ele.object_id + idx
  #     curr_xor = curr_xor ^ temp
  #   end
  #   curr_xor.hash
  # end
  def hash
    each_with_index.inject(0) do |intermediate_hash, (el, i)|
      (el.hash + i.hash) ^ intermediate_hash
    end
  end
end

class String
  # def hash
  #   curr_xor = 0
  #   chars.each_with_index do |char, idx|
  #     temp = char.object_id + idx
  #     curr_xor = curr_xor ^ temp
  #   end
  #   curr_xor.hash
  # end
  def hash
    chars.map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    to_a.sort_by(&:hash).hash
  end
end
