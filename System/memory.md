# Mémoire & Swap

## Swappiness (vm.swappiness)

CachyOS configure par défaut `vm.swappiness=150` pour favoriser l'usage agressif de **zram**
(swap compressé en RAM, plus rapide qu'un disque). Abaisser cette valeur retarde le recours
à zram et garde plus de données directement en RAM.

**Valeur recommandée : 10**

```bash
# Appliquer immédiatement (sans redémarrer)
sudo sysctl vm.swappiness=10

# Rendre permanent
echo 'vm.swappiness=10' | sudo tee /etc/sysctl.d/99-swappiness.conf
```

Vérifier la valeur active :

```bash
cat /proc/sys/vm/swappiness
```

> Sur un système avec zram uniquement (pas de swap disque), des valeurs entre 10 et 100
> sont raisonnables. En dessous de 10, le risque d'OOM (Out Of Memory) augmente.
