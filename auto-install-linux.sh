echo "This will overwrite your current nvim configuration, do you want to continue? [y/n]"

read -r response

if [[ $response != "y" ]]; then
    echo "Exiting..."
    exit 1
fi

rm -rf ~/.local/share/nvim/site/pack/packer/start/packer.nvim

git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim


mkdir -p ~/.config/nvim
cp -fvir * ~/.config/nvim/

nvim -c 'PackerSync'
