# IasC_terraform_virtualbox
Infrastructure as Code with Terraform &amp; Monitoring on VirtualBox." It shows a structured plan for implementing infrastructure as code using Terraform on VirtualBox, along with monitoring capabilities.



# ## Terraform Commands : 
    -> terraform init (This command initializes Terraform and downloads the required providers )  -> terraform plan (This shows you what resources will be created) -> terraform apply (When prompted, type "yes" to confirm the creation of the resources)

    -> To remove the VirtualBox VMs you created with Terraform : 
            * Terraform destroy 
            * Manually Remove VMs from VirtualBox
    -> to display info : terraform output


###  using WSL (Windows Subsystem for Linux) :
        1 - VirtualBox installation: VirtualBox needs to be installed on your Windows host, not in WSL  
        2 - Path issues: You'll need to make sure the Windows VBoxManage.exe is accessible from your WSL environment 

#### Machine Login and Password : 
        login : vagrant 
        password : vagrant