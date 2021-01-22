require 'pry'

module Display
  SCREEN_SIZE = 40
  def clear
    system 'clear'
  end
  
  def display_title(message)
    puts "*" * SCREEN_SIZE
    puts "*" + "#{message}".center(SCREEN_SIZE - 2) + "*"
    puts "*" * SCREEN_SIZE
    puts " "  
  end
end

class Creature
  attr_reader :weapon_skill, :bow_skill, :strength, :toughness,
              :speed, :bravery, :intelligence, :fate, :wounds,
              :name, :ancestory, :character_class, :weapons,
              :armour, :equipment, :spells
  
  def initialize(stats)
    @weapon_skill = stats['weapon_skill']
    @bow_skill = stats['bow_skill']
    @strength = stats['strength']
    @toughness = stats['toughness']
    @speed = stats['speed']
    @bravery = stats['bravery']
    @intelligence = stats['intelligence']
    @fate = stats['fate']
    @wounds = stats['wounds']
    @name = stats['name']
    @ancestory = stats['ancestory']
    @character_class = stats['character_class']
    @weapons = stats['weapons']
    @armour = stats['armour']
    @equipment = stats['equipment']
    @spells = stats['spells']
  end
end

class Character < Creature
  include Display
  
  def show
    clear
    display_title(name)
    puts ("#{ancestory} " + "#{character_class}").center(SCREEN_SIZE) 
  end

end

module CharacterCreation
  
  def determine_ancestory
    puts "choose ancestory!"
  end
  
  def determine_stats
    puts "choose stats!"
  end
  
  def determine_class
    puts "choose class!"
  end
  
  def determine_equipment
    puts "choose equipment!"
  end
  
end

module CharacterSelection
  def select_character
    clear
    characters = YAML.load_file('characters.yml')
    display_title(titles['character_selection'])
    characters.each_pair do |key, value|
      puts "#{key}. #{value["name"]}"
    end
    answer = nil
    loop do
      answer = gets.chomp.to_i
      #binding.pry
      break if characters.keys.include?(answer)
    end
    puts "you selected " + characters[answer]['name']
    load_character(characters[answer])
  end
  
  def load_character(selection)
    self.character = Character.new(selection)
    character.show

  end
  
  
end




class AdvancedHeroQuest
  require 'yaml'
  
  def initialize
    @titles = YAML.load_file('title_display.yml')
    @character = nil
  end
  
  def play
    greeting
    #create_character
    begin_adventure
      loop do
        hero_phase
        gamemaster_phase
        break if objective_complete?
      end
  end

  private
  include CharacterCreation
  include CharacterSelection
  include Display
  
  attr_reader :titles
  attr_accessor :character
  

  
  def greeting
    display_title(titles['welcome'])
    puts "1. Select Character".center(SCREEN_SIZE)
    puts "2. Create Character".center(SCREEN_SIZE)
    
    answer = nil
    loop do
      answer = gets.chomp
      break if %w(1 2).include?(answer)
    end
    
    case answer.to_i
    when 1 then select_character
    when 2 then create_character
    end
    
  end

  def create_character
    puts "Create character!"
    determine_ancestory
    determine_stats
    determine_class
    determine_equipment
  end
  
  def begin_adventure
  end
  
  def hero_phase
  end

  def gamemaster_phase
  end
  
  def objective_complete?
    true
  end
end

game = AdvancedHeroQuest.new
game.play