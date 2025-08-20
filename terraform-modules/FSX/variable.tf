
# Defines the deployment type of the FSx for Lustre file system.
# Options are "SCRATCH_1", "SCRATCH_2", or "PERSISTENT_1".
# SCRATCH file systems are designed for temporary storage and high-speed processing.
# PERSISTENT file systems are for longer-term storage of data.
variable "deployment_type" {
  description = "The deployment type of the FSx for Lustre file system."
  type        = string
  default     = "SCRATCH_2"
}

# Defines the storage capacity of the file system in GiB.
# Capacity must be a multiple of 1200 GiB.
# For SCRATCH_2, valid values are 1200, 2400, 3600...
# For PERSISTENT_1, valid values are 1200, 2400...
variable "storage_capacity_gb" {
  description = "The storage capacity of the file system in GiB."
  type        = number
  default     = 1200
}

# Defines the throughput capacity of the file system.
# This value is specified in MB/s per GiB.
variable "throughput_capacity_per_gib" {
  description = "The throughput capacity in MB/s per GiB of storage."
  type        = number
  default     = 50
}
