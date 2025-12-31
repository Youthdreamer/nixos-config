#!/usr/bin/env bash

set -euo pipefail

profiles=("power-saver" "balanced" "performance")
# icons=("" "" "")  # Nerd Font 图标
icons=("节能" "平衡" "性能") # Nerd Font 图标
labels=("省电模式" "平衡模式" "性能模式")

current=$(powerprofilesctl get)

case "$1" in
"get")
  # 输出 JSON 供 Waybar 解析
  for i in "${!profiles[@]}"; do
    if [[ "$current" == "${profiles[i]}" ]]; then
      echo "{\"text\":\"${icons[i]} \", \"tooltip\":\"当前模式：${labels[i]}\"}"
      exit
    fi
  done
  echo "{\"text\":\"?\", \"tooltip\":\"未知模式\"}"
  ;;
"toggle")
  # 切换模式
  for i in "${!profiles[@]}"; do
    if [[ "$current" == "${profiles[i]}" ]]; then
      next=$(((i + 1) % ${#profiles[@]}))
      powerprofilesctl set "${profiles[next]}"
      exit
    fi
  done
  powerprofilesctl set balanced # 默认回退
  ;;
esac

