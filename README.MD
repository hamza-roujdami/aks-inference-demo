# AKS GPU + Lustre Demo with Chainlit & Langfuse

This repo shows how to:
1. Provision Azure infra (RG, VNet, AKS A100 MIG, NetApp Lustre) via Terraform
2. Deploy Kubernetes workloads: MIG pod, auto-scaling, sample webapp, Lustre CSI mount
3. Spin up a Chainlit UI to interact with a vLLM server
4. Trace all LLM calls into Langfuse

## Prerequisites
- Azure SP credentials in `.env`
- Langfuse API key in `.env`
- CLIs: `az`, `terraform`, `kubectl`, `docker`, `chainlit`

## Local Setup
1. Copy and fill in:  
   ```bash
   cp .env.example .env

2.	Provision infra:
cd terraform
terraform init
terraform apply -auto-approve

3.	Get Kubeconfig:
az aks get-credentials \
  --resource-group $TF_VAR_resource_group \
  --name $TF_VAR_aks_cluster_name
	
4.	Deploy k8s manifests:
kubectl apply -f k8s/

5.	Launch Chainlit UI:
cd ui
pip install -r requirements.txt
chainlit run app.py -c chainlit_config.yaml

6.	Visit http://localhost:7860 and use the chat UI.

