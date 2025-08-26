import os


if __name__ == "__main__":
    res=dict()
    ls= os.listdir("./assets/characters/")
    for i in ls:
        if os.path.isdir("./assets/characters/"+i):
            res[i]=os.listdir("./assets/characters/"+i)
    print(res)
    # counts={}
    # for i in res:
    #     counts[i]=len(res[i])
    # print(counts)
