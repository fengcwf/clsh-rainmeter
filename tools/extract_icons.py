# Auto-extract icons from a regularly-gridded sprite sheet

# Usage:
#   python extract_icons.py path/to/icons.png icon_width icon_height
# Example:
#   python extract_icons.py @Resources/Images/icons.png 48 48

from PIL import Image
import sys

def main():
    if len(sys.argv) < 4:
        print("Usage: python extract_icons.py <image_path> <icon_width> <icon_height>")
        return
    img_path = sys.argv[1]
    icon_w = int(sys.argv[2])
    icon_h = int(sys.argv[3])
    out_map = img_path.replace('.png', '.map')

    im = Image.open(img_path)
    W, H = im.size
    cols = W // icon_w
    rows = H // icon_h

    with open(out_map, 'w', encoding='utf-8') as f:
        idx = 0
        for r in range(rows):
            for c in range(cols):
                left = c*icon_w
                top = r*icon_h
                f.write(f"icon_{idx}={left},{top},{icon_w},{icon_h}\n")
                idx += 1
    print(f"Generated {out_map} with {idx} entries")

if __name__ == '__main__':
    main()
