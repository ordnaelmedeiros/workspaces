function draw_cyan() {
    printf "\e[1;36m${1}\e[0m"
}
function draw_gray() {
    printf "\e[1;90m${1}\e[0m"
}
function draw_yellow() {
    printf "\e[1;33m${1}\e[0m"
}
function draw_green() {
    printf "\e[1;32m${1}\e[0m"
}

draw_prompt() {
    path=$(basename $PWD)
    if [ $path = "$HOME" ]; then
        path="~"
    fi
    
    spaces=$(expr ${#path} + 4)
    branchName=$(git branch --show-current 2> /dev/null)
    if [ $branchName ]; then
        spaces=$(expr ${#branchName} + $spaces + 4)
    fi
    draw_gray "┌("
    
    draw_cyan "$path"
    if [ $branchName ]; then
        draw_yellow " on "
        draw_green "$branchName"
    fi
    draw_gray ")"
    for ((j=0; j<($COLUMNS-$spaces); j+=1))
    do
        draw_gray "─"
    done
    draw_gray "┐"
    draw_gray "\n└"
    echo " "
}

PS1="\$(draw_prompt)"
