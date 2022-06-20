class HashSet
  attr_accessor :store, :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return false if include?(key)
    self[key] << key
    @count += 1
    resize! if num_buckets < self.count
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if self[key].include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    self.store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    curr_store = self.store
    self.count = 0
    self.store = Array.new(num_buckets * 2) { Array.new }
    curr_store.flatten.each { |num| self.insert(num) }
  end
end
