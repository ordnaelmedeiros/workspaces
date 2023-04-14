# alias
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias apt-update='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y'

. "$HOME/.asdf/asdf.sh"

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

precmd() {

    folder=$(basename $PWD)
    if [ $PWD = "$HOME" ]; then
        folder="~"
    else
        folder=$(basename $PWD)
    fi
    folder_l=${#folder}

    spaces=$(( $folder_l + 4 ))
    branchName=$(git branch --show-current 2> /dev/null)
    if [ $branchName ]; then
        spaces=$(expr ${#branchName} + $spaces + 4)
    fi

    libs=""
    foreach line ($(asdf current 2> /dev/null | grep -v "$HOME/.tool-versions" | sed -e 's/  */|/g'))
        array=( $(echo $line | tr '|' "\n") );
        # echo "${array[1]} ${array[2]}"
        libs="$libs|${array[1]} ${array[2]}"
    end

    if [ $libs ]; then
        libs="${libs:1}"
        spaces=$(expr ${#libs} + $spaces + 2)
    fi

    draw_gray "┌("
    
    draw_cyan "$folder"
    if [ $branchName ]; then
        draw_yellow " on "
        draw_green "$branchName"
    fi
    draw_gray ")"

    line_l=$(($COLUMNS-$spaces))
    for ((j=0; j<$line_l; j+=1)); do
        draw_gray "─"
    done
    if [ $libs ]; then
        draw_gray "($libs)"
    fi
    draw_gray "┐"
    printf "\n"
}

PS1=$'\e[0;90m└ \e[0m'