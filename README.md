[![GitHub issues](https://img.shields.io/github/issues/garutilorenzo/oracle-cloud-terraform-examples)](https://github.com/garutilorenzo/oracle-cloud-terraform-examples/issues)
![GitHub](https://img.shields.io/github/license/garutilorenzo/oracle-cloud-terraform-examples)
[![GitHub forks](https://img.shields.io/github/forks/garutilorenzo/oracle-cloud-terraform-examples)](https://github.com/garutilorenzo/oracle-cloud-terraform-examples/network)
[![GitHub stars](https://img.shields.io/github/stars/garutilorenzo/oracle-cloud-terraform-examples)](https://github.com/garutilorenzo/oracle-cloud-terraform-examples/stargazers)

# Oracle Cloud terraform examples

Deploy Oracle Cloud services using Oracle [always free](https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier_topic-Always_Free_Resources.htm) resources

**Note** choose a region with enough ARM capacity

### Important notes

* This is repo shows only how to use terraform with the Oracle Cloud infrastructure and use only the **always free** resources. This examples are **not** for a production environment.
* At the end of your trial period (30 days). All the paid resources deployed will be stopped/terminated
* At the end of your trial period (30 days), if you have a running compute instance it will be stopped/hibernated

### Table of Contents

* [Repository structure](#repository-structure)
* [Requirements](#requirements)
  * [Setup RSA Key](#example-rsa-key-generation)
* [Oracle provider setup](#oracle-provider-setup)
* [Project setup](#project-setup)
* [Firewall](#firewall)
* [OS](#os)
* [Shape](#shape)
* [Useful documentation](#useful-documentation)

### Repository structure

In this repositroy there are 7 terrafrom modules, in order of dependency:

* [simple-vcn](simple-vcn/) - Setup a VCN with two PUBLIC subnets
* [private-vcn](private-vcn/) - Setup a VCN with one PUBLIC subnet and one PRIVATE subnet
* [nat-instance](nat-instance/) - Setup a NAT instance (with the Oracle always free account you can't deploy a NAT gateway)
* [simple-instance](simple-instance/) - Deploy a simple instance in a private or public subnet
* [instance-pool](instance-pool/) - Deploy multiple instances using a Oracle instance pool and instance configurations
* [load-balancer](load-balancer/) - Deploy a public load balancer (Layer 7 HTTP)
* [network-load-balancer](network-load-balancer/) - Deploy a private load balancer (Layer 4 TCP)

For more information on how to use this modules follow the examples in the *examples* directory. To use this repository, clone this repository and use the *example* directory as base dir.

### Requirements

To use this repo you will need:

* an Oracle Cloud account. You can register [here](https://cloud.oracle.com)

Once you get the account, follow the *Before you begin* and *1. Prepare* step in [this](https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-provider/01-summary.htm) document.

You need also:

* [Terraform](https://www.terraform.io/) - Terraform is an open-source infrastructure as code software tool that provides a consistent CLI workflow to manage hundreds of cloud services. Terraform codifies cloud APIs into declarative configuration files.
* [kubectl](https://kubernetes.io/docs/tasks/tools/) - The Kubernetes command-line tool (optional)
* [oci cli](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cliconcepts.htm) - Oracle command line interface (optional)

#### Example RSA key generation

To use terraform with the Oracle Cloud infrastructure you need to generate an RSA key. Generate the rsa key with:

```
openssl genrsa -out ~/.oci/<your_name>-oracle-cloud.pem 4096
chmod 600 ~/.oci/<your_name>-oracle-cloud.pem
openssl rsa -pubout -in ~/.oci/<your_name>-oracle-cloud.pem -out ~/.oci/<your_name>-oracle-cloud_public.pem
```

replace *<your_name>* with your name or a string you prefer.

**NOTE** ~/.oci/<your_name>-oracle-cloud_public.pem this string will be used on the *terraform.tfvars* used by the Oracle provider plugin, so please take note of this string.

### Project setup

Once you have cloned this repo, change directory to [examples](examples/) dir and choose the example you prefer: *private subnet* or main.tf or *public subnet* main.tf-public file. Edit the example file and set the needed variables (*change-me* variables). Crate a *terraform.tfvars* file, for more detail see [Oracle provider setup](#oracle-provider-setup) and read all the modules requirements in each module directory.

Or if you prefer you can create a new empty directory in your workspace and start a new project from scratch. To setup the project follow the README.md in the [examples](examples/) directory.

### Oracle provider setup

This is an example of the *terraform.tfvars* file:

```
fingerprint      = "<rsa_key_fingerprint>"
private_key_path = "~/.oci/<your_name>-oracle-cloud_public.pem"
user_ocid        = "<user_ocid>"
tenancy_ocid     = "<tenency_ocid>"
compartment_ocid = "<compartment_ocid>"
```

To find your tenency_ocid in the Ocacle Cloud console go to: Governance and Administration > Tenency details, then copy the OCID.

To find you user_ocid in the Ocacle Cloud console go to User setting (click on the icon in the top right corner, then click on User settings), click your username and then copy the OCID

The compartment_ocid is the same as tenency_ocid.

The fingerprint is the fingerprint of your RSA key, you can find this vale under User setting > API Keys

#### How to find the availability doamin name

To find the list of the availability domains run this command on che Cloud Shell:

```
oci iam availability-domain list
{
  "data": [
    {
      "compartment-id": "<compartment_ocid>",
      "id": "ocid1.availabilitydomain.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
      "name": "iAdc:EU-ZURICH-1-AD-1"
    }
  ]
}
```

#### How to list all the OS images

To filter the OS images by shape and OS run this command on che Cloud Shell:

```
oci compute image list --compartment-id <compartment_ocid> --operating-system "Canonical Ubuntu" --shape "VM.Standard.A1.Flex"
{
  "data": [
    {
      "agent-features": null,
      "base-image-id": null,
      "billable-size-in-gbs": 2,
      "compartment-id": null,
      "create-image-allowed": true,
      "defined-tags": {},
      "display-name": "Canonical-Ubuntu-20.04-aarch64-2022.01.18-0",
      "freeform-tags": {},
      "id": "ocid1.image.oc1.eu-zurich-1.aaaaaaaag2uyozo7266bmg26j5ixvi42jhaujso2pddpsigtib6vfnqy5f6q",
      "launch-mode": "NATIVE",
      "launch-options": {
        "boot-volume-type": "PARAVIRTUALIZED",
        "firmware": "UEFI_64",
        "is-consistent-volume-naming-enabled": true,
        "is-pv-encryption-in-transit-enabled": true,
        "network-type": "PARAVIRTUALIZED",
        "remote-data-volume-type": "PARAVIRTUALIZED"
      },
      "lifecycle-state": "AVAILABLE",
      "listing-type": null,
      "operating-system": "Canonical Ubuntu",
      "operating-system-version": "20.04",
      "size-in-mbs": 47694,
      "time-created": "2022-01-27T22:53:34.270000+00:00"
    },
```

**Note:** this setup was only tested with Ubuntu 20.04

### Firewall

By default firewall on the compute instances is disabled (except for the nat instance).

### Software installed

In the simple-instance example and in the instance-pool example nginx will be installed by default.
Nginx is used for testing the security list rules an the correct setup of the Load Balancer.

On the k3s-cluster example, k3s will be automatically installed on all the machines. **NOTE** k3s-cluster setup has moved to [this](https://github.com/garutilorenzo/k3s-oci-cluster) repository.

### OS

The operating system used is Ubuntu 20.04

### Shape

All the provisioned instances are VM.Standard.A1.Flex (Arm processor) with 6GB of ram and 1 CPU.

With the Oracle always free you can run 4 VM.Standard.A1.Flex instances for free (24 GB of ram an 4 CPU).

**Note** choose a region with enough ARM capacity

### Useful documentation

Setup the [default vcn resources](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformbestpractices_topic-vcndefaults.htm) documentation.
