#!/bin/bash

# Script para mudar a referencia dos submódulos no gitlab de https para ssh
# Rode no raiz do seu projeto.

# Vou abortar o script se der erro daqui para a frente.
set -e

PreFlight() {
  if [[ ! -f .gitmodules ]] ; then
    echo -- Não estou no raiz do projeto. Saindo.
    exit 1
  fi

  if git diff --quiet --cached ; then
    return
  fi

  echo -- Existem mudanças na área de stage, faça um commit antes.
  exit 1
}

AcertaOrigem() {
  origin=$(git remote -v | grep '^origin.*fetch)$')
  if [[ ${origin/https} == ${origin} ]] ; then
    echo -- Nenhuma alteração no origin necessária...
  fi
  url=${origin/#origin}
  url=${url/%(fetch)}
  url=${url/https:\/\/gitlab.globoi.com\//gitlab@gitlab.globoi.com:}
  git remote set-url origin ${url}
  echo -- Remote origin atualizado com sucesso.
}

AcertaSubmodules() {
  local count=$(grep -s 'https://gitlab.globoi.com/' .gitmodules | wc -l)
  if [[ $count -eq 0 ]] ; then
    echo -- Não existem referências http ao gitlab na lista de submódulos. Saindo.
    return
  fi

  echo -- Existem ${count} referências na lista de submódulos.  Vamos acertar...

  sed -e 's;^\(\surl = \)https://gitlab.globoi.com/;\1gitlab@gitlab.globoi.com:;' -i.bak .gitmodules
  rm -f .gitmodules.bak
  git submodule sync

  git add .gitmodules
  git commit -m 'Atualizando submodules para vir do gitlab via ssh autenticado'

  echo -- Submódulos atualizado com sucesso.
  echo -- Não esqueça de rodar 'git push' com essa mudança.
}

PreFlight
AcertaSubmodules
AcertaOrigem

# EOF
