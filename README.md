# iac-aws

**Alpine OS (Latest)**

- Ansible 2.8.6
- Terraform 0.12.12
- AWS CLI

Default login user is `dev` with `sudo` privileges and no password.

Build the image

`docker build -t iac-aws:latest .`

Want to change default username? Add this end of `docker build` command.

`--build-arg USER='exampleuser'`

Run the container

`docker run -it --name dev-env iac-aws:latest`

A volume is created and mounted to your `HOME` directory for persistent dev environment. 
