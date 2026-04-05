#!/bin/bash

terraform destroy \
    -target=module.birdwatching.aws_instance.lb \
    -target=module.birdwatching.aws_instance.app \
    -target=module.birdwatching.aws_instance.db \
    -target=module.birdwatching.aws_instance.consul \
    -target=module.vpc.aws_nat_gateway.this \
    -target=module.vpc.aws_eip.nat \
    -target=module.eks
