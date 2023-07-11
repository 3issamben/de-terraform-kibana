
resource "local_file" "space_config" {
  content  = jsonencode(var.items)
  filename = "${path.module}/new_space.json"
}

# Create Space
resource "null_resource" "create_space" {

  depends_on = [local_file.space_config]

  triggers = {
    space_id = var.items.id
    es_key   = var.es_key
  }

  provisioner "local-exec" {
    command = "curl -X POST -u '${var.es_key}' 'localhost:5601/api/spaces/space' -H 'kbn-xsrf: true'  -H 'Content-Type: application/json' -d @new_space.json"
  }

}

# Update the space
resource "null_resource" "update_space" {

  triggers = {
    file_changed = md5(local_file.space_config.content)
  }

  depends_on = [local_file.space_config]

  provisioner "local-exec" {

    command = "curl -X PUT -u '${var.es_key}' 'localhost:5601/api/spaces/space/${var.items.id}' -H 'kbn-xsrf: true'  -H 'Content-Type: application/json' -d @new_space.json"
  }
}

# Destroy the resource
resource "null_resource" "destroy_space" {

  depends_on = [local_file.space_config]

  triggers = {
    space_id = var.items.id
    es_key   = var.es_key
  }

  provisioner "local-exec" {
    when    = destroy
    command = "curl -X DELETE -u '${self.triggers.es_key}' 'localhost:5601/api/spaces/space/${self.triggers.space_id}' -H 'kbn-xsrf: true'"
  }


}


