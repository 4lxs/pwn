FROM skysider/pwndocker:latest

RUN pip3 install jupyter notebook

COPY .tmux.conf /root/.tmux.conf
CMD [ "jupyter","notebook","--ip","0.0.0.0","--port","8888","--no-browser","--allow-root","--NotebookApp.token='letmein'","--NotebookApp.password='letmein'" ]
