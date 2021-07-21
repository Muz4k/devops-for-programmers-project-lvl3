test:
	echo 'Hello world!'

test-app:
	@curl -s --max-time 1 http://project.gitpushforce.club:80| grep -P -o 'Welcome to your Strapi app'

## TERRAFORM ##
tf-init:
	cd terraform; terraform init
tf-plan:
	cd terraform; terraform plan
tf-apply:
	cd terraform; terraform apply
## ANSIBLE ##
add-requirements:
	cd ansible; ansible-galaxy install -r requirements.yml
	cd ansible; ansible-galaxy collection install -r requirements.yml

start-playbook:
	ansible-playbook -i ansible/inventory.ini ansible/playbook.yml --vault-password-file ~/.ansible_pass.txt

encrypt-string:
	ansible-vault encrypt_string --vault-password-file ~/.ansible_pass.txt $(secret_value) --name $(secret_name)

show-encrypted-string:
	ansible localhost -m debug -a var=$(secret_name) -e@$(path_to_file) --vault-password-file ~/.ansible_pass.txt