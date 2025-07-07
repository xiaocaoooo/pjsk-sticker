# 将./assets/characters/下的文件全部改为小写，处理递归

import os

def rename_file(path):
    if os.path.isdir(path):
        for file in os.listdir(path):
            rename_file(os.path.join(path, file))
    else:
        os.rename(path, path.lower())

if __name__ == "__main__":
    rename_file("./assets/characters/")
