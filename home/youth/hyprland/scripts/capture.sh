#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# 配置常量
# =============================================================================
readonly SCREENSHOT_DIR="$HOME/screenshot"
readonly RECORDING_DIR="$HOME/Videos/recordings"
readonly PIDFILE="/tmp/wf-recorder.pid"
readonly TIMESTAMP=$(date +%F-%H%M%S)
readonly ROFI_THEME="${ROFI_THEME:-$HOME/.config/rofi/themes/screenshot.rasi}"

# =============================================================================
# 工具函数
# =============================================================================

# 创建必要目录
create_directories() {
    mkdir -p "$SCREENSHOT_DIR" "$RECORDING_DIR"
}

# 检查依赖是否安装
check_dependency() {
    if ! command -v "$1" >/dev/null 2>&1; then
        notify-send "❌ 错误" "$1 未安装"
        return 1
    fi
    return 0
}

# 获取屏幕列表
get_screens() {
    if command -v wlr-randr >/dev/null 2>&1; then
        wlr-randr | awk '/^[^[:space:]]/ {print $1}'
    else
        echo ""
    fi
}

# 选择音频源
select_audio() {
    local choices="系统音频\n麦克风\n无音频"
    local choice=$(echo -e "$choices" | rofi -theme "$ROFI_THEME" -dmenu -p "选择音频源")

    [ -z "$choice" ] && echo "CANCELLED" && return

    local audio_option=""
    case "$choice" in
        "系统音频")
            audio_option="-a --audio-backend=pipewire"
            ;;
        "麦克风")
            audio_option="-a $(pw-dump | jq -r '.[] | select(.type=="PipeWire:Interface:Node" and .info.props["media.class"]=="Audio/Source") | .info.props["node.name"]')"
            ;;
    esac

    echo "$audio_option"
}

# 选择屏幕
select_screen() {
    local screens=($(get_screens))

    if [ "${#screens[@]}" -eq 0 ]; then
        notify-send "❌ 错误" "未检测到屏幕"
        echo "CANCELLED"
        return
    elif [ "${#screens[@]}" -eq 1 ]; then
        echo "${screens[0]}"
    else
	local selected=$(echo "${screens[@]}" | tr ' ' '\n' | rofi -theme "$ROFI_THEME" -dmenu -p "选择屏幕")
	# 如果按 ESC，selected 为空
        if [ -z "$selected" ]; then
            echo "CANCELLED"
        else
            echo "$selected"
        fi
    fi
}

# 选择区域（ESC 取消）
select_region() {
    if ! check_dependency "slurp"; then
        echo "CANCELLED"
        return
    fi
    
    local region=$(slurp)
    # 如果用户按 ESC 选择区域，slurp 会返回非零退出码，region 为空
    if [ -z "$region" ]; then
        echo "CANCELLED"
    else
        echo "$region"
    fi
}

# 启动录屏
start_recording() {
    local file="$1"
    local region="${2:-}"
    local screen="${3:-}"
    local audio="${4:-}"

    local cmd=(wf-recorder -f "$file" -c h264_vaapi -r 30)

    [ -n "$region" ] && cmd+=(-g "$region")
    [ -n "$screen" ] && cmd+=(-o "$screen")
    if [ -n "$audio" ] && [ "$audio" != "CANCELLED" ]; then
        eval "cmd+=($audio)"
    fi

    "${cmd[@]}" &
    echo $! > "$PIDFILE"
}

# 处理截图后续操作
handle_screenshot_action() {
    local file="$1"

    if [ ! -f "$file" ]; then
        return 1
    fi

    local action=$(echo -e "编辑并保存\n仅保存\n仅复制到剪贴板\n取消" | \
                   rofi -theme "$ROFI_THEME" -dmenu -p "截图完成，选择操作:")

    # 如果按 ESC，action 为空，等同于取消
    if [ -z "$action" ]; then
        action="取消"
    fi

    sleep 0.2

    case "$action" in
        "编辑并保存")
            satty -f "$file" -o "$file"
            wl-copy --type image/png < "$file"
            notify-send "📸 截图已保存并复制到剪贴板" "$file"
            ;;
        "仅保存")
            notify-send "📸 截图已保存" "$file"
            ;;
        "仅复制到剪贴板")
            wl-copy --type image/png < "$file"
            rm "$file"
            notify-send "📋 截图已复制到剪贴板"
            ;;
        "取消")
            rm "$file"
            notify-send "❌ 截图已取消"
            ;;
    esac
}

# =============================================================================
# 截图功能
# =============================================================================

take_fullscreen_screenshot() {
    local file="$SCREENSHOT_DIR/${TIMESTAMP}.png"

    if ! check_dependency "grim"; then
        return 1
    fi

    grim "$file"
    echo "$file"
}

take_region_screenshot() {
    local file="$SCREENSHOT_DIR/${TIMESTAMP}.png"

    if ! check_dependency "grim" || ! check_dependency "slurp"; then
        return 1
    fi

    local region=$(select_region)
    # 如果用户在选择区域时按 ESC，取消截图
    if [ "$region" = "CANCELLED" ]; then
        # 删除可能已经创建的文件
        [ -f "$file" ] && rm "$file"
        echo "CANCELLED"
        return
    fi

    grim -g "$region" "$file"
    echo "$file"
}

# 录屏状态下的截图处理
handle_recording_screenshot() {
    local type="$1"  # "full" 或 "region"
    local file

    if [ "$type" = "full" ]; then
        file=$(take_fullscreen_screenshot)
    else
        file=$(take_region_screenshot)
    fi

    # 截图被取消（包括 ESC 按键）
    if [ "$file" = "CANCELLED" ]; then
        notify-send "📸 截图已取消"
        return
    fi

    if [ -n "$file" ]; then
        # 在录屏状态下也显示完整的二级菜单
        handle_screenshot_action "$file"
    fi
}

# =============================================================================
# 录屏功能
# =============================================================================

start_screen_recording() {
    local recording_type="$1"  # "fullscreen" 或 "region"
    local timestamp=$(date +%F-%H%M%S)
    local file="$RECORDING_DIR/recording_${TIMESTAMP}.mp4"

     # 选择音频（ESC 取消）
    local audio=$(select_audio)
    if [ "$audio" = "CANCELLED" ]; then
        notify-send "🎬 录屏已取消" "用户取消了音频选择"
        return 1
    fi

    # 选择屏幕（ESC 取消）
    local screen=$(select_screen)
    if [ "$screen" = "CANCELLED" ]; then
        notify-send "🎬 录屏已取消" "用户取消了屏幕选择"
        return 1
    fi

    local region=""

    [ -z "$screen" ] && return 1

    if [ "$recording_type" = "region" ]; then
        # 选择区域（ESC 取消）
	region=$(select_region)
        if [ "$region" = "CANCELLED" ]; then
            notify-send "🎬 录屏已取消" "用户取消了区域选择"
            return 1
        fi
    fi

    start_recording "$file" "$region" "$screen" "$audio"
    notify-send "🎬 录屏开始" "屏幕: $screen\n文件: $file\n音频: ${audio:-无}"
}

# =============================================================================
# 主函数
# =============================================================================

main() {
    create_directories

    # 检查是否正在录屏
    if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
       local action=$(echo -e "停止录屏\n全屏截图\n区域截图\n取消" | rofi -theme "$ROFI_THEME" -dmenu -p "录屏中，选择操作:")

        # 按 ESC，action 为空，等同于取消
        if [ -z "$action" ]; then
            action="取消"
        fi

        case "$action" in
            "停止录屏")
                kill "$(cat "$PIDFILE")"
                rm "$PIDFILE"
                notify-send "🎬 录屏已停止"
                ;;
            "全屏截图")
                sleep 0.2
                handle_recording_screenshot "full"
                ;;
            "区域截图")
                handle_recording_screenshot "region"
                ;;
            "取消")
                # 什么都不做，直接退出
                ;;
        esac
        exit 0
    fi

    # 主菜单选择
    local choice=$(echo -e "全屏截图\n区域截图\n全屏录屏\n区域录屏\n取消" | \
                   rofi -theme "$ROFI_THEME" -dmenu -p "选择操作:")

    # 按 ESC，choice 为空，等同于取消
    if [ -z "$choice" ]; then
        choice="取消"
    fi

    sleep 0.2

    local screenshot_file=""

    case "$choice" in
        "全屏截图")
            screenshot_file=$(take_fullscreen_screenshot)
            ;;
        "区域截图")
            screenshot_file=$(take_region_screenshot)
            ;;
        "全屏录屏")
            start_screen_recording "fullscreen"
            exit 0
            ;;
        "区域录屏")
            start_screen_recording "region"
            exit 0
            ;;
        "取消")
            exit 0
            ;;
    esac

    # 处理截图后续操作
    if [ -n "$screenshot_file" ] && [ "$screenshot_file" != "CANCELLED" ]; then
        handle_screenshot_action "$screenshot_file"
    elif [ "$screenshot_file" = "CANCELLED" ]; then
        notify-send "📸 截图已取消"
    fi
}

# =============================================================================
# 脚本入口
# =============================================================================
main "$@"
