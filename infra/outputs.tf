output "invoke_url" {
  description = "API Gateway invoke URL"
  value       = module.compute_lambda.invoke_url
}