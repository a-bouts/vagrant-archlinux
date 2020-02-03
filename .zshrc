source /usr/share/zsh/share/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle kubectl
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle ArnoBouts/kctl

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme robbyrussell

# Tell Antigen that you're done.
antigen apply

#powerline-daemon -q
#. /usr/lib/python3.7/site-packages/powerline/bindings/zsh/powerline.zsh

PROMPT=$PROMPT'$(kctl)'
