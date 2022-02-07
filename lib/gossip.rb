class Gossip
  attr_reader :author, :content, :id, :all_gossips
  @@all_gossips = Array.new

  def initialize(author,content) #Initialisation de Gossip avec 'author' et 'content'
    @author = author
    @content = content
  end

  def save # Save les Gossip.new dans le fichier gossip.csv.
    CSV.open("db/gossip.csv", "a") do |csv| # Ouvre le fichier gossip.csv avec la propriété A(ppend).
      csv << [@author,@content]
    end
  end
  
  def self.all #Insère les Gossip.new dans un array.
    CSV.read("./db/gossip.csv").each do |csv_line|
      @@all_gossips << Gossip.new(csv_line[0], csv_line[1]) 
    end
    return @@all_gossips  
  end

  def self.find(id)
    gossips = []   # permet de stocker la ligne csv demandée.
    CSV.read("./db/gossip.csv").each_with_index do |csv_line, index|
      if (id == index+1)          # cherche et check si l'index est égale id demandé.
        gossips << Gossip.new(csv_line[0], csv_line[1])    # si trouvé, ajout dans array et break pour retourner l'array.
        break
      end
    end
      return gossips
  end

  def self.update(id,author,content) # recréé l'array et csv avec les données modifiées.
    gossips = []

		CSV.read("./db/gossip.csv").each_with_index do |row, index|
			if id.to_i == (index + 1)  
				gossips << [author, content] #Stock les anciennnes valeurs dans gossips.
			else
				gossips << [row[0], row[1]] #Sinon garde les valeur par défaut.
			end
		end

		CSV.open("./db/gossip.csv", "w") do |csv| 
			gossips.each do |row|
				csv << row #Enregistre les nouvelles valeurs dans le csv
      end
    end
  end

end
