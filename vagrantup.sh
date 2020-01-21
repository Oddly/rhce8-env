#!/bin/bash
read -p 'Provide the exam version (1/2): ' exam_version
echo exam_version: $exam_version > playbooks/vagrant_ansible.yml
vagrant up
