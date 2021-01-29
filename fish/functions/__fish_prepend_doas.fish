function __fish_prepend_doas --description Prepend\ \'doas\ \'\ to\ the\ beginning\ of\ the\ current\ commandline
    set -l cmd (commandline -poc)
    if test "$cmd[1]" != "doas"
        commandline -C 0
        commandline -i "doas "
        commandline -f end-of-line
    end
end
