echo "Preparing the cyber range."
cp -p terraform.tfvars_template terraform.tfvars
sed -i 's/<CR1_ENABLED>/true/g' terraform.tfvars
sed -i 's/<CR1_PERFORM_ATTACK>/false/g' terraform.tfvars
./terraform.sh init
./terraform.sh apply -auto-approve

sleep 60

echo "Preparing the attack environment."
cp -p terraform.tfvars_template terraform.tfvars
sed -i 's/<CR1_ENABLED>/true/g' terraform.tfvars
sed -i 's/<CR1_PERFORM_ATTACK>/true/g' terraform.tfvars
./terraform.sh init
./terraform.sh apply -auto-approve
