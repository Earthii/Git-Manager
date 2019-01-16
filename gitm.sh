#!/bin/bash
folder_name="gitm-workspace"
gitManagerRootDir="/Users/ericxiao/Documents/$folder_name"

function printInLightBlue(){
    printf "\e[96m$1\033[0m"
}

function help(){
    echo "Available Commands:"
    printInLightBlue "  -h, --help"
    printf " Display help menu.\n"
    printInLightBlue "  clone <git_url>"
    printf " Git clone a repository.\n"
    printInLightBlue "  ls <optional_repo_name> "
    printf " ls in gitm-root-dir or ls in specific repo wrapper folder.\n"
    printInLightBlue "  checkout <repo_name> <env#> <branch>"
    printf " execute a command in that repo.\n"
    printInLightBlue "  dev <repo_name> <env#> "    
    printf " Will open repo in visual code (vs-cli installed).\n"           
    exit 0
}

function clone(){
    shift
    if test $# -gt 0; then
        url=$1 
        basename=$(basename $url)
        repo_name=${basename%.*}
        cd $gitManagerRootDir

        if ls | grep -Fxq "$repo_name"
        then
            # repo dir found
            cd $repo_name
            index=$(($(ls | wc -l)+1))
            git clone $url "$index-$repo_name"
        else
            # repo dir not found
            mkdir $repo_name
            cd $repo_name
            git clone $url "1-$repo_name"
        fi
        shift
    else
        echo "No git URL specified"
        exit 1
    fi
}

function list(){
    cd $gitManagerRootDir
    shift
    if test $# -gt 0; then
        cd $1
        echo "Env #     Branch"
        echo "=====     ======"
        for dir in *; do
            env_number=${dir:0:1}
            branch=""
            cd $dir
            if [ -d ".git" ]; then
                branch="$(git branch | grep "*")"
            fi
            branch="${branch//* }"
            echo "$env_number         $branch"
            cd ..
        done
    else
        ls
        exit 0
    fi
}
function checko(){
    shift
    cd "$gitManagerRootDir/$1/$2-$1"
    git checkout $3
}

function dev(){
    shift
    cd "$gitManagerRootDir/$1/$2-$1"
    if [ -d "$gitManagerRootDir/$1/$2-$1" ]; then
        code .
    fi
}

if [ ! -d "$gitManagerRootDir" ]; then
  # Control will enter here if $DIRECTORY exists.
  mkdir $gitManagerRootDir
fi

if [ $# -eq 0 ]; then
    help
    exit 0
fi                

while test $# -gt 0; do
        case "$1" in
                -h|--help)
                    help
                    exit 0
                    ;;

                clone)
                    if [ $# -eq 2 ]
                    then
                        clone $@
                    else
                        help
                    fi
                    exit 0
                    ;;

                ls)
                    if (($# >= 1 && $# <= 2))
                    then
                        list $@
                    else
                        help
                    fi
                    exit 0
                    ;;

                checkout)
                    if [ $# -eq 4 ] 
                    then
                        checko $@
                    else
                        help
                    fi                
                    exit 0
                    ;;

                dev)
                    if [ $# -eq 3 ] 
                    then
                        dev $@
                    else
                        help
                    fi                
                    exit 0
                    ;;

                *)
                    help
                    exit 0
                    ;;
        esac
done