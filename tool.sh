#!/bin/sh

h=0 # help
u=0 # update
t=0 # test
s=0 # switch
gc=0 # garbage collection

while [ $# -gt 0 ]; do
  case $1 in
    -h|--help)
      h=1
      shift
      ;;
    -u|--update)
      u=1
      shift
      ;;
    -t|--test)
      t=1
      shift
      ;;
    -s|--switch)
      s=1
      shift
      ;;
    -gc|--garbage)
      gc=1
      shift
      ;;
    -*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      echo "Unknown positional option $1"
      exit 1
      ;;
  esac
done

if [ $t -eq 1 ] && [ $s -eq 1 ];
then
  echo "Only one of --test or --update may be specified."
  exit 1
fi

if [ $h -eq 1 ]
then
  echo "tool.sh - Common operations for this nix flake,"
  echo "          because I have a hard time remembering."
  echo "-------------------------------------------------"
  echo " -u, --update - update the flake"
  echo " -t, --test   - test the flake"
  echo " -s, --switch - switch to the flake"
  echo " -h, --help   - print this help page"

  exit 0
fi

if [ $u -eq 1 ]
then
  echo "Updating..."
  nix flake update
fi

if [ $t -eq 1 ];
then
  sudo nixos-rebuild test --flake .
  exit 0
fi

if [ $s -eq 1 ];
then
  sudo nixos-rebuild switch --flake .
  exit 0
fi

if [ $gc -eq 1 ];
then
  sudo nix-collect-garbage --delete-older-than 7d
  sudo nixos-rebuild switch --flake .
fi

