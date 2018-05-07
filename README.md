# centos-jupyter
Jupyter Notebook Docker image for x86_64 platform

Used [centos](https://hub.docker.com/_/centos/) as base image, and [Anaconda3 5.1.0](https://repo.continuum.io/archive/) for jupyter notebook.

How to Run the image
------------
Under docker-enabled environment, execute the following;
```
docker run -d -it -p 8888:8888 -v $PWD:/home/jupyter --name centos-jupyter domosute/centos-jupyter
```
where "$PWD" is outside working directory in case if persistent storage is preferred.

Storing `jupyter_notebook_config.py` under working directory would enable password access instead of token. (default is set as 'jupyter')
