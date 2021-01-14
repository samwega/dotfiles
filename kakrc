# User preference
# ───────────────

set-option global makecmd 'make -j8'
set-option global grepcmd 'ag --column'

set-option global ui_options ncurses_status_on_top=false

add-highlighter global/ show-matching
add-highlighter global/ dynregex '%reg{/}' 0:+u

hook global WinCreate ^[^*]+$ %{ add-highlighter global/ number-lines -relative }

hook global WinCreate ^[^*]+$ %{ addhl global/ wrap }

# Enable editor config
# ────────────────────

hook global BufOpenFile .* %{ editorconfig-load }
hook global BufNewFile .* %{ editorconfig-load }

# Filetype specific hooks
# ───────────────────────

hook global WinSetOption filetype=(c|cpp) %{
    clang-enable-autocomplete 
    clang-enable-diagnostics
    alias window lint clang-parse
    alias window lint-next-error clang-diagnostics-next
}

# hook global WinSetOption filetype=python %{
#     jedi-enable-autocomplete
#     lint-enable
#     set-option global lintcmd 'pyflakes'
# }

hook global WinSetOption filetype=python %{
        set-option window lintcmd %{ run() { pylint --msg-template='{path}:{line}:{column}: {category}: {msg_id}: {msg} ({symbol})' "$1" | awk -F: 'BEGIN { OFS=":" } { if (NF == 6) { $3 += 1; print } }'; } && run }
}

map -docstring "xml tag objet" global object t %{c<lt>([\w.]+)\b[^>]*?(?<lt>!/)>,<lt>/([\w.]+)\b[^>]*?(?<lt>!/)><ret>}

# Highlight the word under the cursor
# ───────────────────────────────────

declare-option -hidden regex curword
set-face global CurWord default,rgb:4a4a4a

hook global NormalIdle .* %{
    eval -draft %{ try %{
        exec <space><a-i>w <a-k>\A\w+\z<ret>
        set-option buffer curword "\b\Q%val{selection}\E\b"
    } catch %{
        set-option buffer curword ''
    } }
}
add-highlighter global/ dynregex '%opt{curword}' 0:CurWord

# Custom mappings
# ───────────────

map global normal = ':prompt math: %{exec "a%val{text}<lt>esc>|bc<lt>ret>"}<ret>'

# System clipboard handling
# ─────────────────────────

evaluate-commands %sh{
    case $(uname) in
        Linux) copy="xclip -i"; paste="xclip -o" ;;
        Darwin)  copy="pbcopy"; paste="pbpaste" ;;
    esac

    printf "map global user -docstring 'paste (after) from clipboard' p '!%s<ret>'\n" "$paste"
    printf "map global user -docstring 'paste (before) from clipboard' P '<a-!>%s<ret>'\n" "$paste"
    printf "map global user -docstring 'yank to primary' y '<a-|>%s<ret>:echo -markup %%{{Information}copied selection to X11 primary}<ret>'\n" "$copy"
    printf "map global user -docstring 'yank to clipboard' Y '<a-|>%s<ret>:echo -markup %%{{Information}copied selection to X11 clipboard}<ret>'\n" "$copy -selection clipboard"
    printf "map global user -docstring 'replace from clipboard' R '|%s<ret>'\n" "$paste"
}

# Various mappings
# ────────────────

map global normal '#' :comment-line<ret>

map global user -docstring 'next lint error' n ':lint-next-error<ret>'
map global normal <c-p> :lint<ret>

map global user -docstring 'gdb helper mode' g ':gdb-helper<ret>'
map global user -docstring 'gdb helper mode (repeat)' G ':gdb-helper-repeat<ret>'

hook global -always BufOpenFifo '\*grep\*' %{ map -- global normal - ': grep-next-match<ret>' }
hook global -always BufOpenFifo '\*make\*' %{ map -- global normal - ': make-next-error<ret>' }

# Enable <tab>/<s-tab> for insert completion selection
# ──────────────────────────────────────────────────────

hook global InsertCompletionShow .* %{ map window insert <tab> <c-n>; map window insert <s-tab> <c-p> }
hook global InsertCompletionHide .* %{ unmap window insert <tab> <c-n>; unmap window insert <s-tab> <c-p> }

# Helper commands
# ───────────────

define-command find -menu -params 1 -shell-script-candidates %{ ag -g '' --ignore "$kak_opt_ignored_files" } %{ edit %arg{1} }

define-command mkdir %{ nop %sh{ mkdir -p $(dirname $kak_buffile) } }

define-command ide -params 0..1 %{
    try %{ rename-session %arg{1} }

    rename-client main
    set-option global jumpclient main

    new rename-client tools
    set-option global toolsclient tools

    new rename-client docs
    set-option global docsclient docs
}

define-command delete-buffers-matching -params 1 %{
    evaluate-commands -buffer * %{
        evaluate-commands %sh{ case "$kak_buffile" in $1) echo "delete-buffer" ;; esac }
    }
}

declare-option -hidden str swap_buffer_target
define-command swap-buffer-with -override -params 1 -client-completion %{
    set-option global swap_buffer_target %val{bufname}
    edit -scratch # release current window for other client
    evaluate-commands -client %arg{1} "
        set-option global swap_buffer_target %%val{bufname}
        buffer %opt{swap_buffer_target}
    "
    delete-buffer # delete the temporary scratch buffer
    buffer %opt{swap_buffer_target}
}

define-command -params .. fifo %{ evaluate-commands %sh{
     output=$(mktemp -d "${TMPDIR:-/tmp}"/kak-fifo.XXXXXXXX)/fifo
     mkfifo ${output}
     ( eval "$@" > ${output} 2>&1 & ) > /dev/null 2>&1 < /dev/null

     printf %s\\n "evaluate-commands -try-client '$kak_opt_toolsclient' %{
               edit! -fifo ${output} *fifo*
               hook -always -once buffer BufCloseFifo .* %{ nop %sh{ rm -r $(dirname ${output}) } }
           }"
}}

declare-option int gdb_server_port 5678
declare-option str gdb_server_cmd "gdbserver :%opt{gdb_server_port}"

define-command gdb-server -params .. %{
    fifo %opt{gdb_server_cmd} %arg{@}
    gdb-session-new -ex "target remote :%opt{gdb_server_port}"
}


# Load local Kakoune config file if it exists
# ───────────────────────────────────────────

evaluate-commands %sh{ [ -f $kak_config/local.kak ] && echo "source $kak_config/local.kak" }

# PErsonal settings - SamVega

#Yank to clipboard (requires xclip)
hook global NormalKey '[ydc]' %{
      nop %sh{
              (printf '%s' "$kak_main_reg_dquote" | xclip -filter | xclip -selection clipboard) < /dev/null > /dev/null 2>&1 &
      }
}

# Paste (requires xclip)
 map global user p -docstring 'Paste (After)' '<a-!>xclip -out -selection clipboard<ret>'
 map global user P -docstring 'Paste (Before)' '!xclip -out -selection clipboard<ret>'
 map global user R -docstring 'Replace' '|xclip -out -selection clipboard<ret>'
 
source /home/samvega/.config/kak/out-of-the-box/oob.kak
source ~/.config/kak/sudo-write.kak
source ~/.config/kak/wiki.kak

map global normal '#' :comment-line<ret>

set-option global autoreload yes
set-option global tabstop 4
set-option global aligntab true
map global normal , <space>
map global normal <space> ,

#User mappings
map global user <z> :write-quit<ret> -docstring "write-quit"
map global user <space> :buffer-next<ret> -docstring "buffer-next"

# Ctrl for moving objects in insert mode
map global insert <c-left>    '<a-;>b<a-;>;'
map global insert <c-right>   '<a-;>w<a-;>;'
map global insert <c-up>      '<a-;>[p<a-;>;'
map global insert <c-down>    '<a-;>]p<a-;>;'
map global normal <c-left>    'b;'
map global normal <c-right>   'w;'
map global normal <c-up>      '[p;'
map global normal <c-down>    ']p;'

# sublime functionality "ctrl-d" selection.
define-command -hidden -docstring \
"select a word under cursor, or add cursor on next occurrence of current selection" \
select-or-add-cursor %{
    try %{
        execute-keys "<a-k>\A.\z<ret>"
        execute-keys -save-regs '' "_<a-i>w*"
    } catch %{
        execute-keys -save-regs '' "_*<s-n>"
    } catch nop
}
map global normal '<c-d>' ': select-or-add-cursor<ret>' -docstring "add cursor on current word, and jump to the next match"

