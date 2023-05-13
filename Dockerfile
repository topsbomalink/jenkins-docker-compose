FROM topsinfinite/jenkin-maven-agent

COPY requirements.txt requirements.txt

RUN echo "export M2_HOME=/opt/maven" >> ~/.bashrc
RUN echo "export PATH=/opt/maven/bin:${PATH}" >> ~/.bashrc

RUN apt update
RUN apt update && apt install -y lsb-release python3.9 python3-pip git curl

RUN pip3 install -r requirements.txt

RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt update && apt install -y docker-ce-cli docker-ce containerd.io docker-compose-plugin
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN usermod -a -G docker jenkins




 
