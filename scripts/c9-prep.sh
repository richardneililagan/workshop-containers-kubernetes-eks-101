#!/usr/bin/env bash

# :: ---

export WORKSHOP=aws-eks-workshop

export ROLE_NAME=$WORKSHOP-cloud9-role
export INSTANCE_PROFILE_NAME=$WORKSHOP-instanceprofile

export INSTANCE_OPEN_PORTRANGE=8000-9999

export INSTANCE_ID=$(ec2-metadata -i | cut -d' ' -f 2)
export INSTANCE_SG=$(ec2-metadata -s | cut -d' ' -f 2)
export INSTANCE_IP=$(ec2-metadata -v | cut -d' ' -f 2)

export WORKSPACE=$HOME/environment/workshop
mkdir -p $WORKSPACE
cd $WORKSPACE
clear

# :: ---

# :: Open TCP ports on the Cloud9 machine for development
aws ec2 authorize-security-group-ingress --group-name $INSTANCE_SG --protocol tcp --port $INSTANCE_OPEN_PORTRANGE --cidr 0.0.0.0/0

# :: Create an IAM role with Administrator privileges
aws iam create-role --role-name $ROLE_NAME --assume-role-policy-document '{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Action": "sts:AssumeRole",
    "Principal": {
      "Service": "ec2.amazonaws.com"
    }
  }]
}'

aws iam attach-role-policy --role-name $ROLE_NAME --policy-arn arn:aws:iam::aws:policy/AdministratorAccess


# :: Attach the IAM role above to this Cloud9 instance, so that anything you run here has admin powers

aws iam create-instance-profile --instance-profile-name $INSTANCE_PROFILE_NAME
aws iam add-role-to-instance-profile --instance-profile-name $INSTANCE_PROFILE_NAME --role-name $ROLE_NAME

sleep 10 # :: yucky, but helps us make sure everything's ready before the next command

aws ec2 associate-iam-instance-profile --instance-id $INSTANCE_ID --iam-instance-profile Name=$INSTANCE_PROFILE_NAME


# :: Delete all container images already in the workspace
docker rmi -f $(docker images -aq)


# :: CLI tools ---

# :: upgrade nodejs to v14.x
source $HOME/.nvm/nvm.sh
nvm install 14.15
nvm alias default 14.15
nvm use default
npm i -g yarn # :: install yarn, just in case


# :: install kubectl
curl --silent -LO https://amazon-eks.s3.us-west-2.amazonaws.com/1.18.9/2020-11-02/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin


# :: install eksctl
curl --silent \
  --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" \
  | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin


# :: perform final checks

clear
echo "Final checks:"
echo "--------------------------------------"
echo

echo "AWS CLI (aws) is at: $(which aws)"
echo "Docker (docker) is at: $(which docker)"
echo "kubectl is at: $(which kubectl)"
echo "eksctl is at: $(which eksctl)"

echo
echo "--------------------------------------"
echo "Finished."
echo
echo "Your Cloud9 instance is publicly accessible at $INSTANCE_IP on TCP ports $INSTANCE_OPEN_PORTRANGE."
