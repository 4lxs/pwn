FROM skysider/pwndocker:latest

COPY .tmux.conf /root/.tmux.conf

CMD [ "tmux" ]
