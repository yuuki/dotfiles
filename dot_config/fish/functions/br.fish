set -l launcher "$HOME/.local/share/broot/launcher/fish/br.fish"
if test -f "$launcher"
  source "$launcher"
else
  function br --wraps=broot --description 'broot'
    command broot $argv
  end
end
