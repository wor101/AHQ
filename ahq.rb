class Creature
  def initialize(start, current, name, race, character_class, weapons, armour, equipment, spells)
    @weapon_skill = [start, current]
    @bow_skill = [start, current]
    @strength = [start, current]
    @toughness = [start, current]
    @speed = [start, current]
    @bravery = [start, current]
    @intelligence = [start, current]
    @fate = [start, current]
    @wounds = [start, current]
    @name = name
    @race = race
    @character_class = character_class
    @weapons = weapons
    @armour = armour
    @equipment = equipment
    @spells = spells
  end
end

class Character < Creature
  

  
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



class AdvancedHeroQuest
  require 'yaml'
  
  def play
    greeting
    create_character
    begin_adventure
      loop do
        hero_phase
        gamemaster_phase
        break if objective_complete?
      end
  end
  
  private
  include CharacterCreation
  
  def clear
    system 'clear'
  end
  
  def greeting
    puts "*" * 40
    puts "Welcome to Advanced HeroQuest!".center(40)
    puts "*" * 40
    puts " "
    puts "1. Select Character".center(40)
    puts "2. Create Character".center(40)
    
    answer = nil
    loop do
      answer = gets.chomp
      break if %w(1 2).include?(answer)
    end
    
    case answer
    when 1 then puts "sorry"
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