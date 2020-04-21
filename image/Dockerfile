FROM ansible/ubuntu14.04-ansible
RUN apt-get update &&\
    apt-get install --no-install-recommends --no-install-suggests -y curl &&\
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
COPY vgs_rules.xml.j2 verygood.ossec-server/templates/vgs_rules.xml.j2

EXPOSE 1514/tcp 514/tcp

RUN chmod 755 ./entry.bash
RUN sed -i -e "s/\>udp\</\>tcp\</" verygood.ossec-server/templates/ossec.conf

RUN ansible-playbook -i inventory -c local install.yml -vv

ENTRYPOINT ["./entry.bash"]



