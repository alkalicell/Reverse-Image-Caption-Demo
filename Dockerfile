# tf_project/Dockerfile
FROM tensorflow/tensorflow:2.16.1-gpu

# 1. 安裝系統依賴
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
    pandas \
    matplotlib \
    Pillow \
    scikit-learn \
    imgaug


# 設定工作目錄
WORKDIR /tf

# 開放 8888 端口
EXPOSE 8888

# 啟動 Jupyter Lab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser", "--NotebookApp.token=", "--NotebookApp.password=", "--NotebookApp.allow_origin='*'"]