class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    curr_xor = 0
    self.each_with_index do |ele, idx|
      temp = ele.object_id + idx
      curr_xor = curr_xor ^ temp
    end
    curr_xor.hash
  end
end

class String
  def hash
    curr_xor = 0
    chars.each_with_index do |char, idx|
      temp = char.object_id + idx
      curr_xor = curr_xor ^ temp
    end
    curr_xor.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    0
  end
end
