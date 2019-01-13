#!/bin/bash
folder_name="gitm-workspace"
gitManagerRootDir="/Users/ericxiao/Documents/$folder_name"

function help(){
    echo "options:"
    echo "-h, --help                * Show brief help"
    echo ""
    echo "actions:"
    echo "clone <git_url>           * Git clone a repository"
    echo "ls <repo_name>            * Display the content in the git root directory.
                            * If the repo_name is specified, 
                            display all repo specified directories"           
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

if [ ! -d "$gitManagerRootDir" ]; then
  # Control will enter here if $DIRECTORY exists.
  mkdir $gitManagerRootDir
fi
while test $# -gt 0; do
        case "$1" in
                -h|--help)
                    help
                    exit 0
                    ;;

                clone)
                    clone $@
                    exit 0
                    ;;

                ls)
                    list $@
                    exit 0
                    ;;

                *)
                    help
                    exit 0
                    ;;
        esac
done