require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    list = bucket(key)
    if include?(key)
      list.update(key, val)
    else
      list.append(key, val)
      self.count += 1
    end
    resize! if num_buckets < self.count
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    self.count -= 1
  end

  def each
    self.store.each do |bucket|
      bucket.each do |node|
        yield [node.key, node.val]
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    curr_store = self.store
    self.count = 0
    self.store = Array.new(num_buckets * 2) { LinkedList.new }
    curr_store.each do |bucket|
      bucket.each { |node| set(node.key, node.val) }
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    self.store[key.hash % num_buckets]
  end
end
