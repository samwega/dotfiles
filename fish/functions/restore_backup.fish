function restore_backup --argument file
    mv $file (echo $file | sed s/.bak//)
end
