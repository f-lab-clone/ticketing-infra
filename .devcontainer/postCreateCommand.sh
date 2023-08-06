
echo "postCreateCommand hook script is running"

git config --local commit.template commit-template.txt
cp .github/hooks/prepare-commit-msg .git/hooks/prepare-commit-msg
chmod +x .git/hooks/prepare-commit-msg

# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
rm awscliv2.zip
rm -rf aws
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm awscliv2.zip

# https://developer.hashicorp.com/terraform/downloads
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

# aws configure
# cat ~/.aws/credentials
# aws sts get-caller-identity