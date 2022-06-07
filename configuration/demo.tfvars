#Referenced common across modules
owner_custom = "raghav"
purpose_custom = "demo"

#Referenced in resource-group module
owner = "raghavendra.bharadwaj@servian.com"
purpose = "test"
location = "australiaeast"
org = "Servian"

#Referenced in network module
address_space = ["10.10.0.0/21"]

subnets = {
    subnet1 = {
        name = "public_subnet"
        address_space = ["10.10.1.0/26"]
        }

    subnet2 = {
        name = "private_subnet"
        address_space = ["10.10.1.64/26"]
        }

    subnet3 = {
        name = "privatelink_subnet"
        address_space = ["10.10.1.128/26"]
        }
    
    subnet4 = {
        name = "AzureFirewallSubnet"
        address_space = ["10.10.1.192/26"]
        }
}

nsg = {
    public_nsg = {
        name = "public_nsg"
        }

    private_nsg = {
        name = "private_nsg"
        }
    }