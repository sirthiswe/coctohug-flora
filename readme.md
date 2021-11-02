# the flora hand
- flora specific docker
- watchdog with worker mode

# build
- sudo docker build --no-cache --build-arg FLORA_BRANCH=main -t coctohug-flora:latest .
- sudo docker build --build-arg FLORA_BRANCH=main -t coctohug-flora:latest .

# docker-compose
- coctohug-flora: 
        image: coctohug-flora:latest 
        container_name: coctohug-flora
        hostname: pc1 
        restart: always 
        volumes: 
            - ~/.coctohug-flora:/root/.chia 
            - "/mnt/disk1:/plots1" 
            - "/mnt/disk2:/plots2" 
        environment: 
            - mode=fullnode 
            - worker_address=192.168.1.74 
            - plots_dir=/plots1:/plots2 
            - blockchains=flora 
        ports: 
            - 18644:18644 
            - 18647:18647