# grabs the git reote url from current repo and adds to clipboard
git remote -v | awk 'NR==1{print $2}' | pbcopy

