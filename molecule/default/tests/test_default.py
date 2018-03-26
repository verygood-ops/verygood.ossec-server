import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
  os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_hosts_file(host):
  f = host.file('/etc/hosts')

  assert f.exists
  assert f.user == 'root'
  assert f.group == 'root'


def test_ossec_package(host):
  ossec = host.package("ossec-wazuh")
  assert ossec.is_installed


def test_ossec_running_and_enabled(host):
  ossec = host.service("wazuh-manager")
  assert ossec.is_running
  assert ossec.is_enabled


def test_ossec_ports_opened(host):
  ossec_tcp = host.socket("tcp://0.0.0.0:1515")
  ossec_udp = host.socket("udp://0.0.0.0:1514")
  assert ossec_tcp.is_listening
  assert ossec_udp.is_listening
