# Terraform

## Terraform installieren (Linux-Debian/Ubuntu)
Diese Anleitung zeigt die Installation auf einem Debian Linux. Installation funktioniert auch auf einem GitHub Codespace. Um Terraform auf Windows zu installieren folge bitte der Anleitung von HasiCorp. [HasiCorp Terraform Download](https://developer.hashicorp.com/terraform/downloads?product_intent=terraform)
1. Zuerst den GPG Key herunterladen und hinzufügen
   ```shell
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
   ```

2. Dann das Repository von HasiCorp dem System hinzufügen
   ```shell
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
   ```

3. Nun die Paketlisten aktualisieren
   ```shell
    sudo apt update
   ```

4. Zum schluss kann nun Terraform installiert werden
   ```shell
    sudo apt-get install terraform
   ```