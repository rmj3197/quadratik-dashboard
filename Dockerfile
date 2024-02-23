FROM python:3.11-slim

RUN pip3 install --no-cache-dir --upgrade \
    pip \
    virtualenv

RUN apt-get update && apt-get install -y \
    build-essential \
    software-properties-common \
    git \
    latexmk

WORKDIR /home/app

RUN git clone https://github.com/rmj3197/test-repo.git .

ENV VIRTUAL_ENV=/home/app/venv

RUN virtualenv ${VIRTUAL_ENV}
RUN . ${VIRTUAL_ENV}/bin/activate && pip install QuadratiK

RUN echo $PATH

EXPOSE 8501
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
ENTRYPOINT ["streamlit","run","QuadratiK/ui/_Introduction.py","--server.maxUploadSize","20", "--theme.base","light","--theme.secondaryBackgroundColor","#E5E4E2","--theme.textColor","#0e0e0e"]
