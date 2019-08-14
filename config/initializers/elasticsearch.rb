ENV["ELASTICSEARCH_URL"] = ENV["ELASTICSEARCH_URL"] || "https://search-profoundconfusion-jalr4dllpkuil6c2cnjy3ifmke.us-east-2.es.amazonaws.com"

Searchkick.aws_credentials = {
  access_key_id: ENV["AWS_ACCESS_KEY_ID"],
  secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
  region: "us-east-2"
}
