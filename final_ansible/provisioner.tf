resource "null_resource" "run_ansible_playbook" {
  depends_on = [module.linux_vms]

  provisioner "local-exec" {
    command = <<EOT
      mkdir -p /home/n01698490/automation/ansible/ansible_project_n01698490

      echo "[linux]" > /home/n01698490/automation/ansible/ansible_project_n01698490/hosts
      echo "${join("\n", [for ip in module.linux_vms.linux_vm_public_ips : "${ip} ansible_user=azureuser ansible_ssh_private_key_file=/home/n01698490/john/my_rsa_key"])}" >> /home/n01698490/automation/ansible/ansible_project_n01698490/hosts

      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i /home/n01698490/automation/ansible/ansible_project_n01698490/hosts /home/n01698490/automation/ansible/ansible_project_n01698490/n01698490-playbook.yml
    EOT

    interpreter = ["/bin/bash", "-c"]
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}
