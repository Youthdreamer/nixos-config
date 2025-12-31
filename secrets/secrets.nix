let
  youth = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM5SG/6FWHxFnQSRFXfXKgg2kmhLrRJeuw7yCcAZxCgH agenix key";
in {
  "ai_api_key.age".publicKeys = [youth];
}
