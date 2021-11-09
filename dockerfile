FROM coctohug-body:latest
ARG CODE_BRANCH

# copy local files
COPY . /coctohug/

# set workdir
WORKDIR /chia-blockchain

# Install Chia (and forks), Plotman, Chiadog, Coctohug, etc
RUN \
	/usr/bin/bash /coctohug/chain_install.sh ${CODE_BRANCH} \
	&& /usr/bin/bash /coctohug/coctohug_install.sh \
	&& rm -rf \
		/root/.cache \
		/tmp/* \
		/var/lib/apt/lists/* \
		/var/tmp/*

# Provide a colon-separated list of in-container paths to your mnemonic keys
ENV keys="/root/.chia/mnemonic.txt"  
# Provide a colon-separated list of in-container paths to your completed plots
ENV plots_dir="/plots"
# One of fullnode, farmer, harvester, plotter, farmer+plotter, harvester+plotter. Default is fullnode
ENV mode="fullnode" 
# If mode=harvester, required for host and port the harvester will your farmer
ENV farmer_address="null"

ENV PATH="${PATH}:/chia-blockchain/venv/bin"
ENV TZ=Etc/UTC
ENV FLASK_ENV=production
ENV XDG_CONFIG_HOME=/root/.chia

VOLUME [ "/id_rsa" ]

# Local network hostname of a Coctohug controller - localhost when standalone
ENV controller_address="localhost"
ENV controller_web_port=12530

ENV worker_address="localhost"
ENV worker_web_port=12532
EXPOSE 12531

# full name of blockchain
ENV blockchain="flora"

# blockchain protocol port - forward at router
EXPOSE 18644

# blockchain farmer port - DO NOT forward at router
ENV farmer_port="18647"
EXPOSE 18647

WORKDIR /chia-blockchain
ENTRYPOINT ["bash", "./entrypoint.sh"]