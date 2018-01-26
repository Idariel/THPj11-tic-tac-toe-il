# Affiche la valeur de la case : x, o ou vide (null?)class BoardCase
class BoardCase
  attr_accessor :contenu #OK : renvoie le contenu à Board
  attr_accessor :n #n = numéro de case : @a1/@a2etc
  def initialize (contenu)
    @contenu = " " # Début du jeu : toutes les cases sont vides
    @n = 9 # Il y 9 cases dans le morpion
  end
  def to_s
    @contenu.to_s
  end
end



class Board
  include Enumerable
  attr_accessor :grid
  @@grid  = [ @a1, @a2, @a3, @b1, @b2, @b3, @c1, @c2, @c3 ]

  def initialize # OK
    @a1 = BoardCase.new (@contenu)
    @a2 = BoardCase.new (@contenu)
    @a3 = BoardCase.new (@contenu)
    @b1 = BoardCase.new (@contenu)
    @b2 = BoardCase.new (@contenu)
    @b3 = BoardCase.new (@contenu)
    @c1 = BoardCase.new (@contenu)
    @c2 = BoardCase.new (@contenu)
    @c3 = BoardCase.new (@contenu)
  end
  def def_s # Affiche le plateau OK
    puts "   1   2   3"
    puts "A  #{@a1} | #{@a2} | #{@a3} "
    puts "  ---|---|---"
    puts "B  #{@b1} | #{@b2} | #{@b3} "
    puts "  ---|---|---"
    puts "C  #{@c1} | #{@c2} | #{@c3} "
    puts
  end

  def play
    def case_free (boardcase)
      if boardcase == " "
        true
      else
        puts "Déja pris! Choisissez une autre case"
      end
    end
  end

  def victory
    winning_combinations = [
      [@a1, @a2, @a3],
      [@a1, @b2, @c3],
      [@a1, @b1, @c1],
      [@b1, @b2, @b3],
      [@c1, @c2, @c3],
      [@c1, @b2, @a3],
      [@a2, @b2, @c2],
      [@a3, @b3, @c3]]
    winning_combinations.each do |combo|
      if combo[0] == "O" && combo[1] == "O" && combo[2] == "O"
        puts "Joueur2 gagne!"
        exit
      elsif combo[0] == "X" && combo[1] == "X" && combo[2] == "X"
        puts "Joueur1 gagne !"
        exit
      else
        puts "Match nul! Tapez q pour finir."
      end
    end
  end
end

class Player
  #TO DO : la classe a 2 attr_accessor, son nom, sa valeur (X ou O). Elle a un attr_writer : il a gagné ?
  attr_accessor :name
  attr_accessor :valeur
  attr_writer :status

  def initialize (name, valeur)
    #TO DO : doit régler son nom, sa valeur, son état de victoire
    @name = gets.name
    @valeur = valeur
    @status
  end
end


class Game
  def initialize
    #TO DO : créé 2 joueurs, créé un board
    @joueur1 = Player.new
    @joueur2 = Player.new
    @board = Board.new
  end

  def go
    # TO DO : lance la partie
    puts "Voulez-vous jouer à Tic Tac Toe ?"
    puts "Pour jouer une case, indiquer sa ligne (A, B ou C) et sa colonne (1, 2 ou 3) (par exemple, a1 ou b3 ou c2)."
    puts "Vous pouvez sortir du jeu à tout moment en tapant q"
    board = Board.new
    while true
      Board.def_s
      player1_joue
      player2_joue
  end

  def turn
    #TO DO : affiche le plateau, demande au joueur il joue quoi, vérifie si un joueur a gagné, passe au joueur suivant si la partie n'est pas finie
    while true # Repeat until game is over
      turn joueur1 # Tour du premier joueur
      joueur1.move board # Le joueur1 joue
      display_board board # Affiche le nouveau plateau
      #Le joueur1 a gagné
      #Le joueur2 a gagné
      #C'est un match nul

      def player1_joue
        player1_choice_hash = {
          "a1" => @a1,
          "a2" => @a2,
          "a3" => @a3,
          "b1" => @b1,
          "b2" => @b2,
          "b3" => @b3,
          "c1" => @c1,
          "c2" => @c2,
          "c3" => @c3}
        puts "Quelle case jouez-vous ?"
        player1_choice = gets.chomp.downcase # chomp supprime le retour à la ligne et downcas s'assure que tout soit en minuscules.
        player1_choice_hash.each do |choice, boardcase|
          if player1_choice == choice
            if check_validity(boardcase)
              boardcase.sub!(" ", "X")
              print_grid
            end
          elsif player1_choice == "q"
            exit
          end
          end
        end
      end

      def player2_joue
          player2_choice_hash = {
            "a1" => @a1,
            "a2" => @a2,
            "a3" => @a3,
            "b1" => @b1,
            "b2" => @b2,
            "b3" => @b3,
            "c1" => @c1,
            "c2" => @c2,
            "c3" => @c3}
          puts "Quelle case jouez-vous ?"
          player2_choice = gets.chomp.downcase #chomp: suppr retour ligne - downcase = minuscules.
          player2_choice_hash.each do |choice, boardcase|
            if player2_choice == choice
              if check_validity(boardcase)
                boardcase.sub!(" ", "O")
                print_grid
              end
            elsif player2_choice == "q"
              exit
            end
          end
        end
    end
  end
end

# Lancement du jeu
# Game.new.go


#=================
#TEST
#=================
# Test l'affichage du Board initial
board1 = Board.new
board1.def_s

# Test class Player
# player = Player.new
# player.initialize