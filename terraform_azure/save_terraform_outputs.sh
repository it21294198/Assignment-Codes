#!/bin/bash
# save_terraform_outputs.sh
# Use this script after applying Terraform to extract outputs for GitHub secrets

# Run terraform output and save outputs to variables
RESOURCE_GROUP=$(terraform output -raw resource_group_name)
WEBAPP_NAME=$(terraform output -raw webapp_name)
ACR_NAME=$(terraform output -raw acr_name)
ACR_LOGIN_SERVER=$(terraform output -raw acr_login_server)
ACR_USERNAME=$(terraform output -raw acr_username)
ACR_PASSWORD=$(terraform output -raw acr_password)

echo "Azure Resource Information from Terraform:"
echo "----------------------------------------"
echo "AZURE_RESOURCE_GROUP: $RESOURCE_GROUP"
echo "AZURE_WEBAPP_NAME: $WEBAPP_NAME"
echo "ACR_NAME: $ACR_NAME"
echo "ACR_LOGIN_SERVER: $ACR_LOGIN_SERVER"
echo "ACR_USERNAME: $ACR_USERNAME"
echo "ACR_PASSWORD: $ACR_PASSWORD"
echo "----------------------------------------"
echo "Add these as secrets to your GitHub repository"