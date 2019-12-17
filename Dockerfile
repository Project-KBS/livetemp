# Gebruik ubuntu als base img want alpine heeft problemen met i2c
FROM ubuntu:20.04

# Installeer alle benodigde software
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
		libi2c-dev \
		libc6-dev \
		pkg-config \
 && rm -rf /var/lib/apt/lists/*

# Kopieer onze applicatie naar de container en geef execute rechten
COPY cmake-build-debug/livetemp /wwi/livetemp
RUN chmod +x /wwi/livetemp

# Voer onze applicatie uit
CMD [ "/bin/bash", "-c", "/wwi/livetemp" ]