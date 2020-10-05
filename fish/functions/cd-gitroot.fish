function __cdgitroot_usage
    echo 'Usage: cd-gitroot [PATH]'
    echo 'Jump to git repository\'s root directory.'
    echo 'If PATH is specified, it\'s recognized as relative path'
    echo 'from repository\'s root directory. And jump to it.'
end

function cd-gitroot -d 'Jump to git repo\'s root'
    if not __cdgitroot_in_repo
        echo 'It\'s out of working tree!' 1>&2
        return 1
    end

    set root_path (git rev-parse --show-toplevel)
    set argc (count $argv)

    if test (count $argv) -eq 0
        cd $root_path
    else if test (count $argv) -eq 1; and test -n $relative_path
        set relative_path $argv
        cd "$root_path/$relative_path"
    else
        __cdgitroot_usage
    end
end

function __cdgitroot_complete
    set root_path (git rev-parse --show-toplevel)
    command find $root_path -type d -name '.git' -prune -o -type d -print \
            | sed "s#$root_path/##g" | sed "s#$root_path##g"
end

function __cdgitroot_in_repo
    command git rev-parse --git-dir > /dev/null ^ /dev/null
    return $status
end

complete -c cd-gitroot --no-files -d 'path' --condition __cdgitroot_in_repo -a '(__cdgitroot_complete)'

