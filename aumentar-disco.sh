#!/bin/bash

echo "Expansão do disco para 100GB iniciada..."

# Passo 1: Criar uma nova partição no espaço livre
echo -e "n\np\n\n\n\nw" | fdisk /dev/vda
partprobe

# Passo 2: Criar volume físico na nova partição
pvcreate /dev/vda4

# Passo 3: Adicionar o volume físico ao grupo de volume existente
vgextend ubuntu-vg /dev/vda4

# Passo 4: Estender o volume lógico para usar o espaço livre
lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv

# Passo 5: Redimensionar o sistema de arquivos para ocupar o espaço
resize2fs /dev/ubuntu-vg/ubuntu-lv

# Confirmação
echo "Expansão concluída. Verifique o novo espaço disponível:"
df -h
