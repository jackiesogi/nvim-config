echo "This will overwrite your current nvim configuration, do you want to continue? [y/n]"

read -r response

if [[ $response != "y" ]]; then
    echo "Exiting..."
    exit 1
fi

sudo apt install nodejs lua5.1 ripgrep fdclone

rm -rf ~/.local/share/nvim/site/pack/packer/start/packer.nvim

git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

mkdir -p ~/.config/nvim

yes | cp -fvir * ~/.config/nvim/

nvim +"so %" ~/.config/nvim/lua/config/plugins/packer.lua +q

nvim -c 'PackerSync'

git clone https://github.com/github/copilot.vim.git ~/.config/nvim/pack/github/start/copilot.vim

nvim -c 'Copilot setup'
