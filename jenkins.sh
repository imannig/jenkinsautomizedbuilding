#!/bin/bash
#Tolong semua ini diganti dan () harus di hapus kalau gak bakal rusak sana sini
mkdir elixir-jus #ganti xyz dengan nama dir yang ingin anda pakai)
cd elixir-jus #(ganti dengan nama yang ingin anda pakai)
git config --global user.name imannig
git config --global user.email zahranansaria@gmail.com
# Taruh repo sync yang ada di manifest di bawah
repo init -u https://github.com/Project-Elixir/official_manifest -b snow
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

git clone https://github.com/imannig/device_xiaomi_juice device/xiaomi/juice -b 12.1-rebase
git clone https://github.com/frstprjkt/vendor_xiaomi_juice vendor/xiaomi/juice
git clone https://github.com/imannig/Xiaomi-Fury-Bengal-SD662 kernel/xiaomi/juice -b JuiceIcedSnow
git clone --depth=1 https://gitlab.com/crdroidandroid/android_prebuilts_clang_host_linux-x86_clang-r445002 prebuilts/clang/host/linux-x86/clang-r445002 
#kalau mau pake micam, hapus # di bawah ini, kalau gak mau, yaudah
#git clone --depth=1 https://github.com/ArrowOS-Devices/android_vendor_miuicamera -b arrow-12.0-a3 vendor/miuicamera && cd f*/av && git fetch https://github.com/PixelOS-Pixelish/frameworks_av twelve-cam && git cherry-pick a2f7b6b0c385038a46b8eca763d9e91fd1a15e1f && git cherry-pick 53f3edd0f004b475a237605220a3abf5daf6ee3d && cd .. && cd base && git fetch https://github.com/PixelOS-Pixelish/frameworks_base twelve-old && git cherry-pick 97be12cd32c0fb8aefc6bb92b869a2e28655c18d && cd ../../
#Mulai build ROM 
. build/envsetup.sh
lunch aosp_juice-user
sudo mkdir /ccache 
mkdir tempcc
sudo umount /ccache
sudo chmod 777 /ccache
sudo mount --bind $PWD/tempcc /ccache
export USE_CCACHE=1
export CCACHE_EXEC=$(which ccache)
export CCACHE_DIR=/ccache
ccache -M 100G -F 0
make bacon -j20
ls out/target/product/juice
