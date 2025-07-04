Ubuntu | Docker Docs
https://docs.docker.com/engine/install/ubuntu/

Post-installation steps | Docker Docs
https://docs.docker.com/engine/install/linux-postinstall/

``` shell
sudo usermod -aG docker $USER
```

	Criar um container baseado em uma imagem
``` shell 
docker run <image>
```


Ver lista
``` shell 
docker ps
```

Ligar e desligar
``` shell 
docker start <id-container | names>
docker stop  <id-container | names>
```

Para executar o terminal interativo dentro do container, entrando no root@<id>

``` shell 
docker exec -it <id | names> bash
```

Existe uma opção de pause, o qual é equivalente a parar o processo, mas diferentemente não é como se a máquina desligasse (kill all)
``` shell 
docker pause <id-container | names>
docker unpause <id-container | names>
```

Interromper de maneira inatural (10s para desligamento seguro)
``` shell 
docker stop -t=0 <id-container | names>
```

	Argumento -d (detached) o terminal não fica preso.
``` shell 
docker run -d <image>
```

	Imagem que foi utilizada para a criação de site estático : dockersamples/static-site

	Para e remover
``` shell 
docker rm <id-container | name> --force
```

	Para criar mapeamento automático de portas 
``` shell 
docker run -d -P <image>
```

	Mostrar o mapeamento de portas de um host
``` shell 
docker port <id-container | name>
```

	Definir manualmente a porta do nosso hospedeiro para acessar a porta do hóspede
``` shell 
docker run -d -p <porta-hospedeira>:<porta-hóspede> <image>
```

Exemplo:
``` shell 
docker run -d -p 8080:80 dockersamples/static-site
```

	Para mostrar as imagens baixadas
``` shell 
docker images
```

	Para analisar uma imagem objetiva
``` shell 
docker inspect <id-image>
```

	Para ver o histórico
``` shell 
docker history <id-image>
```

IMAGEM (R/O) - CONTAINER (R/W)

imagem teste
``` shell 
docker build -t mateusanezsesmt/app-node:1.0 .
docker images
docker run -d -p 8081:3000 mateusanezsesmt/app-node:1.0
```

	Finalizando todos os containers
``` shell 
docker stop $(docker container ls -q)
```

Dockerfile
``` Dockerfile
Este é diferente pois está configurando e argumentando
FROM node:14
WORKDIR /app-node
ARG PORT_BUILD=6000
ENV PORT=$PORT_BUILD
EXPOSE $PORT_BUILD
COPY . .
RUN npm install
ENTRYPOINT npm start
```

	Publicar
``` shell 
docker push mateusanezsesmt/app-node:1.0
```

Inicialização definindo volume, Associa os dois.
``` shell 
docker run -it -v /home/usuario/volume-docker:/app ubuntu bash
docker run -it --mount type=bind,source=/home/daniel/volume-docker,target=/app ubuntu bash
```

	Criação de volume e visualização
``` shell 
docker volume ls
docker volume create meu-volume
```

``` shell 
docker run -it -v meu-volume:/app ubuntu bash
```

	Esse volume fica gravado no seguinte diretório /var/lib/docker/volumes/

	Listar redes
``` shell 
docker network ls
```

	Criar container com nome
``` shell 
docker run -it – ubuntu1 ubuntu bash
```

	Criar rede com nome
``` shell 
docker network create --driver bridge minha-bridge
```

Criar container com nome e rede definida
``` shell 
docker run -it – ubuntu1 --network minha-bridge ubuntu bash
```

		Assim é possível criar dois contêineres que se comuniquem. Eles utilizam o modo de rede bridge. Mas no modo de rede none eles não teriam uma interface de rede. No modo host, a interface do hospedeira é compartilhada com a hóspede.

Exemplo
``` shell 
docker pull aluradocker/alura-books:1.0
docker pull mongo:4.4.6
docker run -d --network minha-bridge --name meu-mongo mongo:4.4.6
docker run -d --network minha-bridge --name alurabooks -p 3000:3000 aluradocker/alura-books:1.0
```

	Como eles trabalham com nome é necessário apagar/remover o container, visto que os container podem ser restaurados
``` shell 
docker stop $(docker container ls -aq)
docker rm $(docker container ls -aq)
```

docker-compose.yml 


swarm e deploy - devops



===
copiar do Windows para o WSL
arquivo
``` sh
cp /mnt/c/Users/YourName/Documents/my_document.txt ~/
diretório
cp -r /mnt/c/Users/<YourUsername>/Desktop/MyProject ~/
cp -r /mnt/c/develop/wildfly ~/wildfly
```


build
``` sh
docker build -t meu_app:latest .
```




liberando WSL2 para o Windows, não deve ser necessário no ambiente produção

	PODE SER NECESSÁRIO RECONFIGURAR QUANDO REINICIAR A MÁQUINA

NO LINUX

	ip addr show eth0 | grep inet

NO WINDOWS (ADMIN)

	netsh interface portproxy add v4tov4 listenport=80 listenaddress=0.0.0.0 connectport=80 connectaddress=<resultado-do-anterior>
New-NetFirewallRule -DisplayName "Allow HTTP 80" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 80




/etc/systemd/system/wildfly.service
``` sh
[Unit]
Description=Wildfly service
After=network.target

[Service]
User=sesmt
Group=sesmt
WorkingDirectory=/home/sesmt/Documentos
ExecStart=/home/sesmt/Documentos/wildfly/bin/standalone.sh -c standalone-full.xml
Restart=on_failure

[Install]
WantedBy=multi-user.target
```


