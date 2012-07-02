class Player
  def initialize
    @health = 20
    @direction = :forward
  end

  def play_turn(warrior)
    puts @direction
    checkHealth(warrior)
    if !turnaround?(warrior)
      if !battle(warrior)
        if !free(warrior)
          continue(warrior)
        end
      end
    end
  end

  def turnaround?(warrior)
    if warrior.feel.wall?
      warrior.pivot!(:backward)
    else
      false
    end
  end

  def free(warrior)
    if warrior.feel(@direction).captive?
      warrior.rescue!(@direction)
    else
      false
    end
  end

  def continue(warrior)
    if @damage
      if @health < 6
        retreat(warrior)
      else
        warrior.walk!(@direction)
      end
    else
      if @health < 20
        warrior.rest!
      else
        warrior.walk!(@direction)
      end
    end
  end

  def checkHealth(warrior)
    h = warrior.health
    if h == 20
      @health = 20
    end
    if h < @health
      @damage = true
    else
      @damage = false
    end
    @health = h
  end

  def retreat(warrior)
    if @direction == :forward
      warrior.walk!(:backward)
    else
      warrior.walk!(:forward)
    end
  end

  def battle(warrior)
    if !warrior.feel(@direction).enemy?
      false
    else
      if @health < 8
        retreat(warrior)
      else
        warrior.attack!(@direction)
      end
    end
  end
end
