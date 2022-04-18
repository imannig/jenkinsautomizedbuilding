#CDing to work directory
cd /var/lib/jenkins/workspace/Test-Cherished/cherish # Change the workspace name and the dir name accordingly 
# Clone needed stuff here
rm -rf device/xiaomi/ginkgo
git clone https://github.com/RedmiGankLTS/android_device_xiaomi_ginkgo -b cherish device/xiaomi/ginkgo
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
#Duplicate fix
#Add needed fixes down here 
rm -rf hardware/google/pixel/kernel_headers
rm -rf hardware/xiaomi/aidl/power-libperfmgr
#Rebuilding started
brunch ginkgo #(replace bacon if the documentation specifically mention to change it e.g make nad -j20 or play live kasumi)
