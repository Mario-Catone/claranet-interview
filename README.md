# File nel repository

### contaScript.sh (Esercizio 1)
Contiene lo script bash che conta quanti script sono presenti in una directory. Lo script prende come directory in cui controllare il numero di file la directory da cui viene lanciato.

### cronJob.sh (Esercizio 2)
Contiene la riga cron da eseguire ogni domenica per effettuare un backup tramite rsync.
Ci si collega alla destinazione remota tramite SSH, quindi conviene impostare autenticazione key-based sull'host su cui andiamo a salvare il backup.
Se il backup non va a buon fine, eventuali errori vengono salvati in un file nella home dello user.

### AWS_Homework (Esercizio 3)
Contiene il PDF che motiva gli strumenti AWS utilizzati e l'architettura del sistema richiesto.
IaC tramite terraform esegue solo le seguenti operazioni:

* Provisioning VPC
  * 2 Availability Zones
  * 2 Subnet per AZ - 1 pubblica e 1 privata
  * 1 Internet Gateway che si connette alle subnet pubbliche
* Provisioning database RDS:
  * istanza db.t3.micro
  * MySQL 8.0
  * Su subnet private
* Provisioning EFS

Non vengono creati security group da associare ai vari servizi, il loadbalancer o l'autoscaling group.
