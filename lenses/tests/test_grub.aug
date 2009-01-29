module Test_grub =

  let conf = "# grub.conf generated by anaconda
#
# Note that you do not have to rerun grub after making changes to this file
# NOTICE:  You have a /boot partition.  This means that
#          all kernel and initrd paths are relative to /boot/, eg.
#          root (hd0,0)
#          kernel /vmlinuz-version ro root=/dev/vg00/lv00
#          initrd /initrd-version.img
#boot=/dev/sda
password --md5 $1$M9NLj$p2gs87vwNv48BUu.wAfVw0
default=0
timeout=5
splashimage=(hd0,0)/grub/splash.xpm.gz
hiddenmenu
title Fedora (2.6.24.4-64.fc8)
        root (hd0,0)
        kernel /vmlinuz-2.6.24.4-64.fc8 ro root=/dev/vg00/lv00
        initrd /initrd-2.6.24.4-64.fc8.img
title Fedora (2.6.24.3-50.fc8)
        root (hd0,0)
        kernel /vmlinuz-2.6.24.3-50.fc8 ro root=/dev/vg00/lv00
        initrd /initrd-2.6.24.3-50.fc8.img
title Fedora (2.6.21.7-3.fc8xen)
        root (hd0,0)
        kernel /xen.gz-2.6.21.7-3.fc8
        module /vmlinuz-2.6.21.7-3.fc8xen ro root=/dev/vg00/lv00
        module /initrd-2.6.21.7-3.fc8xen.img
title Fedora (2.6.24.3-34.fc8)
        root (hd0,0)
        kernel /vmlinuz-2.6.24.3-34.fc8 ro root=/dev/vg00/lv00
        initrd /initrd-2.6.24.3-34.fc8.img
"

  test Grub.lns get conf =
     {} {} {} {} {} {} {} {} {}
     { "password" = "$1$M9NLj$p2gs87vwNv48BUu.wAfVw0"
       { "md5" } }
     { "default" = "0" }
     { "timeout" = "5" }
     { "splashimage" = "(hd0,0)/grub/splash.xpm.gz" }
     { "hiddenmenu" }
     { "title" = "Fedora (2.6.24.4-64.fc8)"
             { "root" = "(hd0,0)" }
             { "kernel" = "/vmlinuz-2.6.24.4-64.fc8 ro root=/dev/vg00/lv00" }
             { "initrd" = "/initrd-2.6.24.4-64.fc8.img" } }
     { "title" = "Fedora (2.6.24.3-50.fc8)"
             { "root" = "(hd0,0)" }
             { "kernel" = "/vmlinuz-2.6.24.3-50.fc8 ro root=/dev/vg00/lv00" }
             { "initrd" = "/initrd-2.6.24.3-50.fc8.img" } }
     { "title" = "Fedora (2.6.21.7-3.fc8xen)"
             { "root" = "(hd0,0)" }
             { "kernel" = "/xen.gz-2.6.21.7-3.fc8" }
             { "modules" = "/vmlinuz-2.6.21.7-3.fc8xen ro root=/dev/vg00/lv00" }
             { "modules" = "/initrd-2.6.21.7-3.fc8xen.img" } }
     { "title" = "Fedora (2.6.24.3-34.fc8)"
             { "root" = "(hd0,0)" }
             { "kernel" = "/vmlinuz-2.6.24.3-34.fc8 ro root=/dev/vg00/lv00" }
             { "initrd" = "/initrd-2.6.24.3-34.fc8.img" } }

  test Grub.lns put conf after set "default" "0" = conf

  test Grub.lns get "# menu.lst - See: grub(8), info grub, update-grub(8)

## default num\n" = {} {} {}

  (* Color directive *)
  test Grub.lns get "color cyan/blue white/blue\n" =
    { "color"
      { "normal"    { "foreground" = "cyan" }
                    { "background" = "blue" } }
      { "highlight" { "foreground" = "white" }
                    { "background" = "blue" } } }

  test Grub.lns get "\tcolor cyan/light-blue\n" =
    { "color"
      { "normal" { "foreground" = "cyan" }
                 { "background" = "light-blue" } } }

  test Grub.lns put "color cyan/light-blue\n" after
    set "/color/highlight/foreground" "white";
    set "/color/highlight/background" "black"    =
    "color cyan/light-blue white/black\n"

(* Local Variables: *)
(* mode: caml       *)
(* End:             *)
