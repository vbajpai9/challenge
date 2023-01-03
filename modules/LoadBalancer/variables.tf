variable "ilb_name" {
    type = string
    default = ""
    description = "name of the load balancer"
}
variable "location" {
    type = string
    default = ""
    description = "name of the load balancer"
}

variable "resource_name" {
    type = string
    default = ""
    description = "name of the resource group"
  
}

variable "ilb_frontend_name" {
    type = string
    default = ""
    description = "name of the frontend ip configuration"
  
}

variable "ilb_subnet_id" {
    #type = string
    default = ""
    description = "subnet id of frontend ip address"

}

variable "ilb_ip_allocation" {
    type = string
    default = ""
    description = "allocation menthod of private ip address"
  
}

variable "ilb_ip_version" {
    type = string
    default = ""
    description = "ip version "
  
}
variable "loadbalancer_id" {
    type = string
    description = "load balancer id"
    default = ""
  
}
variable "ilb_backend_name" {
    type = string
    default = ""
    description = "backend name"
  
}
/*variable "ilb_backend_pool_name" {
    type = list(string)
    default = [""]
    description = "vm instances" 
  
} */
variable "ilb_backend_pool_name" {

    default =""
    description = "vm instances"
  
}

variable "vnet_id" {
    type = string
    default = ""
    description = "vnet id"
  
}
variable "probe" {
    type = string
    default = ""
    
  
}

variable "ip_address" {
    type = list(string)
   // default = ["10.0.0.5" ,"10.0.0.6"]
  
} 

variable "health_probe_name" {
    type = list(string)
    default = []
  
}

variable "health_probes" {
    type = map(string)
    default = {}
    description = "health probes"
  
}

variable "protocol" {
    type = string
    default = ""
    description = "specifies the protocol"
  
}

variable "lb_rule_name" {
    type = string
    default = ""
    description = "load balancer rule name"
  
}
variable "frontend_port" {
    type = number
    description = "frontend port of load balancer"
  
}

variable "backend_port" {
    type = number
    
    description = "backend port of load balancer"
  
}

variable "sku" {
    type = string
    default = ""
    description = "Sku of the loadbalancer"
}

variable "default_tags" {
  type = map(string)
  default = {}
  description = "default tags of the resource"
}
variable "mrp" {
    type = string
    default = ""
    description = "user who provisions the resource"
}

variable "env" {
    type = string
    default = ""
    description = "environment of the resource"
  
}
variable "number_of_probes" {
    type = number
    description =  "The number of failed probe attempts after which the backend endpoint is removed from rotation"
  
}
variable "interval_in_seconds" {
    type = number
    description = "The interval, in seconds between probes to the backend endpoint for health status"
  
}

variable "enable_floating_ip" {
    type = bool
    description = "floating ip of loadbalancer"
  
}

variable "idle_timeout_in_minutes" {
    type = number
    description = "Specifies the idle timeout in minutes for TCP connections"

  
}
variable "enable_tcp_reset" {
    type = bool
    description = "Resets the TCP default is false"
  
}

variable "load_distribution" {
    type = string
    description = "distributing thr traffic in backend pool"
    default = ""

  
}
variable "disable_outbound_snat" {
    type = bool
    description = "disables the oubbound by default"
  
}























