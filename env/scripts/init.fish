#!/usr/bin/env fish

set original_conifg_path "/env/fish/config.fish"
set original_prompt_path "/env/fish/fish_prompt.fish"
set original_ruff_path "/env/ruff.toml"
set original_setting_path "/env/settings.json"
set original_nvim_path "/env/nvim"


set dest_config_path "$XDG_CONFIG_HOME/fish/config.fish"
set dest_prompt_path "$XDG_CONFIG_HOME/fish/functions/fish_prompt.fish"
set dest_ruff_path "$XDG_CONFIG_HOME/ruff/ruff.toml"
set dest_setting_path "$HOME/.vscode/.settings.json"
set dest_nvim_path "$XDG_CONFIG_HOME/nvim"


function create_link_or_copy -d "Create a symbolic link or copy a file"
    set -l source_file $argv[1]
    set -l destination_file $argv[2]

    if ln -s $source_file $destination_file
        echo "Symbolic link created successfully: $destination_file"
    else
        # If link creation fails, fall back to copying the file
        echo "Link creation failed. Falling back to copying the file..."
        cp -rf $source_file $destination_file
        if test -f $destination_file
            echo "File copied successfully: $destination_file"
        else
            echo "Failed file copy: $destination_file"
        end
    end
end

create_link_or_copy $original_conifg_path $dest_config_path
create_link_or_copy $original_prompt_path $dest_prompt_path
create_link_or_copy $original_ruff_path $dest_ruff_path
create_link_or_copy $original_setting_path $dest_setting_path
create_link_or_copy $original_nvim_path $dest_nvim_path

source $dest_config_path

