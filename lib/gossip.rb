class Gossip
  attr_reader :author, :content, :id, :all_gossips
  @@all_gossips = Array.new

  def initialize(author,content)
    @author = author
    @content = content
  end

  def save
    CSV.open("db/gossip.csv", "a") do |csv|
      csv << [@author,@content]
    end
  end
  
  def self.all  
    CSV.read("./db/gossip.csv").each do |csv_line|
      @@all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return @@all_gossips  
  end

  def self.find(id)
    gossips = []   # permet de stocker la ligne csv demandée
    CSV.read("./db/gossip.csv").each_with_index do |csv_line, index|
      if (id == index+1)          # cherche et check si l'index est égale id demandé
        gossips << Gossip.new(csv_line[0], csv_line[1])    # si trouvé, ajout dans array et break pour retourner l'array
        break
          end
        end
        return gossips
    end
end