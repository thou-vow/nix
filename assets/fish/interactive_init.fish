function color
    perl -e 'foreach $a(@ARGV){print "\e[48:2::".join(":",unpack("C*",pack("H*",$a)))."m   \e[49m "};print "\n"' $argv
end

abbr --add -- .. 'cd ..'
abbr --add -- ../.. 'cd ../..'
abbr --add -- ../../.. 'cd ../../..'
abbr --add -- cat bat
abbr --add -- cd z
abbr --add -- e exit
abbr --add -- find fd
abbr --add -- g git
abbr --add -- ga 'git add'
abbr --add -- gaa 'git add --all'
abbr --add -- gc 'git clone'
abbr --add -- gcm 'git commit -m'
abbr --add -- gp 'git push'
abbr --add -- wiki wiki-tui

# Summon pokémon
pokeget random --hide-name
