echo "This will overwrite your current nvim configuration, do you want to continue? [y/n]"

read -r response

if [[ $response != "y" ]]; then
    echo "Exiting..."
    exit 1
fi

sudo apt install lua5.1 ripgrep fdclone

sudo apt install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt update; sudo apt install -y nodejs

rm -rf ~/.local/share/nvim/site/pack/packer/start/packer.nvim

git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

mkdir -p ~/.config/nvim

yes | cp -fvir * ~/.config/nvim/

nvim +"so %" ~/.config/nvim/lua/config/plugins/packer.lua +q

nvim -c 'PackerSync'

git clone https://github.com/github/copilot.vim.git ~/.config/nvim/pack/github/start/copilot.vim

nvim -c 'Copilot setup'
