import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_hosts_file(host):
    f = host.file('/etc/hosts')

    assert f.exists
    assert f.user == 'root'
    assert f.group == 'root'

#
# import os
# import testinfra.utils.ansible_runner
# testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
#     os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')
# def test_sos_report_package(host):
#     assert host.package("ossec-wazuh").is_installed
