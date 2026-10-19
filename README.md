# FoxAI OS 44 KDE

Live ISO (KDE Plasma) built with kickstart + `livemedia-creator`.

## ISO (3.5GB)

Download from [Releases](https://github.com/Can-5/foxai-os/releases):

- `FoxAI-OS-44-KDE-x86_64.iso` — bootable live image, volid `FoxAI-OS-44-KDE`

## Boot & login

1. Boot the ISO (UEFI).
2. In GRUB, select entry **1** — "Start FoxAI-OS 44" (mediachecksiz).
3. Login: `liveuser` / şifresiz.
4. Desktop: KDE Plasma (mavi FoxAI duvar kağıdı).

## Build

Built with `iso/vm-build.sh --image-size 14336` using kickstart `iso/foxai-os-44-kde.ks`.

Key kickstart fixes:
- `sddm` removed from `services --enabled` (display-manager → plasmalogin alias conflict on F44)
- `grub2-pc-modules`, `policycoreutils` added to `%packages`
- per-package i686 excludes (no wildcard)
- `foxai-release` / `foxai-release-identity` temporarily commented (44-0.1 vs fedora 44-17 conflict)

## Known

- `os-release` shows Fedora 44 (identity paketi TEMP commented out).
- GRUB default entry hala mediacheck'li — entry 1'i manuel seçin.
