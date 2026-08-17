
====================================================================
START AUF TTY1 – EXTERNE HDD, TMUX UND POSTINSTALL-ANLEITUNG
====================================================================

ZIEL:

  Linkes Terminal:
    Diese Postinstall-Anleitung anzeigen.

  Rechtes Terminal:
    Befehle eingeben und ausführen.

INSTALLATIONS-SSD:

  /dev/sdc

EXTERNE HDD:

  /dev/sdd
  Partition: /dev/sdd1
  Dateisystem: NTFS
  Label: Ex-Hdd

TEXTDATEI:

  /run/media/georg/Ex-Hdd/Linux_Stuff/Postinstall VoidBtrfs

WICHTIG:

  /dev/sdc ist die Installations-SSD und wird später gelöscht.

  /dev/sdd1 ist die externe HDD mit der Anleitung.

  Niemals fdisk, mkfs oder wipefs auf /dev/sdd oder /dev/sdd1
  ausführen.

====================================================================
1. AUF TTY1 ALS ROOT ANMELDEN
====================================================================

  login: root
  password: voidlinux

====================================================================
2. ALLE DATENTRÄGER PRÜFEN
====================================================================

  lsblk -o NAME,SIZE,MODEL,TYPE,FSTYPE,LABEL,UUID,MOUNTPOINTS

Erwartete Geräte:

  /dev/sdc        Installations-SSD
  /dev/sdd        M3 Portable, externe HDD
  /dev/sdd1       NTFS, Label Ex-Hdd

Die externe HDD darf ungefähr so aussehen:

  sdd         465,8G  M3 Portable  disk
  └─sdd1      465,8G              part  ntfs  Ex-Hdd
                                      /run/media/georg/Ex-Hdd

Wenn /dev/sdc oder /dev/sdd nicht eindeutig erkennbar sind:

  NICHT WEITERMACHEN.

  Erst die Geräte mit lsblk und eventuell mit fdisk -l prüfen.

====================================================================
3. PRÜFEN, OB DIE TEXTDATEI VORHANDEN IST
====================================================================

  ls -lah "/run/media/georg/Ex-Hdd/Linux_Stuff"

Exakten Dateinamen testen:

  test -f "/run/media/georg/Ex-Hdd/Linux_Stuff/Postinstall VoidBtrfs" \
    && echo "Datei gefunden" \
    || echo "Datei nicht gefunden"

Falls die Datei nicht gefunden wurde, nach Textdateien suchen:

  find "/run/media/georg/Ex-Hdd/Linux_Stuff" \
    -maxdepth 1 \
    -type f \
    -iname "*.txt" \
    -printf "%f\n"

====================================================================
4. TMUX INSTALLIEREN
====================================================================

  xbps-install -S
  xbps-install -y tmux

====================================================================
5. TMUX-SESSION STARTEN
====================================================================

  tmux new-session -s void-install

====================================================================
6. TMUX LINKS UND RECHTS TEILEN
====================================================================

Jetzt das aktuelle Terminal links und rechts teilen:

  Ctrl+b
  danach %

Das bedeutet:

  1. Ctrl und b gleichzeitig drücken.
  2. Beide Tasten loslassen.
  3. Danach die Taste % drücken.

Alternativ kann die Teilung auch per Befehl erfolgen:

  tmux split-window -h

Die Option -h erzeugt zwei Bereiche nebeneinander:

  +---------------------------+---------------------------+
  | linkes Terminal           | rechtes Terminal          |
  | Anleitung                 | Befehle                   |
  +---------------------------+---------------------------+

====================================================================
7. TMUX-MAUS AKTIVIEREN
====================================================================

Maus für Pane-Auswahl, Scrollen und Größenänderung aktivieren:

  tmux set-option -g mouse on

Oder innerhalb der tmux-Sitzung:

  Ctrl+b
  danach :

Dann eingeben:

  set -g mouse on

Danach Enter drücken.

Mit aktivierter Maus kannst du:

  - links in ein Pane klicken,
  - die Pane-Grenze verschieben,
  - mit dem Mausrad scrollen,
  - Text markieren.

Die tmux-Option "mouse on" aktiviert diese Mausfunktionen. [59]

====================================================================
8. EXTERNE HDD EINHÄNGEN, FALLS SIE NICHT GEMOUNTET IST
====================================================================

Zuerst prüfen:

  findmnt /dev/sdd1

Wenn die Ausgabe zeigt, dass /dev/sdd1 bereits unter
/run/media/georg/Ex-Hdd gemountet ist, NICHT erneut mounten.

Prüfen:

  ls -lah "/run/media/georg/Ex-Hdd"

Falls /dev/sdd1 noch nicht gemountet ist, zuerst den Mountpoint anlegen:

  mkdir -p /mnt/exthdd

NTFS-Treiber installieren, falls erforderlich:

  xbps-install -S
  xbps-install -y ntfs-3g

Externe HDD mounten:

  mount -t ntfs-3g /dev/sdd1 /mnt/exthdd

Danach lautet der Pfad zur Anleitung:

  /mnt/exthdd/Linux_Stuff/Postinstall VoidBtrfs
  
====================================================================
FALLBACK MIT UDISKSCTL
====================================================================

Wenn der manuelle mount-Befehl fehlschlägt, zuerst prüfen:

  xbps-query -p pkgver udisks2

Falls udisks2 nicht installiert ist:

  xbps-install -S
  xbps-install -y udisks2

D-Bus aktivieren, falls erforderlich:

  ln -s /etc/sv/dbus /var/service/ 2>/dev/null || true
  sv up dbus

Danach die Partition mit udisksctl mounten:

  udisksctl mount --block-device /dev/sdd1

Oder kurz:

  udisksctl mount -b /dev/sdd1

Nach erfolgreichem Mount zeigt udisksctl den Mountpoint an,
normalerweise unter /run/media/georg/.

Beispiel:

  Mounted /dev/sdd1 at /run/media/georg/Ex-Hdd

In diesem Fall die Anleitung öffnen:

  less "/run/media/georg/Ex-Hdd/Linux_Stuff/Postinstall VoidBtrfs"

====================================================================
WENN UDISKSCTL DEN DATEISYSTEMTYP NICHT ERKENNT
====================================================================

Für NTFS mit dem Kernel-Treiber ntfs3 versuchen:

  udisksctl mount -b /dev/sdd1 -t ntfs3

Falls ntfs3 nicht funktioniert, NTFS-3G versuchen:

  udisksctl mount -b /dev/sdd1 -t ntfs

Danach den Mountpoint prüfen:

  findmnt /dev/sdd1

====================================================================
DATEI ÖFFNEN
====================================================================

Wenn der Mountpoint /run/media/georg/Ex-Hdd lautet:

  less "/run/media/georg/Ex-Hdd/Linux_Stuff/Postinstall VoidBtrfs"

Wenn der Mountpoint anders lautet, den von udisksctl ausgegebenen
Pfad verwenden.

====================================================================
9. ANLEITUNG IM LINKEN PANE ÖFFNEN
====================================================================

Wenn die HDD bereits automatisch gemountet wurde:

  less "/run/media/georg/Ex-Hdd/Linux_Stuff/Postinstall VoidBtrfs"

Wenn die HDD manuell unter /mnt/exthdd gemountet wurde:

  less "/mnt/exthdd/Linux_Stuff/Postinstall VoidBtrfs"

less-Tasten:

  Leertaste       nächste Seite
  b               vorherige Seite
  Pfeil hoch      nach oben
  Pfeil runter    nach unten
  /Suchtext       nach Text suchen
  n               nächster Treffer
  q               less verlassen

====================================================================
10. ZUM RECHTEN PANE WECHSELN
====================================================================

Mit der Maus:

  In das rechte Pane klicken.

Mit Tastatur:

  Ctrl+b
  Pfeil rechts

Oder:

  Ctrl+b
  o

====================================================================
11. BEFEHLE AUS DEM LINKEN PANE KOPIEREN
====================================================================

Wenn du Text mit der Maus kopierst:

  1. Im linken Pane Text mit der Maus markieren.
  2. Den markierten Text kopieren.
  3. In das rechte Pane klicken.
  4. Mit der mittleren Maustaste einfügen.

Je nach Terminal funktioniert Einfügen auch mit:

  Shift+Ctrl+V

Wenn tmux die Mausauswahl übernimmt, halte beim Markieren zusätzlich
die Shift-Taste gedrückt. Das ermöglicht häufig die normale Terminal-
Auswahl und das Kopieren.

WICHTIG:

  Kopiere mehrzeilige Shell-Befehle vorsichtig.

  Bei Befehlen mit Backslash muss der Backslash jeweils am Zeilenende
  stehen und darf nicht durch zusätzliche Zeichen verändert werden.

====================================================================
12. VOR FDISK NOCHMALS DIE GERÄTE PRÜFEN
====================================================================

Im rechten Pane ausführen:

  lsblk -o NAME,SIZE,MODEL,TYPE,FSTYPE,LABEL,UUID,MOUNTPOINTS

Du musst eindeutig sehen:

  /dev/sdc        Installations-SSD
  /dev/sdd        M3 Portable, externe HDD
  /dev/sdd1       NTFS, Ex-Hdd
                  /run/media/georg/Ex-Hdd

Optional zusätzlich:

  blkid /dev/sdc
  blkid /dev/sdd1

====================================================================
13. ERST JETZT FDISK STARTEN
====================================================================

Nur wenn /dev/sdc eindeutig die richtige Installations-SSD ist:

  fdisk /dev/sdc

AB HIER WIRD DIE INSTALLATIONS-SSD BEARBEITET.

NICHT AUSFÜHREN:

  fdisk /dev/sdd
  fdisk /dev/sdd1
  mkfs /dev/sdd
  mkfs /dev/sdd1
  wipefs -a /dev/sdd
  wipefs -a /dev/sdd1

====================================================================
14. TMUX-WICHTIGE BEFEHLE
====================================================================

  Ctrl+b %       links/rechts teilen
  Ctrl+b "       oben/unten teilen
  Ctrl+b o       zum nächsten Pane wechseln
  Ctrl+b Pfeil   Pane auswählen
  Ctrl+b d       Sitzung verlassen, ohne sie zu beenden
  tmux ls        tmux-Sitzungen anzeigen
  tmux attach -t void-install
                  Sitzung wieder öffnen

====================================================================
15. NACH DER INSTALLATION HDD AUSHÄNGEN
====================================================================

Wenn die Anleitung nicht mehr benötigt wird:

  cd /

Falls automatisch unter /run/media gemountet:

  umount /dev/sdd1

Falls manuell unter /mnt/exthdd gemountet:

  umount /mnt/exthdd

Die externe HDD erst nach dem erfolgreichen Aushängen abziehen.

====================================================================
ENDE DES STARTABSCHNITTS
====================================================================



====================================================================
VOID LINUX MIT BTRFS INSTALLIEREN
====================================================================

ZIELSYSTEM
====================================================================

SSD:
  /dev/sdc

Partitionen:
  /dev/sdc1   EFI-Systempartition, 1 GiB, FAT32
  /dev/sdc2   Swap-Partition, 8 GiB
  /dev/sdc3   Btrfs-Root, restlicher Speicher

Btrfs-Subvolumes:
  @
  @home
  @log
  @cache
  @tmp

Boot:
  UEFI
  GRUB

System:
  x86_64-glibc

Benutzer:
  georg

Sprache:
  de_DE.UTF-8

Konsolen-Tastatur:
  us

Shell:
  zsh

WICHTIG:
  Diese Anleitung löscht die gesamte SSD /dev/sdc.
  Prüfe mit lsblk unbedingt, dass /dev/sdc wirklich die richtige SSD ist.

  Secure Boot sollte im UEFI deaktiviert sein.
  Boote das Void-Live-System im UEFI-Modus, nicht im Legacy-Modus.

====================================================================
1. IM VOID-LIVE-SYSTEM ANMELDEN
====================================================================

Als root anmelden:

  Benutzer: root
  Passwort: voidlinux

Alle Laufwerke prüfen:

  lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS
  fdisk -l

Sehr wichtig:
  Stelle sicher, dass die Ziel-SSD wirklich /dev/sdc ist.

Zusätzliche Prüfung:

  lsblk /dev/sdc

Wenn auf /dev/sdc wichtige Daten vorhanden sind, jetzt abbrechen.

====================================================================
2. INSTALLATIONSVARIABLEN SETZEN
====================================================================

Diese Werte gelten für deine SSD:

  export DISK=/dev/sdc
  export EFI=/dev/sdc1
  export SWAP=/dev/sdc2
  export ROOT=/dev/sdc3

Void-Architektur:

  export ARCH=x86_64

Repository für x86_64-glibc:

  export REPO=https://repo-default.voidlinux.org/current

Variablen kontrollieren:

  echo "$DISK"
  echo "$EFI"
  echo "$SWAP"
  echo "$ROOT"
  echo "$ARCH"
  echo "$REPO"

Die Ausgabe muss sein:

  /dev/sdc
  /dev/sdc1
  /dev/sdc2
  /dev/sdc3
  x86_64
  https://repo-default.voidlinux.org/current

====================================================================
3. EVENTUELL ALTE MOUNTS UND SWAP DEAKTIVIEREN
====================================================================

  umount -R /mnt 2>/dev/null || true
  swapoff -a 2>/dev/null || true

====================================================================
4. SSD MIT FDISK PARTITIONIEREN
====================================================================

ACHTUNG:
  Der folgende Vorgang löscht die Partitionstabelle von /dev/sdc.

  fdisk /dev/sdc

In fdisk diese Befehle eingeben:

  g

  Neue GPT-Partitionstabelle erstellen.

  n
  1
  Enter
  +1G

  EFI-Partition erstellen.

  t
  1
  1

  Partition 1 als EFI System setzen.

  n
  2
  Enter
  +8G

  Swap-Partition erstellen.

  t
  2
  19

  Partition 2 als Linux swap setzen.

  n
  3
  Enter
  Enter

  Partition 3 mit dem restlichen Speicher erstellen.

  t
  3
  20

  Partition 3 als Linux filesystem setzen.

  p

  Partitionstabelle kontrollieren.

  w

  Änderungen schreiben und fdisk verlassen.

Falls der Kernel die neue Partitionstabelle noch nicht erkennt:

  partprobe /dev/sdc

Danach kontrollieren:

  lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS /dev/sdc

Erwartet:

  sdc
  ├─sdc1   ungefähr 1G
  ├─sdc2   ungefähr 8G
  └─sdc3   restlicher Speicher

====================================================================
5. DATEISYSTEME FORMATIEREN
====================================================================

EFI-Partition als FAT32 formatieren:

  mkfs.vfat -F 32 -n EFI /dev/sdc1

Swap formatieren:

  mkswap -L swap /dev/sdc2

Btrfs-Root formatieren:

  mkfs.btrfs -f -L voidroot /dev/sdc3

Swap aktivieren:

  swapon /dev/sdc2

====================================================================
6. BTRFS-SUBVOLUMES ERSTELLEN
====================================================================

Btrfs-Dateisystem vorübergehend mounten:

  mkdir -p /mnt
  mount /dev/sdc3 /mnt

Subvolume für Root:

  btrfs subvolume create /mnt/@

Subvolume für /home:

  btrfs subvolume create /mnt/@home

Subvolume für /var/log:

  btrfs subvolume create /mnt/@log

Subvolume für /var/cache:

  btrfs subvolume create /mnt/@cache

Subvolume für /tmp:

  btrfs subvolume create /mnt/@tmp

Subvolumes kontrollieren:

  btrfs subvolume list /mnt

Btrfs-Top-Level-Dateisystem aushängen:

  umount /mnt

====================================================================
7. BTRFS-SUBVOLUMES MOUNTEN
====================================================================

Mount-Optionen setzen:

  export BTRFS_OPTS=rw,noatime,compress=zstd:3,discard=async,ssd,space_cache=v2

Root-Subvolume mounten:

  mount -o "$BTRFS_OPTS,subvol=@" /dev/sdc3 /mnt

Verzeichnisse anlegen:

  mkdir -p /mnt/home
  mkdir -p /mnt/var/log
  mkdir -p /mnt/var/cache
  mkdir -p /mnt/tmp
  mkdir -p /mnt/boot/efi

Weitere Subvolumes mounten:

  mount -o "$BTRFS_OPTS,subvol=@home" /dev/sdc3 /mnt/home

  mount -o "$BTRFS_OPTS,subvol=@log" /dev/sdc3 /mnt/var/log

  mount -o "$BTRFS_OPTS,subvol=@cache" /dev/sdc3 /mnt/var/cache

  mount -o "$BTRFS_OPTS,subvol=@tmp" /dev/sdc3 /mnt/tmp

EFI-Partition mounten:

  mount /dev/sdc1 /mnt/boot/efi

/tmp-Rechte setzen:

  chmod 1777 /mnt/tmp

Mounts prüfen:

  findmnt -R /mnt

====================================================================
8. XBPS-SCHLÜSSEL UND DNS KOPIEREN
====================================================================

XBPS-Schlüsselordner erstellen:

  mkdir -p /mnt/var/db/xbps/keys

Schlüssel vom Live-System kopieren:

  cp -a /var/db/xbps/keys/* /mnt/var/db/xbps/keys/

DNS-Konfiguration kopieren:

  cp -L /etc/resolv.conf /mnt/etc/resolv.conf

Prüfen:

  ls -la /mnt/var/db/xbps/keys
  cat /mnt/etc/resolv.conf

====================================================================
9. VOID-BASE-SYSTEM INSTALLIEREN
====================================================================

DIES IST DER WICHTIGSTE BOOTSTRAP-BEFEHL

Für x86_64-glibc:

  XBPS_ARCH=x86_64 xbps-install -S -r /mnt -R https://repo-default.voidlinux.org/current base-system btrfs-progs xtools linux linux-firmware git curl nano zsh

Der Befehl muss genau in dieser Form enden:

  base-system btrfs-progs xtools linux linux-firmware git curl nano zsh

Falls du lieber die lesbare mehrzeilige Version verwendest:

  XBPS_ARCH=x86_64 xbps-install -S \
    -r /mnt \
    -R https://repo-default.voidlinux.org/current \
    base-system \
    btrfs-progs \
    xtools \
    linux \
    linux-firmware \
    git \
    curl \
    nano \
    zsh

WICHTIG:
  Jeder Backslash muss das letzte Zeichen seiner Zeile sein.
  Nach dem Backslash dürfen keine Leerzeichen stehen.

Wenn der Befehl erfolgreich war, sind unter anderem base-system,
Btrfs-Werkzeuge, Kernel, Firmware, git, curl, nano und zsh installiert.

====================================================================
10. FSTAB MIT XGENFSTAB ERSTELLEN
====================================================================

Fstab automatisch aus den aktuell gemounteten Dateisystemen erzeugen:

  xgenfstab -U /mnt > /mnt/etc/fstab

Fstab anzeigen:

  cat /mnt/etc/fstab

Die Datei muss Einträge für folgende Mountpoints enthalten:

  /
  /home
  /var/log
  /var/cache
  /tmp
  /boot/efi
  swap

Zusätzliche Kontrolle der UUIDs:

  blkid /dev/sdc1
  blkid /dev/sdc2
  blkid /dev/sdc3

Fstab bearbeiten, falls nötig:

  nano /mnt/etc/fstab

Die Btrfs-Einträge sollten ungefähr so aussehen:

  UUID=ROOT-UUID  /          btrfs  rw,noatime,compress=zstd,ssd,space_cache=v2,subvol=@       0 0
  UUID=ROOT-UUID  /home      btrfs  rw,noatime,compress=zstd,ssd,space_cache=v2,subvol=@home   0 0
  UUID=ROOT-UUID  /var/log   btrfs  rw,noatime,compress=zstd,ssd,space_cache=v2,subvol=@log    0 0
  UUID=ROOT-UUID  /var/cache btrfs  rw,noatime,compress=zstd,ssd,space_cache=v2,subvol=@cache  0 0
  UUID=ROOT-UUID  /tmp       btrfs  rw,noatime,compress=zstd,ssd,space_cache=v2,subvol=@tmp    0 0
  UUID=EFI-UUID   /boot/efi  vfat   defaults,noatime                                       0 2
  UUID=SWAP-UUID  none       swap   defaults                                              0 0

ROOT-UUID, EFI-UUID und SWAP-UUID müssen durch die echten UUIDs
aus blkid ersetzt werden.

====================================================================
11. CHROOT VORBEREITEN
====================================================================

DNS im Zielsystem erneut sicherstellen:

  cp -L /etc/resolv.conf /mnt/etc/resolv.conf

/dev mounten:

  mount --rbind /dev /mnt/dev
  mount --make-rslave /mnt/dev

/proc mounten:

  mount --rbind /proc /mnt/proc
  mount --make-rslave /mnt/proc

/sys mounten:

  mount --rbind /sys /mnt/sys
  mount --make-rslave /mnt/sys

/run mounten:

  mount --rbind /run /mnt/run
  mount --make-rslave /mnt/run

EFI-Variablen prüfen:

  mount | grep efivarfs

Falls efivarfs nicht gemountet ist:

  mount -t efivarfs efivarfs /mnt/sys/firmware/efi/efivars 2>/dev/null || true

====================================================================
12. IN DAS NEUE SYSTEM WECHSELN
====================================================================

Für den ersten Chroot Bash verwenden:

  xchroot /mnt /bin/bash

Ab hier befindest du dich im installierten Void-System.

====================================================================
13. SYSTEM AKTUALISIEREN UND REPOSITORIES AKTIVIEREN
====================================================================

Repository-Index aktualisieren:

  xbps-install -S

System aktualisieren:

  xbps-install -yu

Nonfree-Repository installieren:

  xbps-install -y void-repo-nonfree

Multilib-Repository installieren:

  xbps-install -y void-repo-multilib

Multilib-nonfree-Repository installieren:

  xbps-install -y void-repo-multilib-nonfree

Repository-Index erneut aktualisieren:

  xbps-install -S

System erneut aktualisieren:

  xbps-install -yu

HINWEIS:
  Multilib brauchst du hauptsächlich für 32-Bit-Programme auf einem
  x86_64-System. Für ein reines 64-Bit-System ist es nicht zwingend nötig.

====================================================================
14. ZUSÄTZLICHE SYSTEMPAKETE INSTALLIEREN
====================================================================

  xbps-install -y \
    base-system \
    linux \
    linux-firmware \
    btrfs-progs \
    xtools \
    git \
    curl \
    wget \
    nano \
    zsh \
    sudo \
    bash-completion \
    man-pages \
    man-pages-posix \
    pciutils \
    usbutils \
    smartmontools \
    dosfstools \
    e2fsprogs \
    fuse \
    fuse3 \
    ntfs-3g \
    exfatprogs \
    ifuse \
    zip \
    unzip \
    p7zip \
    tar \
    gzip \
    file-roller

HINWEIS:
  exfatprogs ist der aktuelle Paketname für ExFAT-Werkzeuge.
  exfat-utils kann in Void nicht verfügbar oder veraltet sein.

====================================================================
15. GVFS, UDISKS UND DATEIVERWALTUNG
====================================================================

  xbps-install -y \
    gvfs \
    gvfs-smb \
    udisks2 \
    udiskie \
    dbus \
    elogind \
    polkit \
    polkit-elogind

Optionale GVFS-Unterstützung für Mobilgeräte:

  xbps-install -y gvfs-mtp gvfs-afc

Falls ein optionales Paket nicht existiert:

  xbps-query -Rs gvfs

====================================================================
16. X11-, FONT- UND BILDBIBLIOTHEKEN
====================================================================

  xbps-install -y \
    harfbuzz \
    imlib2 \
    libXft \
    libX11 \
    libXinerama \
    libXrandr \
    libXcursor \
    libXi \
    libXrender \
    fontconfig \
    freetype \
    dejavu-fonts-ttf

HINWEIS:
  Das Paket heißt in Void normalerweise imlib2, nicht imlib.

====================================================================
17. PIPEWIRE UND WIREPLUMBER
====================================================================

  xbps-install -y \
    pipewire \
    wireplumber \
    pipewire-pulse \
    alsa-pipewire \
    libjack-pipewire \
    pulseaudio-utils \
    libspa-bluetooth \
    rtkit \
    xdg-desktop-portal

Beispielkonfiguration für WirePlumber:

  mkdir -p /etc/pipewire/pipewire.conf.d

  ln -sf \
    /usr/share/examples/wireplumber/10-wireplumber.conf \
    /etc/pipewire/pipewire.conf.d/10-wireplumber.conf

PipeWire-Pulse-Konfiguration:

  ln -sf \
    /usr/share/examples/pipewire/20-pipewire-pulse.conf \
    /etc/pipewire/pipewire.conf.d/20-pipewire-pulse.conf

ALSA-PipeWire-Konfiguration:

  mkdir -p /etc/alsa/conf.d

  ln -sf \
    /usr/share/alsa/alsa.conf.d/50-pipewire.conf \
    /etc/alsa/conf.d/50-pipewire.conf

  ln -sf \
    /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf \
    /etc/alsa/conf.d/99-pipewire-default.conf

PipeWire läuft als Benutzerprozess und benötigt eine funktionierende
D-Bus-Benutzersitzung.

====================================================================
18. HOSTNAME UND HOSTS-DATEI
====================================================================

Hostname festlegen:

  echo voidpc > /etc/hostname

Hosts-Datei schreiben:

  cat > /etc/hosts << 'EOF'
127.0.0.1       localhost
::1             localhost
127.0.1.1       voidpc.localdomain voidpc
EOF

====================================================================
19. ZEITZONE UND HARDWARE-UHR
====================================================================

Zeitzone Europe/Berlin setzen:

  ln -sf /usr/share/zoneinfo/Europe/Athens /etc/localtime

Hardware-Uhr auf UTC setzen:

  hwclock --systohc --utc

====================================================================
20. LOCALE EINRICHTEN
====================================================================

Locale-Datei öffnen:

  nano /etc/default/libc-locales

Diese Zeile aktivieren:

  de_DE.UTF-8 UTF-8

Danach Locales neu erzeugen:

  xbps-reconfigure -f glibc-locales

Systemsprache setzen:

  cat > /etc/locale.conf << 'EOF'
LANG=de_DE.UTF-8
LC_COLLATE=C
EOF

====================================================================
21. KONSOLEN-TASTATUR SETZEN
====================================================================

Datei öffnen:

  nano /etc/rc.conf

Folgende Zeile setzen:

  KEYMAP=us

Wenn eine deutsche Tastatur gewünscht ist, stattdessen:

  KEYMAP=de

Font setzen
set font LatGrkCyr-12x22
====================================================================
22. ROOT-PASSWORT SETZEN
====================================================================

  passwd root

Ein sicheres Root-Passwort zweimal eingeben.

====================================================================
23. BENUTZER GEORG ANLEGEN
====================================================================

Benutzer mit Home-Verzeichnis anlegen:

  useradd -m -U -s /bin/bash georg

Passwort setzen:

  passwd georg

Wichtige Gruppen ergänzen:

  usermod -aG audio,video,plugdev,storage,input,users georg

Sudo installieren, falls noch nicht vorhanden:

  xbps-install -y sudo

Benutzer in wheel aufnehmen:

  usermod -aG wheel georg

Sudo-Konfiguration bearbeiten:

  visudo

Diese Zeile aktivieren oder ergänzen:

  %wheel ALL=(ALL:ALL) ALL

Zsh als Login-Shell für georg setzen:

  chsh -s /bin/zsh georg

Home-Rechte korrigieren:

  chown -R georg:georg /home/georg
  chmod 750 /home/georg

====================================================================
24. ZSH-KONFIGURATION FÜR GEORG
====================================================================

Als Benutzer georg wechseln:

  su - georg

Als georg ausführen:

  cat > ~/.zshrc << 'EOF'
autoload -Uz compinit
compinit

export EDITOR=nvim
export VISUAL=nvim
export LANG=de_DE.UTF-8

alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
EOF

Zurück zu root:

  exit

====================================================================
25. NETZWERK AKTIVIEREN
====================================================================

Einfache kabelgebundene Verbindung mit dhcpcd:

  ln -s /etc/sv/dhcpcd /var/service/

Falls der Dienst bereits aktiviert ist, ist das kein Problem.

Für NetworkManager stattdessen:

  xbps-install -y NetworkManager

  rm -f /var/service/dhcpcd

  ln -s /etc/sv/NetworkManager /var/service/

Für WLAN zusätzlich:

  xbps-install -y wpa_supplicant iw wireless-tools

====================================================================
26. SYSTEMDIENSTE AKTIVIEREN
====================================================================

D-Bus:

  ln -s /etc/sv/dbus /var/service/

Elogind:

  ln -s /etc/sv/elogind /var/service/

RTKit:

  ln -s /etc/sv/rtkit /var/service/

Prüfen, ob die Links existieren:

  sv status dbus
  sv status elogind
  sv status rtkit
  sv status dhcpcd

Falls ein Link bereits existiert, keine Änderung erforderlich.

====================================================================
27. GRUB FÜR UEFI INSTALLIEREN
====================================================================

UEFI-GRUB und EFI-Verwaltung installieren:

  xbps-install -y grub-x86_64-efi efibootmgr

Prüfen, ob die EFI-Partition gemountet ist:

  mountpoint /boot/efi

Ausgabe muss ungefähr sein:

  /boot/efi is a mountpoint

GRUB installieren:

  grub-install \
    --target=x86_64-efi \
    --efi-directory=/boot/efi \
    --bootloader-id=Void

GRUB-Konfiguration erzeugen:

  grub-mkconfig -o /boot/grub/grub.cfg

Wenn efibootmgr oder UEFI-NVRAM nicht funktioniert:

  grub-install \
    --target=x86_64-efi \
    --efi-directory=/boot/efi \
    --bootloader-id=Void \
    --no-nvram

Danach erneut:

  grub-mkconfig -o /boot/grub/grub.cfg

====================================================================
28. INITRAMFS UND PAKETE NEU KONFIGURIEREN
====================================================================

  xbps-reconfigure -fa

System aktualisieren:

  xbps-install -S
  xbps-install -yu

====================================================================
29. VOR DEM NEUSTART PRÜFEN
====================================================================

Mounts prüfen:

  findmnt -R /

Btrfs-Subvolumes prüfen:

  btrfs subvolume list /

Fstab prüfen:

  cat /etc/fstab

Bootloader-Datei prüfen:

  ls -l /boot/efi/EFI/Void/
  ls -l /boot/grub/grub.cfg

Benutzer prüfen:

  id georg
  getent passwd georg

Shell prüfen:

  getent passwd georg

Erwartetes Ende der Ausgabe:

  /bin/zsh

Dienste prüfen:

  sv status dbus
  sv status elogind
  sv status rtkit

====================================================================
30. CHROOT VERLASSEN
====================================================================

Chroot verlassen:

  exit

Swap deaktivieren:

  swapoff /dev/sdc2

Alle Mounts unter /mnt aushängen:

  umount -R /mnt

Falls ein Mount noch verwendet wird:

  umount -Rl /mnt

Kontrolle:

  mount | grep /mnt

====================================================================
31. NEUSTART
====================================================================

Live-USB entfernen und neu starten:

  reboot

====================================================================
32. NACH DEM ERSTEN START
====================================================================

Als georg anmelden.

System aktualisieren:

  sudo xbps-install -Su

Mounts prüfen:

  findmnt /
  findmnt /home
  findmnt /var/log
  findmnt /var/cache
  findmnt /tmp
  findmnt /boot/efi

Btrfs-Subvolumes prüfen:

  sudo btrfs subvolume list /

Swap prüfen:

  swapon --show

PipeWire prüfen:

  wpctl status

PulseAudio-Kompatibilität prüfen:

  pactl info

Gruppen prüfen:

  groups

====================================================================
33. WICHTIGE GERÄTEZUORDNUNG
====================================================================

Die gesamte Installation verwendet:

  SSD:       /dev/sdc
  EFI:       /dev/sdc1
  Swap:      /dev/sdc2
  Btrfs:     /dev/sdc3

Nicht verwenden:

  /dev/nvme0n1
  /dev/sda

====================================================================
34. WICHTIGE HINWEISE
====================================================================

1. Die SSD /dev/sdc wird vollständig gelöscht.

2. Bei UEFI wird GRUB mit grub-x86_64-efi installiert.

3. Für den ersten Chroot wird Bash verwendet:

     xchroot /mnt /bin/bash

4. Zsh wird erst nach dem Anlegen von georg als Login-Shell gesetzt.

5. Für Btrfs muss Root mit subvol=@ gemountet werden.

6. /home wird mit subvol=@home gemountet.

7. /var/log wird mit subvol=@log gemountet.

8. /var/cache wird mit subvol=@cache gemountet.

9. /tmp wird mit subvol=@tmp gemountet.

10. Diese Anleitung verwendet eine separate Swap-Partition.
    Das ist einfacher und zuverlässiger als eine Swap-Datei auf Btrfs.

11. Für ExFAT wird exfatprogs verwendet.

12. Für normale 64-Bit-Anwendungen wird Multilib nicht zwingend benötigt.
    Es wird hier trotzdem aktiviert, weil 32-Bit-Programme damit unterstützt
    werden können.

13. PipeWire benötigt nach dem Login eine funktionierende D-Bus-Sitzung.

14. Vor dem Neustart müssen diese Befehle erfolgreich sein:

     xbps-reconfigure -fa
     grub-mkconfig -o /boot/grub/grub.cfg

====================================================================
ENDE DER ANLEITUNG
====================================================================
