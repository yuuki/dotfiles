### Abbr

abbr -a q exit
abbr -a v nvim
abbr -a c code
abbr -a s ssh
abbr -a gcs gcloud compute ssh

abbr -a g git
abbr -a gst git status
abbr -a gl git log -p
abbr -a gbr git-browse-remote
abbr -a gv gh repo view --web

abbr -a k kubectl
abbr -a d docker
abbr -a dm docker-machine
abbr -a dc docker-compose

abbr -a mb make build
abbr -a mt make test

abbr -a ll ls -lh
abbr -a la ls -a
abbr -a cp cp -p

gabbr --add G '| grep'
gabbr --add H '| head'
gabbr --add T '| tail'
gabbr --add L '| less'
gabbr --add ... '..//..'
gabbr --add .... '..//..//..'
gabbr --add ..... '..//..//..//..'

### Key bindings

bind \cxb fzf_git_recent_branch

### Enviroment variables

eval (direnv hook fish)
