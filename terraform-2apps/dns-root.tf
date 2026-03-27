terraform {
    backend "s3" {
    bucket = "dev-s3-project-buried-marks-and-birdwatching-terraform-state"
    key    = "dev/dns-root/terraform.tfstate"
    region = "eu-north-1"
    encrypt      = true
    use_lockfile = true
    }
}
resource "aws_route53_zone" "root" {
    name = "birds.pp.ua"

    lifecycle {
    prevent_destroy = true
    }
}

#Uncomment after creating route zones in the stage and production accounts.
/*
# Delegation for Stage (NS of Stage account)
resource "aws_route53_record" "stage_ns" {
    zone_id = aws_route53_zone.root.zone_id
    name    = "stage.birds.pp.ua"
    type    = "NS"
    ttl     = 300
    records = [
            ]
}

# Delegation for Prod (NS of Prod account)
resource "aws_route53_record" "prod_ns" {
    zone_id = aws_route53_zone.root.zone_id
    name    = "prod.birds.pp.ua"
    type    = "NS"
    ttl     = 300
    records = [
        ]
}
*/