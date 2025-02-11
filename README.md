# Excalidraw on GCP with Container-Optimized OS

This repository contains Terraform code to deploy an Excalidraw container on Google Cloud Platform (GCP) using a Container-Optimized OS VM instance. The setup leverages the `e2-micro` instance type, which is eligible for GCP's free tier as of 2025.

## Features
- Deploys an Excalidraw container on a Container-Optimized OS VM instance.
- Uses an `e2-micro` instance, which falls under GCP's free tier.
- Configures a startup script to run the Excalidraw Docker container on port 80.
- Opens port 80 in the firewall to allow HTTP traffic.
- Supports a free domain name from [afraid.org](https://freedns.afraid.org/) and maps it to the VM's public IP.

## Prerequisites
- A Google Cloud Platform (GCP) account
- Terraform installed ([installation guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli))
- `gcloud` CLI configured with the appropriate permissions ([setup guide](https://cloud.google.com/sdk/docs/install))
- A free domain registered at [afraid.org](https://freedns.afraid.org/) and pointing to the VM's public IP

## Deployment Instructions

1. **Clone the Repository:**
   ```sh
   git clone https://github.com/jimmylin/excalidraw-gcp-cos.git
   cd excalidraw-gcp-cos
   ```

2. **Initialize Terraform:**
   ```sh
   terraform init
   ```

3. **Review and Modify Variables (Optional):**
   Check the `variables.tf` file to customize instance settings if needed.

4. **Apply the Terraform Configuration:**
   ```sh
   terraform apply
   ```
   Confirm the changes when prompted.

5. **Retrieve the Public IP:**
   After deployment, Terraform will output the public IP of the VM. If using afraid.org for DNS, ensure the domain is pointed to this IP.

## Accessing Excalidraw
Once the deployment is complete, you can access Excalidraw via:
```
http://<your-public-ip>
```
Or, if you've configured a custom domain:
```
http://yourdomain.undo.it (afraid.org subdomain)
```

## Cleanup
To remove all deployed resources, run:
```sh
terraform destroy
```

## Notes
- The `metadata_startup_script` is configured to ensure the Excalidraw container runs on port 80.
- Firewall rules allow HTTP access to the instance.
- This setup does **not** include HTTPS. Consider using a reverse proxy like Nginx with Let's Encrypt for SSL support.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

### Future Enhancements
- Add support for HTTPS using Let's Encrypt
- Automate domain registration and DNS updates
- Implement Terraform remote state storage for better state management

