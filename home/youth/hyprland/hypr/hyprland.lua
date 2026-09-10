local terminal = "kitty"
local yazi_filemanager = "yazi"
local menu = "rofi -show drun -theme ~/.config/rofi/themes/app.rasi"
local google_browser = "google-chrome-stable"
local firefox_browser = "firefox"
local music = "spotify"

-- 快捷键
local mainMod = "SUPER + "
local super_shift = "SUPER + SHIFT + "
local super_alt = "SUPER + ALT + "

hl.monitor({
	output = "",
	mode = "1920x1080@144",
	position = "auto",
	scale = 1,
})

-- 开机自启动
hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("xdg-desktop-portal-hyprland")
	hl.exec_cmd("xdg-desktop-portal")
	hl.exec_cmd("xdg-desktop-portal-hyprland --force-global")
	-- 音频服务
	hl.exec_cmd("systemd --user restart pipewire.service")
	hl.exec_cmd("systemd --user restart pipewire-pulse.service")
	hl.exec_cmd("systemd --user restart wireplumber.service")
	-- 开机自启动软件
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("wayvnc 0.0.0.0")
	hl.exec_cmd("waybar & awww-daemon")
	hl.exec_cmd("swaync")
	hl.exec_cmd("fcitx5")
	hl.exec_cmd("clash-verge")
end)

-- 环境设置
hl.env("LANG", "zh_CN.UTF-8")
hl.env("LC_ALL", "zh_CN.UTF-8")

-- 字体与渲染相关
hl.env("XFT_DPI", "96")
hl.env("XFT_ANTIALIAS", "1")
hl.env("XFT_HINTING", "1")
hl.env("XFT_HINTSTYLE", "hintfull")
hl.env("XFT_RGBA", "rgb")

-- Wayland 缩放与 DPI
hl.env("GDK_SCALE", "1")
hl.env("GDK_DPI_SCALE", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")

-- 游标 & 图标大小（可选）
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Breeze")

-- 杂项设置
hl.config({
	debug = {
		disable_logs = false,
		enable_stdout_logs = true,
	},
	ecosystem = {
		no_update_news = true, -- 禁用Hyprland更新后弹出的更新新闻窗口
		no_donation_nag = true, -- 禁用每年两次的捐赠提示窗口
	},
	misc = {
		disable_hyprland_logo = false, -- 禁用随机出现的动漫女孩或者LOGO
		force_default_wallpaper = -1, -- 强制使用三块壁纸之一，-1随机，0与1可禁用动漫壁纸
	},
})

-- 通用配置与布局选择
hl.config({
	-- 窗口基本样式
	general = {
		gaps_out = 5, -- 窗口与显示器之间空隙
		border_size = 2, -- 窗口边框宽度
		-- 窗口边框颜色
		col = {
			active_border = 0xffb48ead,
			inactive_border = 0x94a38c9e,
		},
		-- 按下窗口边框拖动改变大小
		resize_on_border = true,
		extend_border_grab_area = 40, -- 可点击拖动范围
		-- 画面撕裂，实验阶段，游戏玩家考虑选择
		allow_tearing = false,
		-- 布局
		layout = "dwindle",

		-- 浮动窗口吸附
		snap = {
			enabled = true, -- 功能开启
			window_gap = 20, -- 窗口间最小吸附间隙
			monitor_gap = 20, -- 窗口屏幕间最小吸附间隙
			border_overlap = false, -- 吸附后的俩个窗口边框是否重叠
		},
	},
	-- 布局设置
	dwindle = {
		force_split = 0,
		preserve_split = true,
		smart_split = false,
		smart_resizing = true,
		permanent_direction_override = false,
		special_scale_factor = 1,
		split_width_multiplier = 1.0,
		use_active_for_splits = true,
		default_split_ratio = 1.0,
		split_bias = 0,
		precise_mouse_move = false,
	},
})

-- 窗口边框及基本配置
hl.config({
	-- 窗口样式配置
	decoration = {
		rounding = 10, -- 圆角半径
		rounding_power = 2.0, -- 圆角曲线，2.0圆形，4.0圆角矩形
		-- 窗口不透明及亮度调整
		active_opacity = 0.95, -- 当前活动窗口不透明度
		inactive_opacity = 0.95, -- 非活动窗口不透明度
		fullscreen_opacity = 1, -- 全屏窗口不透明度
		dim_inactive = true, -- 非活动窗口是否变暗
		dim_strength = 0.2, -- 变暗强度
		dim_special = 0.2, -- 特殊功能工作区打开时候，调整其他屏幕变暗
		dim_around = 0.4, -- 周围窗口变暗，强调突出窗口
		-- 阴影效果
		shadow = {
			enabled = true, -- 启用窗口阴影投影效果
			range = 10, -- 设置阴影范围尺寸，px
			render_power = 2, -- 渲染功率，数值越大负载越大
			color = 0x70000000, -- 阴影颜色
			color_inactive = 0x50000000, -- 非活动窗口阴影
			offset = { 4, 4 }, -- 阴影偏移
		},
		-- 模糊效果
		blur = {
			-- 窗口模糊设置
			enabled = true, -- 开启窗口模糊效果
			size = 8, -- 模糊范围
			passes = 2, -- 模糊处理次数，至少为1，高数值会增加GPU负载
			brightness = 1.2, -- 模糊区域亮度，范围[0.0,2.0]
			vibrancy = 0.3, -- 模糊区域的色彩饱和度，效果颜色更鲜艳
			new_optimizations = true, -- 模糊效果优化，提高性能，建议开启
			-- 特殊工作区及弹出窗口模糊设置
			popups = true, -- 弹出窗口模糊，统一窗口效果，如右键菜单
			-- 输入法菜单模糊设置
			input_methods = true, -- 输入法窗口模糊设置
			input_methods_ignorealpha = 0, -- 忽略透明像素
			ignore_opacity = true, -- 模糊层是否忽略窗口不透明度
			xray = true, -- 浮动窗口忽略平铺窗口模糊效果，提升性能，仅在new_optimizations开启是时可用
		},
	},
})

-------------------------------------------------
-- 动画
-- 自定义贝塞尔曲线
hl.curve("gentle", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } }) -- 温和缓动，平缓自然
hl.curve("natural", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } }) -- 标准流畅。类似于css的ease-out
hl.curve("smoothOut", { type = "bezier", points = { { 0.25, 0.46 }, { 0.45, 0.94 } } }) -- 平缓自然
hl.curve("spring", { type = "bezier", points = { { 0.175, 0.885 }, { 0.32, 1.155 } } }) -- 弹簧效果
hl.curve("rocket", { type = "bezier", points = { { 0.55, 0 }, { 0.1, 1 } } }) -- 火箭效果，慢进快出
hl.curve("brake", { type = "bezier", points = { { 0.9, 0 }, { 0.45, 1 } } }) -- 刹车效果，慢->快->刹停
hl.curve("rubber", { type = "bezier", points = { { 0.68, -0.15 }, { 0.265, 1 } } }) -- 橡胶带效果，先快后回拉
hl.curve("organic", { type = "bezier", points = { { 0.645, 0.045 }, { 0.355, 1 } } }) -- 呼吸感，平缓自然
hl.curve("robotic", { type = "bezier", points = { { 0.42, 0 }, { 0.58, 1 } } }) -- 通用过度，对称加减速，平滑启停

-- 工作区贝塞尔曲线变量(回弹，动感)
hl.curve("easeInExpoSharp", { type = "bezier", points = { { 0.25, 1.0 }, { 0.5, 1.13 } } })
hl.curve("easeOutElastic", { type = "bezier", points = { { 0.3, 0.3 }, { 0.5, 1.12 } } })

-- 默认
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
-- 边框动画设置
hl.animation({ leaf = "border", enabled = true, speed = 15, bezier = "easeOutQuint" })
-- 窗口动画设置
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3.6, bezier = "gentle", style = "popin 70%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 49, bezier = "spring", style = "popin 70%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 2.8, bezier = "spring" })
-- 图层动画
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "rubber", style = "slide top" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 3, bezier = "robotic", style = "slide top" })
-- 窗口的淡入淡出
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "smoothOut" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "smoothOut" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 2.3, bezier = "smoothOut" })
hl.animation({ leaf = "fadeShadow", enabled = true, speed = 2.6, bezier = "smoothOut" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 2.6, bezier = "smoothOut" })
-- 弹窗的淡入淡出
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 2.79, bezier = "organic" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "organic" })
-- 工作区
hl.animation({ leaf = "workspaces", enabled = true, speed = 3.8, bezier = "organic", style = "slidefadevert" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 3.4, bezier = "organic", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 3.6, bezier = "organic", style = "slide" })

-------------------------------------------------
-- 窗口规则
hl.window_rule({
	match = {
		class = ".*",
	},
	suppress_event = "maximize",
})

hl.window_rule({
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
})

hl.window_rule({
	match = {
		class = "floating-term",
	},
	center = true,
	size = { "(monitor_w*0.6)", "(monitor_h*0.6)" },
	float = true,
})

hl.layer_rule({
	match = {
		namespace = "logout_dialog",
	},
	blur = true,
})
hl.layer_rule({
	match = {
		namespace = "notifications",
	},
	blur = true,
	blur_popups = true,
	xray = true,
})
hl.layer_rule({
	match = {
		namespace = "rofi",
	},
	blur = true,
	blur_popups = true,
	xray = true,
	ignore_alpha = false,
})

-------------------------------------------------
-- 快捷键
hl.bind(mainMod .. "return", hl.dsp.exec_cmd(terminal)) -- 打开默认终端
hl.bind(super_shift .. "return", hl.dsp.exec_cmd(terminal .. " --class floating-term")) -- 标记浮动终端，在窗口规则设置浮动终端样式
hl.bind(mainMod .. "b", hl.dsp.exec_cmd(google_browser)) -- 打开谷歌浏览器
hl.bind(super_shift .. "b", hl.dsp.exec_cmd(firefox_browser))
hl.bind(mainMod .. "m", hl.dsp.exec_cmd(music))
hl.bind(mainMod .. "d", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. "e", hl.dsp.exec_cmd("EDITOR=nvim kitty " .. yazi_filemanager))
hl.bind(mainMod .. "n", hl.dsp.exec_cmd("neovide"))
hl.bind(mainMod .. "l", hl.dsp.exec_cmd("hyprlock"))
hl.bind(super_shift .. "ESCAPE", hl.dsp.exec_cmd("wlogout -b 4"))

hl.bind(
	super_shift .. "r",
	hl.dsp.exec_cmd("hyprctl reload && \
    if pidof waybar > /dev/null; then pkill waybar; fi && waybar & \
    if pidof wayvnc > /dev/null; then pkill wayvnc; fi && wayvnc 0.0.0.0 &")
)

hl.bind(mainMod .. "q", hl.dsp.window.kill()) -- 关闭窗口
hl.bind(
	super_shift .. "g",
	hl.dsp.exec_cmd('\
    file=~/screenshot/$(date +\'%Y-%m-%d-%H%M%S\').png && \
    grim -g "$(slurp)" $file && \
    wl-copy < $file && \
    satty --filename $file --output-filename $file && \
    wl-copy < $file && \
    notify-send "区域截图,已保存至~/screenshot并打开编辑器"')
) -- 区域截图
hl.bind(mainMod .. "g", hl.dsp.exec_cmd("~/.config/hypr/scripts/capture.sh")) -- 捕获功能
hl.bind(super_shift .. "w", hl.dsp.exec_cmd("~/.config/wallpaper/script/awww-rofi.sh")) -- 壁纸切换快捷键
-- 窗口快捷键
hl.bind(mainMod .. "f", hl.dsp.window.fullscreen_state({ internal = 2, client = 0, action = "toggle" })) -- 全屏
hl.bind(super_shift .. "f", hl.dsp.window.fullscreen_state({ internal = 1, client = 0, action = "toggle" })) -- 假全屏（最大化但保留状态栏）
hl.bind(mainMod .. "p", hl.dsp.window.float({ action = "toggle" })) -- 切换当前窗口的布局模式为浮动模式或平铺模式
hl.bind(super_shift .. "p", hl.dsp.window.pin({ action = "toggle" })) -- 固定浮动窗口
hl.bind(super_shift .. "a", hl.dsp.window.center()) -- 窗口居中
hl.bind(mainMod .. "v", hl.dsp.window.pseudo({ action = "toggle" })) --  伪窗口模式（pseudo 模式），常用来布局微调，配合改变窗口大小使用
hl.bind(mainMod .. "j", hl.dsp.layout("togglesplit")) --  切换当前窗口的分割方向（水平/垂直）

-- 使用主修饰键（mainMod）加方向键来移动焦点
-- 从浮窗 / 当前窗口回到上一个窗口（通常是平铺主窗口）
hl.bind(mainMod .. "tab", hl.dsp.window.cycle_next())
hl.bind(mainMod .. "left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. "right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. "up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. "down", hl.dsp.focus({ direction = "d" }))
-- 移动窗口交换位置
hl.bind(super_shift .. "left", hl.dsp.window.swap({ direction = "l" }))
hl.bind(super_shift .. "right", hl.dsp.window.swap({ direction = "r" }))
hl.bind(super_shift .. "up", hl.dsp.window.swap({ direction = "u" }))
hl.bind(super_shift .. "down", hl.dsp.window.swap({ direction = "d" }))

-- 调整窗口大小
-- 右箭头：向右下扩大（正数）
hl.bind(super_alt .. "right", hl.dsp.window.resize({ x = 10, y = 10, relative = true }))
-- 左箭头：向左上缩小（负数）
hl.bind(super_alt .. "left", hl.dsp.window.resize({ x = -10, y = -10, relative = true }))

-- 鼠标拖动：移动 / 调整窗口（bindm）
-- 鼠标左键（272）拖动窗口
hl.bind(mainMod .. "mouse:272", hl.dsp.window.drag())
-- 鼠标右键（273）调整窗口大小
hl.bind(mainMod .. "mouse:273", hl.dsp.window.resize())

-- 工作区切换（workspace）
-- 鼠标滚轮在工作区之间循环
hl.bind(mainMod .. "mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. "mouse_down", hl.dsp.focus({ workspace = "e+1" }))

-- 主修饰键 + 数字键 0~9 切换到对应工作区（0 对应 10）
hl.bind(mainMod .. "1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. "2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. "3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. "4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. "5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. "6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. "7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. "8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. "9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. "0", hl.dsp.focus({ workspace = 10 }))
-- 主修饰键 + [ / ] 切换到上一个/下一个工作区
hl.bind(mainMod .. "bracketleft", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. "bracketright", hl.dsp.focus({ workspace = "e+1" }))
-- 移动到最近的空工作区
hl.bind(mainMod .. "z", hl.dsp.focus({ workspace = "empty" }))

-- 将当前窗口移动到指定工作区（movetoworkspace）
-- 移动到数字工作区 1~10
hl.bind(super_shift .. "1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(super_shift .. "2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(super_shift .. "3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(super_shift .. "4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(super_shift .. "5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(super_shift .. "6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(super_shift .. "7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(super_shift .. "8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(super_shift .. "9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(super_shift .. "0", hl.dsp.window.move({ workspace = 10 }))
-- 移动到上一个/下一个工作区（相对移动）
hl.bind(super_shift .. "bracketleft", hl.dsp.window.move({ workspace = "r-1" }))
hl.bind(super_shift .. "bracketright", hl.dsp.window.move({ workspace = "r+1" }))
-- 将窗口移动到空工作区（empty 目标）
hl.bind(super_shift .. "z", hl.dsp.window.move({ workspace = "empty" }))

-- 特殊工作区（"隐藏桌面" 功能）
-- 注意：特殊工作区名称 "special:" 中的图标需与你的字体兼容
hl.bind(mainMod .. "s", hl.dsp.workspace.toggle_special("")) -- 切换特殊工作区
hl.bind(super_shift .. "s", hl.dsp.window.move({ workspace = "special:" })) -- 当前窗口移入特殊工作区

-- 额外：将窗口移动到 +0 工作区（可能用于快速移回？保留原样）
hl.bind(super_shift .. "x", hl.dsp.window.move({ workspace = 0 }))
