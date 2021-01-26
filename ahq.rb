require 'pry'

module Display
  SCREEN_SIZE = 40
  HALF_SCREEN = 20
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
    puts "Ancestory: #{ancestory}".ljust(HALF_SCREEN) + "Class: #{character_class}".ljust(HALF_SCREEN)
    puts ""
    puts "start  current".center(HALF_SCREEN) + "start  current".center(HALF_SCREEN)
    puts "Weapon Skill".center(HALF_SCREEN) + "Speed".center(HALF_SCREEN)
    puts display_ability(weapon_skill) + display_ability(speed)
    puts "Bow Skill".center(HALF_SCREEN) + "Bravery".center(HALF_SCREEN)
    puts display_ability(bow_skill) + display_ability(bravery)
    puts "Strength".center(HALF_SCREEN) + "Intelligence".center(HALF_SCREEN)
    puts display_ability(strength) + display_ability(intelligence)
    puts "Toughness".center(HALF_SCREEN) + "Fate".center(HALF_SCREEN)
    puts display_ability(toughness) + display_ability(fate)
    puts "Wounds".center(HALF_SCREEN)
    puts display_ability(wounds)
    puts ""
    puts "Weapons:"
    puts display_equipment(weapons)
    puts ""
    puts "Armour:"
    puts display_equipment(armour)
    puts ""
    puts "Equipment:"
    puts display_equipment(equipment)
  end
  
  private
  
  def display_ability(ability)
    "[#{ability[0]}]    [#{ability[1]}]".center(HALF_SCREEN)
  end
  
  def display_equipment(items)
    return "none" if !items
    items
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
    gets.chomp
  end
end

class Board
  SIZE = 20
  DEFAULT = [[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
             [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
            ]
  
  attr_accessor :board, :player_position
  attr_reader :create_corridor, :player_marker
  
  
  def initialize
    @player_marker = 'P'
    @player_position = [9, 4]
    @board = DEFAULT
    @corridor = create_corridor
    
    
  end
  
  def set_board
    place_marker(player_position, player_marker)
  end

  # def board=[]([y_axis, x_axis], value)
  #   @board[y_axis][x_axis] = value
  # end

  def place_marker(coordinates, marker)
    @board[coordinates[0]][coordinates[1]] = marker
  end

  def move_marker_north(coordinates, marker)
    y_axis = coordinates[0]
    x_axis = coordinates[1]

    coordinates = [(y_axis - 1), x_axis]
    place_marker(coordinates, marker)
  end
  
  def create_corridor
 
    "|    |    |\n" + 
    "-----------\n" + 
    "|    |    |\n" + 
    "-----------\n" + 
    "|    |    |\n" + 
    "-----------\n" + 
    "|    |    |\n" + 
    "-----------\n" +
    "|    |    |\n" 

  end
  
  def create_t_junction
    
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

# game = AdvancedHeroQuest.new
# game.play

dungeon = Board.new
dungeon.set_board
p dungeon.player_position
p dungeon.player_marker
dungeon.move_marker_north(dungeon.player_position, dungeon.player_marker)
dungeon.board.each { |line| puts line.join }