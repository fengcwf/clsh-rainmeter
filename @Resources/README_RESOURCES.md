# README for Resources

本文件说明 @Resources/Images 中资源与 icons.map 的使用方式。

- icons.png: 图标雪碧图（sprite），可通过 ImageCrop 在 Rainmeter Meter=Image 中裁剪。
- icons.map: 图标坐标映射，格式为 name=left,top,width,height。

如何生成或更新 icons.map：
1. 本仓库包含 tools/extract_icons.py 脚本，可在有 Python 环境的机器上运行：
   - 安装依赖：pip install pillow
   - 运行：python tools/extract_icons.py @Resources/Images/icons.png 48 48
   - 该脚本会根据指定的 icon 宽高（示例 48x48）自动生成 icons.map（按规则网格命名为 icon_0..icon_n）。
2. 如果 icons.png 布局不规则，请使用图像编辑器手动测量并编辑 icons.map，或在运行脚本后手动替换键名为更语义化的名称（如 clock, battery）。

在 Rainmeter .ini 中使用：
- 将 icons.map 的条目复制到组件的 [Variables] 中，或直接通过脚本生成 Variables 段。
- 示例：

IconClockCrop=0,0,48,48

[MeterIcon]
Meter=Image
ImageName=#@#\Images\icons.png
ImageCrop=#IconClockCrop#
W=24
H=24

