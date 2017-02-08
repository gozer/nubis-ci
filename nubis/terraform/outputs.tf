output "elb" {
    value = "http://${aws_route53_record.ci.fqdn}"
}

output "iam_role" {
  value = "${join(",",aws_iam_role.ci.*.id)}"
}
