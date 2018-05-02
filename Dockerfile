FROM centos

RUN yum update && \
# Installing necessary yum packages for compilation
yum groupinstall -y core base "Development Tools" && \
# Downloading source files
cd /opt && \
wget https://repo.continuum.io/archive/Anaconda3-5.1.0-Linux-x86_64.sh && \
# Install Anaconda3
chmod +x /opt/Anaconda3-5.1.0-Linux-x86_64.sh &&\
/opt/Anaconda3-5.1.0-Linux-x86_64.sh -b -p /opt/conda && \
/opt/conda/bin/conda update -y --prefix /opt/conda conda && \
/opt/conda/bin/conda install -y jupyter numpy pandas r && \
# Setup for Jupyter Notebook
echo "export PATH=/opt/conda/bin:$PATH" > /etc/profile.d/conda.sh && \
groupadd -g 1000 jupyter && \
useradd -g jupyter -G wheel -m -s /bin/bash jupyter && \
echo "jupyter:jupyter" | chpasswd && \
echo "jupyter ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/jupyter && \
chmod 0440 /etc/sudoers.d/jupyter && \
echo "c.NotebookApp.token = 'jupyter'" > /home/jupyter/jupyter_notebook_config.py && \
# Remove files to reduce image size
rm -f /opt/Anaconda3-5.1.0-Linux-x86_64.sh && \
/opt/conda/bin/conda clean -y --all

EXPOSE 8888
USER jupyter
WORKDIR /home/jupyter

CMD ["/bin/bash", "-c", "/opt/conda/bin/jupyter-notebook --ip=*"]
