#CDing to work directory
cd /var/lib/jenkins/workspace/Test-Cherished/elixir-jus # Change the workspace name and the dir name accordingly 
# Clone needed stuff here
rm -rf device/xiaomi/juice
git clone https://github.com/imannig/device_xiaomi_juice -b 12.1-rebase device/xiaomi/juice
#Rebuild script
. build/envsetup.sh 
#ccache
sudo mkdir /ccache 
mkdir tempcc
sudo umount /ccache
sudo chmod 777 /ccache
sudo mount --bind $PWD/tempcc /ccache
export USE_CCACHE=1
export CCACHE_EXEC=$(which ccache)
export CCACHE_DIR=/ccache
ccache -M 100G -F 0
lunch aosp_juice-user
make bacon -j20
