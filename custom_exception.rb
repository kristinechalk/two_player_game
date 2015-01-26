class InvalidGuessError < StandardError  

end 


class PlayerDeadError < StandardError

end

# incorrect guess (InvalidGuessError)
# out of lives (PlayerDeadError)