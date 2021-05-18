FROM williamyeh/ansible:ubuntu18.04

RUN apt-get update && apt-get upgrade -y &&\
    apt-get install --no-install-recommends --no-install-suggests -y curl cron iproute2 &&\
    rm -rf /var/lib/apt/lists/*
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ENVANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_ENABLE_TASK_DEBUGGER True
ENV ENVANSIBLE_GATHERING smart

ENV PATH /opt/ansible/ansible/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin/
RUN pip install netaddr &&\
    apt-get autoremove &&\
    apt-get clean

WORKDIR /opt/ansible

COPY . ./

RUN sed -i -e "s/udp/tcp/" ./verygood.ossec-server/templates/ossec.conf

EXPOSE 1514/tcp 514/tcp

RUN chmod 755 ./entry.bash

RUN ansible-playbook -i inventory -c local install.yml -vvv

ENTRYPOINT ["./entry.bash"]



