test:
	echo 'Hello world!'

add-do-token:
	@echo do_token = \"$(do_token)\" > terraform/vars.auto.tfvars
tf-init:
	cd terraform; terraform init
tf-plan:
	cd terraform; terraform plan
tf-apply:
	cd terraform; terraform apply
add-requirements:
	cd ansible; ansible-galaxy install -r requirements.yml
	cd ansible; ansible-galaxy collection install -r requirements.yml

start-playbook:
	cd ansible; ansible-playbook -i ansible/inventory.ini ansible/playbook.yml --vault-password-file ~/.ansible_pass.txt

encrypt-string:
	cd ansible; ansible-vault encrypt_string --vault-password-file ~/.ansible_pass.txt $(secret_value) --name $(secret_name)

test-app:
	@curl -s --max-time 1 http://project.gitpushforce.club:80| grep -P -o 'Welcome to your Strapi app'
